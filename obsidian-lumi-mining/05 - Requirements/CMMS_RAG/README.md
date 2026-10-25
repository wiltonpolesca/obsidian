# CMMS_RAG

Base de busca **híbrida** (semântica + lexical BM25, fusão RRF) 100% local sobre `../CMMS/Maintenance Asset Management`. Não inclui os casos de uso nem a análise documental.

- 144 arquivos (PDF, DOCX, PPTX, XLS, XLSX), ~6.200 chunks. Cada resultado traz arquivo e página/aba/slide.
- Embeddings: `paraphrase-multilingual-MiniLM-L12-v2` (ONNX via fastembed). Perguntas em português recuperam texto em inglês. Cada chunk é dividido em janelas de 600 caracteres e vale a maior similaridade.
- `python ingest.py` reconstrói `rag.db` (texto + índice BM25); depois `python embed.py` gera `embeddings.npy` (~15 min em CPU). Rode os dois após mudar a fonte.
- Consulta: `python query.py "como o orçamento é comparado ao realizado?" -k 8 [--area "Training Manual"] [--mode hybrid|semantic|bm25] [--full]`
- Dependências: pymupdf, python-docx, python-pptx, openpyxl, xlrd, fastembed, numpy.

Para respostas sintetizadas, peça ao Copilot para consultar `query.py` e citar arquivo/página.
