"""Gera embeddings (paraphrase-multilingual-MiniLM-L12-v2, local/ONNX) -> embeddings.npy
Cada chunk é dividido em janelas de ~600 caracteres (limite do modelo: 128 tokens);
na busca, a similaridade do chunk é a maior entre suas janelas."""
import sqlite3, time
from pathlib import Path

import numpy as np
from fastembed import TextEmbedding

HERE = Path(__file__).parent
MODEL = "sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2"
WIN, STEP = 600, 450


def windows(text):
    i = 0
    while True:
        yield text[i:i + WIN]
        if i + WIN >= len(text):
            break
        i += STEP


def main():
    con = sqlite3.connect(HERE / "rag.db")
    texts, owners = [], []
    for rid, content in con.execute("SELECT rowid, content FROM chunks ORDER BY rowid"):
        for w in windows(content):
            if len(w.strip()) > 30:
                texts.append(w)
                owners.append(rid)
    print(len(texts), "janelas", flush=True)
    model = TextEmbedding(MODEL)
    out, t0 = [], time.time()
    for i, v in enumerate(model.embed(texts, batch_size=64), 1):
        out.append(v.astype(np.float32))
        if i % 1000 == 0:
            print(f"{i}/{len(texts)}  {time.time() - t0:.0f}s", flush=True)
    emb = np.vstack(out)
    emb /= np.linalg.norm(emb, axis=1, keepdims=True)
    np.save(HERE / "embeddings.npy", emb)
    np.save(HERE / "embedding_ids.npy", np.array(owners, dtype=np.int64))
    print("ok")


if __name__ == "__main__":
    main()
