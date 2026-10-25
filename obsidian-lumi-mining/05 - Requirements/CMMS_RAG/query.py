"""Busca híbrida (semântica + BM25, fusão RRF).
Uso: python query.py "como é feito o orçamento vs realizado?" [-k 8] [--area "Training Manual"] [--full] [--mode hybrid|semantic|bm25]"""
import argparse, re, sqlite3, sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")

import numpy as np

HERE = Path(__file__).parent
DB = HERE / "rag.db"
MODEL = "sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2"
_state = {}


def bm25(con, q, n, area):
    terms = re.findall(r"\w+", q, re.UNICODE)
    if not terms:
        return []
    sql = "SELECT rowid FROM chunks WHERE chunks MATCH ?"
    args = [" OR ".join(f'"{t}"' for t in terms)]
    if area:
        sql += " AND area LIKE ?"
        args.append(f"%{area}%")
    sql += " ORDER BY bm25(chunks, 1.0, 0, 0, 0.5) LIMIT ?"
    args.append(n)
    return [r[0] for r in con.execute(sql, args)]


def semantic(con, q, n, area):
    if "model" not in _state:
        from fastembed import TextEmbedding
        _state["model"] = TextEmbedding(MODEL)
        _state["emb"] = np.load(HERE / "embeddings.npy")
        _state["ids"] = np.load(HERE / "embedding_ids.npy")
    qv = next(iter(_state["model"].embed([q])))
    sims = _state["emb"] @ (qv / np.linalg.norm(qv))
    best = {}
    for rid, s in zip(_state["ids"].tolist(), sims.tolist()):
        if s > best.get(rid, -1):
            best[rid] = s
    order = sorted(best, key=best.get, reverse=True)
    if area:
        ok = {r[0] for r in con.execute("SELECT rowid FROM chunks WHERE area LIKE ?", (f"%{area}%",))}
        order = [r for r in order if r in ok]
    return order[:n]


def search(q, k=8, area=None, mode="hybrid"):
    con = sqlite3.connect(DB)
    pool = max(50, k * 5)
    lists = []
    if mode in ("hybrid", "bm25"):
        lists.append(bm25(con, q, pool, area))
    if mode in ("hybrid", "semantic") and (HERE / "embeddings.npy").exists():
        lists.append(semantic(con, q, pool, area))
    score = {}
    for l in lists:
        for rank, rid in enumerate(l):
            score[rid] = score.get(rid, 0) + 1 / (60 + rank)
    top = sorted(score, key=score.get, reverse=True)[:k]
    out = []
    for rid in top:
        path, loc, content = con.execute("SELECT path, loc, content FROM chunks WHERE rowid=?", (rid,)).fetchone()
        out.append((path, loc, content, score[rid]))
    return out


if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("query")
    ap.add_argument("-k", type=int, default=8)
    ap.add_argument("--area")
    ap.add_argument("--mode", default="hybrid", choices=["hybrid", "semantic", "bm25"])
    ap.add_argument("--full", action="store_true", help="imprime o chunk completo")
    a = ap.parse_args()
    for i, (path, loc, content, s) in enumerate(search(a.query, a.k, a.area, a.mode), 1):
        print(f"\n#{i}  {path}  {loc}  (rrf {s:.4f})")
        print(content if a.full else content[:500].replace("\n", " "))
