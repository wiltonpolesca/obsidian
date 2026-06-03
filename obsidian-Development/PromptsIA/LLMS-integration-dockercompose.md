Absolutely—this is the final step to make everything **runnable in one command** ✅

Below is a **complete Docker Compose setup** that includes:

✅ Kafka + Zookeeper  
✅ FastAPI backend  
✅ LLM (Ollama with Mistral/Llama)  
✅ Processor (features + ML)  
✅ LLM agent  
✅ React frontend  
✅ Optional: model preload

---

# ✅ 1) Folder Structure (IMPORTANT)

Create this structure:

```
fleet-ai/
│
├── docker-compose.yml
│
├── backend/
│   ├── api.py
│   └── requirements.txt
│
├── processor/
│   ├── processor.py
│   ├── anomaly_model.pkl
│   ├── damage_model.pkl
│   └── requirements.txt
│
├── llm_agent/
│   ├── llm_agent.py
│   └── requirements.txt
│
├── producer/
│   └── producer.py
│
├── frontend/
│   ├── Dockerfile
│   └── (React app)
```

---

# ✅ 2) Docker Compose (CORE)

version: "3.9"

  

services:

  

  zookeeper:

    image: confluentinc/cp-zookeeper:latest

    environment:

      ZOOKEEPER_CLIENT_PORT: 2181

  

  kafka:

    image: confluentinc/cp-kafka:latest

    depends_on:

      - zookeeper

    ports:

      - "9092:9092"

    environment:

      KAFKA_ZOOKEEPER_CONNECT: zookeeper:2181

      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://kafka:9092

      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1

  

  ollama:

    image: ollama/ollama

    ports:

      - "11434:11434"

    volumes:

      - ollama_data:/root/.ollama

  

  producer:

    build: ./producer

    depends_on:

      - kafka

  

  processor:

    build: ./processor

    depends_on:

      - kafka

  

  llm_agent:

    build: ./llm_agent

    depends_on:

      - kafka

      - ollama

  

  backend:

    build: ./backend

    ports:

      - "8000:8000"

    depends_on:

      - kafka

  

  frontend:

    build: ./frontend

    ports:

      - "3000:3000"

    depends_on:

      - backend

  

volumes:

  ollama_data:

---

# ✅ 3) Kafka topic initialization (VERY IMPORTANT)

Add a simple init script or run manually:

docker exec -it <kafka_container> kafka-topics </span>

  --create --topic telemetry --bootstrap-server kafka:9092

  

docker exec -it <kafka_container> kafka-topics </span>

  --create --topic features --bootstrap-server kafka:9092

  

docker exec -it <kafka_container> kafka-topics </span>

  --create --topic insights --bootstrap-server kafka:9092

---

# ✅ 4) Processor with ML (inside Docker)

---

## processor/requirements.txt

```
kafka-python
pandas
scikit-learn
joblib
numpy
```

---

## processor/Dockerfile

FROM python:3.10

  

WORKDIR /app

  

COPY . .

  

RUN pip install --no-cache-dir -r requirements.txt

  

CMD ["python", "processor.py"]

---

## processor.py (IMPORTANT PART)

from kafka import KafkaConsumer, KafkaProducer

import json, joblib, numpy as np

from collections import defaultdict

  

consumer = KafkaConsumer(

    'telemetry',

    bootstrap_servers='kafka:9092',

    value_deserializer=lambda m: json.loads(m.decode())

)

  

producer = KafkaProducer(

    bootstrap_servers='kafka:9092',

    value_serializer=lambda v: json.dumps(v).encode()

)

  

anomaly_model = joblib.load("anomaly_model.pkl")

damage_model = joblib.load("damage_model.pkl")

  

buffer = defaultdict(list)

  

for msg in consumer:

    data = msg.value

    key = (data["truck_id"], data["driver_id"])

    buffer[key].append(data)

  

    if len(buffer[key]) >= 20:

        records = buffer[key]

  

        hard_brakes = sum(

            1 for r in records

            if r["tag"] == "brake_pressure" and r["value"] > 0.7

        )

  

        speeds = [r["value"] for r in records if r["tag"] == "speed"]

        avg_speed = sum(speeds) / len(speeds) if speeds else 0

  

        features = {

            "truck_id": key[0],

            "driver_id": key[1],

            "hard_brake_count": hard_brakes,

            "avg_speed": avg_speed

        }

  

        X = np.array([[hard_brakes, avg_speed]])

  

        features["anomaly"] = (

            "anomaly" if anomaly_model.predict(X)[0] == -1 else "normal"

        )

  

        features["predicted_damage"] = float(damage_model.predict(X)[0])

  

        producer.send("features", features)

  

        buffer[key] = []

---

# ✅ 5) LLM Agent (Dockerized)

---

## llm_agent/requirements.txt

```
kafka-python
requests
```

---

## llm_agent/Dockerfile

FROM python:3.10

  

WORKDIR /app

  

COPY . .

  

RUN pip install -r requirements.txt

  

CMD ["python", "llm_agent.py"]

---

## llm_agent.py

from kafka import KafkaConsumer, KafkaProducer

import json, requests

  

consumer = KafkaConsumer(

    'features',

    bootstrap_servers='kafka:9092',

    value_deserializer=lambda m: json.loads(m.decode())

)

  

producer = KafkaProducer(

    bootstrap_servers='kafka:9092',

    value_serializer=lambda v: json.dumps(v).encode()

)

  

def ask_llm(features):

    prompt = f"""

You are a fleet AI analyst.

  

Data:

{features}

  

Explain behavior and risks. Output JSON.

"""

  

    r = requests.post(

        "[http://ollama:11434/api/generate](http://ollama:11434/api/generate)",

        json={"model": "mistral", "prompt": prompt, "stream": False}

    )

  

    return {"insight": r.json()["response"], "risk": "derived", "severity": "medium"}

  
  

for msg in consumer:

    features = msg.value

    result = ask_llm(features)

  

    producer.send("insights", {

        **features,

        **result

    })

---

# ✅ 6) Backend API (FastAPI)

---

## backend/Dockerfile

FROM python:3.10

  

WORKDIR /app

COPY . .

RUN pip install fastapi uvicorn kafka-python

  

CMD ["uvicorn", "api:app", "--host", "0.0.0.0", "--port", "8000"]

---

## api.py

from fastapi import FastAPI

from kafka import KafkaConsumer

import threading, json

  

app = FastAPI()

insights = []

  

def consume():

    consumer = KafkaConsumer(

        'insights',

        bootstrap_servers='kafka:9092',

        value_deserializer=lambda m: json.loads(m.decode())

    )

  

    for msg in consumer:

        insights.append(msg.value)

        if len(insights) > 100:

            insights.pop(0)

  

threading.Thread(target=consume, daemon=True).start()

  

@app.get("/insights")

def get_insights():

    return insights

---

# ✅ 7) Frontend (React minimal Docker)

---

## frontend/Dockerfile

FROM node:18

  

WORKDIR /app

  

COPY . .

  

RUN npm install

  

CMD ["npm", "start"]

---

# ✅ 8) VERY IMPORTANT — Load LLM model

After starting:

docker exec -it <ollama_container> ollama pull mistral

``

---

# ✅ 9) Run Everything

docker compose up --build

---

# ✅ 10) Access

- React UI → [http://localhost:3000](http://localhost:3000/)
- API → [http://localhost:8000/insights](http://localhost:8000/insights)
- LLM → [http://localhost:11434](http://localhost:11434/)

---

# ✅ 11) What you now have

This is a **complete enterprise-like platform**:

✅ Real-time ingestion (Kafka)  
✅ ML anomaly detection + prediction  
✅ LLM reasoning (local, secure)  
✅ API layer  
✅ Web frontend

---

# ✅ 12) Next production upgrades

If you go further:

- Add **Kafka UI (for debugging)**
- Replace file models with **MLflow**
- Add **auth (JWT)** to API
- Add **multi-tenant fleet separation**

---

# ✅ Final takeaway

You now have:

> **A fully containerized, real-time AI analytics platform combining streaming + ML + LLM + web UI**

---

If you want next, I can:

✅ Provide a **GitHub-ready repo (clean + documented)**  
✅ Add **CI/CD pipeline (GitHub Actions)**  
✅ Convert this into **cloud-native (Azure Event Hub, AKS)**

Just tell me 👍