Yes, you can absolutely build this entire local LLM environment using **Docker** and **Docker Compose**.

Because your architecture separates the "Fast Path" (high-frequency telemetry streaming) from the "Slow Path" (asynchronous LLM analysis), Docker is the perfect tool to containerize each service, isolate their dependencies, and ensure they communicate reliably over a shared internal network.

Below is an production-ready guide and configuration to spin up your **Mine Fleet AI Intelligence System** locally.

### 📋 Prerequisites & Hardware Check

Running local LLMs (Mistral/Llama) requires computational power. Ensure your host machine meets these requirements:

- **Docker & Docker Compose V2** installed.
    
- **NVIDIA Container Toolkit** installed (if you want to use a local GPU for fast LLM inference). If you don't have a dedicated GPU, Ollama will run on CPU, but it will be significantly slower.
    

### 📂 1. Directory Structure

Create a root folder on your machine with the following file layout:

Plaintext

```
mine-fleet-ai/
├── docker-compose.yml
├── telemetry-processor/
│   ├── Dockerfile
│   └── main.py
└── llm-agent/
    ├── Dockerfile
    └── agent.py
```

### 🐳 2. The Master `docker-compose.yml`

This configuration sets up the infrastructure backbone: **Apache Kafka** (via KRaft mode, no Zookeeper needed), **DuckDB/PostgreSQL** (for storing operational context and generated insights), **Ollama** (configured to use your GPU), and placeholders for your processing code.

YAML

```
version: '3.8'

networks:
  fleet-network:
    driver: bridge

services:
  # --- 1. KAFKA STREAMING BROKER (In KRaft Mode) ---
  kafka:
    image: apache/kafka:latest
    container_name: fleet-kafka
    networks:
      - fleet-network
    ports:
      - "9092:9092"
    environment:
      KAFKA_NODE_ID: 1
      KAFKA_PROCESS_ROLES: broker,controller
      KAFKA_LISTENERS: PLAINTEXT://0.0.0.0:9092,CONTROLLER://0.0.0.0:9093
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://kafka:9092
      KAFKA_CONTROLLER_LISTENER_NAMES: CONTROLLER
      KAFKA_CONTROLLER_QUORUM_VOTERS: 1@kafka:9093
      KAFKA_LOG_DIRS: /tmp/kraft-combined-logs
      CLUSTER_ID: MkU3OEVBNTcwNTJENDM2Qk

  # --- 2. OLLAMA LOCAL LLM ENGINE ---
  ollama:
    image: ollama/ollama:latest
    container_name: fleet-ollama
    networks:
      - fleet-network
    ports:
      - "11434:11434"
    volumes:
      - ollama_storage:/root/.ollama
    # Remove the deploy section below if you are running ONLY on a CPU
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: all
              capabilities: [gpu]
    environment:
      - OLLAMA_NUM_PARALLEL=4

  # --- 3. DATABASE LAYER (PostgreSQL for Insights & Context) ---
  db:
    image: postgres:15-alpine
    container_name: fleet-db
    networks:
      - fleet-network
    ports:
      - "5432:5432"
    environment:
      POSTGRES_USER: fleet_admin
      POSTGRES_PASSWORD: mine_secure_pass
      POSTGRES_DB: fleet_intelligence
    volumes:
      - db_storage:/var/lib/postgresql/data

  # --- 4. AUTO-DOWNLOAD WORKER (Initializes your LLM Model) ---
  ollama-provisioner:
    image: curlimages/curl:latest
    container_name: fleet-ollama-provisioner
    networks:
      - fleet-network
    depends_on:
      - ollama
    entrypoint: [ "/bin/sh", "-c" ]
    command: |
      "
      echo 'Waiting for Ollama to wake up...'
      until curl -s http://ollama:11434/api/tags > /dev/null; do sleep 3; done
      echo 'Pulling Mistral model...'
      curl -X POST http://ollama:11434/api/pull -d '{\"name\": \"mistral\"}'
      echo 'Model ready!'
      "

volumes:
  ollama_storage:
  db_storage:
```

### 🐍 3. Building Your Application Containers

To plug your actual code into this Docker environment, you will create custom Dockerfiles for your stream processors and agents.

#### Container A: The Streaming Telemetry Processor

This service consumes raw telemetry, extracts feature windows, and passes them along.

- **`telemetry-processor/Dockerfile`**:
    
    Dockerfile
    
    ```
    FROM python:3.11-slim
    WORKDIR /app
    RUN pip install --no-cache-dir kafka-python pandas scikit-learn
    COPY . .
    CMD ["python", "main.py"]
    ```
    

#### Container B: The FastAPI LLM Integration Agent

This service interacts with Ollama, forces the strict structured JSON formats, and writes outputs to the database.

- **`llm-agent/Dockerfile`**:
    
    Dockerfile
    
    ```
    FROM python:3.11-slim
    WORKDIR /app
    RUN pip install --no-cache-dir fastapi uvicorn requests psycopg2-binary kafka-python
    COPY . .
    EXPOSE 8000
    CMD ["uvicorn", "agent.py", "--host", "0.0.0.0", "--port", "8000"]
    ```
    

### 🚀 4. Step-by-Step Guide to Spin Up and Test

Once your files are configured, execute the following commands in your terminal to initialize your architecture:

#### Step 1: Fire up the base infrastructure

Bash

```
docker-compose up -d kafka ollama db ollama-provisioner
```

_This command runs the database, streaming queue, and local AI container in the background. The provisioner will automatically download the compressed `mistral` model._

#### Step 2: Monitor model downloading status

Bash

```
docker logs -f fleet-ollama-provisioner
```

Wait until you see `"Model ready!"` in the console logs.

#### Step 3: Verify Ollama works over the internal Docker network

Run a manual curl check against the running container to see if the model answers:

Bash

```
docker exec -it fleet-ollama curl -X POST http://localhost:11434/api/generate \
  -d '{"model": "mistral", "prompt": "Identify a risk if gear position is 1st and engine RPM is 4500", "stream": false}'
```

#### Step 4: Run your application layers

Once the core infrastructure components are online and verified, you can attach your custom python logic elements via the compose command:

Bash

```
# Add your custom python services to docker-compose.yml as needed and run:
docker-compose up -d --build
```

### 💡 Tips for Development Inside This Docker Setup

- **Service Hostnames:** Inside the docker network, services talk to each other using their service names. Your Python scripts should connect to Kafka at `kafka:9092`, Ollama at `http://ollama:11434`, and PostgreSQL at `db:5432`.
    
- **VRAM access:** If you hit errors regarding GPU usage, ensure you can run `nvidia-smi` successfully on your host terminal and that the `nvidia-container-runtime` is registered inside your Docker engine daemon config.