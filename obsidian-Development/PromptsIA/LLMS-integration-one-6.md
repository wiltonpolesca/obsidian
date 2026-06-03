3Great—this is where your system becomes a **real enterprise-grade AI platform**.

We’ll extend your architecture with:

✅ **Kafka (real-time telemetry ingestion)**  
✅ **Streaming processing (feature extraction + detection)**  
✅ **LLM agent + tools**  
✅ **Dashboard (Streamlit)**

I’ll give you a **practical blueprint + runnable structure**.

---

# ✅ 1) Final Target Architecture

```
        Trucks / Sensors
              ↓
         Kafka Topics
              ↓
     Stream Processor (Python)
   (features + anomaly detection)
              ↓
         Insight Topic (Kafka)
              ↓
        ┌──────────────┐
        │   LLM Agent  │
        └──────┬───────┘
               ↓
         Insight Store (DB/JSON)
               ↓
         Streamlit Dashboard
```

---

# ✅ 2) Kafka Setup (topics design)

Create topics:

kafka-topics.sh --create --topic telemetry

kafka-topics.sh --create --topic features

kafka-topics.sh --create --topic insights

---

## 🔷 Message formats

### 🔹 telemetry topic

{

  "timestamp": "2026-06-03T10:00:00",

  "truck_id": "T1",

  "driver_id": "D1",

  "tag": "brake_pressure",

  "value": 0.8

}

---

### 🔹 features topic

{

  "truck_id": "T1",

  "driver_id": "D1",

  "window": "5min",

  "hard_brake_count": 5,

  "avg_speed": 52

}

---

### 🔹 insights topic

{

  "driver_id": "D1",

  "insight": "Aggressive driving detected",

  "risk": "Brake wear",

  "severity": "high"

}

---

# ✅ 3) Kafka Producer (simulate telemetry)

# producer.py

from kafka import KafkaProducer

import json, time, random

  

producer = KafkaProducer(

    bootstrap_servers='localhost:9092',

    value_serializer=lambda v: json.dumps(v).encode('utf-8')

)

  

tags = ["speed", "brake_pressure", "acceleration"]

  

while True:

    msg = {

        "timestamp": time.time(),

        "truck_id": "T1",

        "driver_id": "D1",

        "tag": random.choice(tags),

        "value": random.uniform(0, 100)

    }

  

    producer.send("telemetry", msg)

    time.sleep(0.5)

---

# ✅ 4) Streaming processor (real-time feature engine)

This replaces batch Python.

# processor.py

from kafka import KafkaConsumer, KafkaProducer

import json

from collections import defaultdict

  

consumer = KafkaConsumer(

    'telemetry',

    bootstrap_servers='localhost:9092',

    value_deserializer=lambda m: json.loads(m.decode('utf-8'))

)

  

producer = KafkaProducer(

    bootstrap_servers='localhost:9092',

    value_serializer=lambda v: json.dumps(v).encode('utf-8')

)

  

buffer = defaultdict(list)

  

for msg in consumer:

    data = msg.value

    key = (data["truck_id"], data["driver_id"])

    buffer[key].append(data)

  

    # simple window

    if len(buffer[key]) >= 20:

        records = buffer[key]

  

        hard_brakes = sum(

            1 for r in records

            if r["tag"] == "brake_pressure" and r["value"] > 0.7

        )

  

        speeds = [r["value"] for r in records if r["tag"] == "speed"]

        avg_speed = sum(speeds)/len(speeds) if speeds else 0

  

        features = {

            "truck_id": key[0],

            "driver_id": key[1],

            "hard_brake_count": hard_brakes,

            "avg_speed": avg_speed

        }

  

        producer.send("features", features)

        buffer[key] = []

``

---

# ✅ 5) LLM Insight Generator (Kafka consumer)

Now the LLM becomes active in the pipeline.

# llm_agent.py

from kafka import KafkaConsumer, KafkaProducer

import json, requests

  

consumer = KafkaConsumer(

    'features',

    bootstrap_servers='localhost:9092',

    value_deserializer=lambda m: json.loads(m.decode('utf-8'))

)

  

producer = KafkaProducer(

    bootstrap_servers='localhost:9092',

    value_serializer=lambda v: json.dumps(v).encode('utf-8')

)

  

def ask_llm(features):

    prompt = f"""

You are a fleet AI analyst.

  

Analyze:

{features}

  

Detect:

- driving behavior

- risks

- anomalies

  

Return JSON:

{{"insight": "...", "risk": "...", "severity": "..."}}

"""

  

    r = requests.post(

        "[http://localhost:11434/api/generate](http://localhost:11434/api/generate)",

        json={"model": "mistral", "prompt": prompt, "stream": False}

    )

    return json.loads(r.json()["response"])

  
  

for msg in consumer:

    features = msg.value

  

    insight = ask_llm(features)

  

    output = {

        "driver_id": features["driver_id"],

        **insight

    }

  

    producer.send("insights", output)

---

# ✅ 6) Streamlit Dashboard (LIVE UI)

This is your **fleet intelligence interface**.

---

## 🔷 Install

pip install streamlit kafka-python pandas

---

## 🔷 Dashboard code

# dashboard.py

import streamlit as st

from kafka import KafkaConsumer

import json

  

st.title("🚛 Fleet AI Dashboard")

  

consumer = KafkaConsumer(

    'insights',

    bootstrap_servers='localhost:9092',

    value_deserializer=lambda m: json.loads(m.decode('utf-8')),

    auto_offset_reset='latest'

)

  

placeholder = st.empty()

  

insights = []

  

for msg in consumer:

    data = msg.value

    insights.append(data)

  

    with placeholder.container():

        st.subheader("Latest Insights")

  

        for i in reversed(insights[-5:]):

            st.write(f"Driver: {i['driver_id']}")

            st.write(f"Insight: {i['insight']}")

            st.write(f"Risk: {i['risk']}")

            st.write(f"Severity: {i['severity']}")

            st.markdown("---")

---

# ✅ 7) Run Everything

### Terminal 1:

python producer.py

### Terminal 2:

python processor.py

### Terminal 3:

python llm_agent.py

### Terminal 4:

streamlit run dashboard.py

---

# ✅ 8) What you now have

🔥 A **real-time AI system**:

- Streaming telemetry ✅
- Automatic feature extraction ✅
- LLM-driven insight generation ✅
- Live dashboard ✅

---

# ✅ 9) Where the LLM adds real value here

Before:

- Static rules

Now:

- Dynamic interpretation
- Context-aware risk analysis
- Natural language explanations
- Adaptability without rewriting logic

---

# ✅ 10) Next upgrades (high impact)

If you want to push this toward production:

---

## 🔷 Add real ML models

- Isolation Forest for anomalies
- Driver clustering

---

## 🔷 Add memory

- Store insights in DB
- Compare historical behavior

---

## 🔷 Add multi-truck analytics

- Benchmark drivers
- Fleet ranking

---

## 🔷 Add alerts

- Slack / email when severity = high

---

## 🔷 Add semantic layer

- YAML rules feeding the LLM

---

# ✅ Final takeaway

You now have:

> **A streaming AI system where Kafka feeds intelligence, ML detects signals, and LLM explains and adapts in real time.**

---

If you want next step, I can:

✅ Containerize everything (Docker Compose)  
✅ Add real OSI PI connector  
✅ Add advanced anomaly detection + prediction  
✅ Turn dashboard into a full web app (React + API)

Just tell me 👍