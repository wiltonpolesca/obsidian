Perfect—now we’ll make this **fully practical with your OSI PI–style time-series** and a **local LLM (Ollama)**.

We’ll build a **mini end-to-end prototype**:

> **Telemetry (OSI PI format) → features → behavior model → insights → LLM explanation**

---

# ✅ 0) Your input format (OSI PI-like)

You said your data looks like:

timestamp | tag_name | value

Example:

2026-06-01 10:00:00 | speed | 45

2026-06-01 10:00:01 | acceleration | 2.1

2026-06-01 10:00:01 | brake_pressure | 0.0

2026-06-01 10:00:02 | payload_weight | 32000

2026-06-01 10:00:03 | engine_rpm | 2100

👉 First challenge: **pivot this into structured features**

---

# ✅ 1) Step 1 — Transform OSI PI → Feature Table

### 🔷 Python example

import pandas as pd

  

# Load raw PI-style data

df = pd.read_csv("telemetry.csv")

  

# Pivot into wide table (one row per timestamp)

df_wide = df.pivot(index="timestamp", columns="tag_name", values="value")

  

df_wide = df_wide.reset_index()

  

print(df_wide.head())

---

### ✅ Output:

timestamp       speed   acceleration   brake_pressure   engine_rpm

10:00:00        45      2.1            0.0              2100

---

# ✅ 2) Step 2 — Feature engineering (behavior signals)

Now we extract **driving behavior features**.

---

## 🔷 Example: detect aggressive driving signals

import numpy as np

  

df_wide['hard_brake'] = df_wide['brake_pressure'] > 0.7

df_wide['rapid_accel'] = df_wide['acceleration'] > 2.5

  

# Aggregate per time window (e.g. per hour / session)

features = {

    "hard_brake_count": df_wide['hard_brake'].sum(),

    "rapid_accel_count": df_wide['rapid_accel'].sum(),

    "avg_speed": df_wide['speed'].mean(),

    "max_rpm": df_wide['engine_rpm'].max()

}

  

print(features)

---

### ✅ Example output:

{

  "hard_brake_count": 45,

  "rapid_accel_count": 32,

  "avg_speed": 52,

  "max_rpm": 3800

}

---

# ✅ 3) Step 3 — Behavior model (simple but powerful)

We’ll create a **rule-based + ML hybrid model**

---

## 🔷 Example behavior scoring

def compute_driver_score(features):

    score = 100

    score -= features['hard_brake_count'] * 0.5

    score -= features['rapid_accel_count'] * 0.4

    if features['max_rpm'] > 3500:

        score -= 10

    return max(score, 0)

  

score = compute_driver_score(features)

  

print("Driver Score:", score)

---

### ✅ Output:

Driver Score: 62

``

---

## 🔷 Classify behavior

def classify_driver(score):

    if score > 80:

        return "smooth"

    elif score > 60:

        return "normal"

    else:

        return "aggressive"

  

profile = classify_driver(score)

  

print(profile)

---

# ✅ 4) Step 4 — Create structured insight (CRUCIAL step)

👉 This is what the LLM will consume

insight = {

    "type": "driver_behavior",

    "driver_id": "D123",

    "score": score,

    "profile": profile,

    "evidence": {

        "hard_brakes": features["hard_brake_count"],

        "rapid_acceleration": features["rapid_accel_count"],

        "max_rpm": features["max_rpm"]

    },

    "risk": "increased brake and engine wear"

}

``

---

# ✅ 5) Step 5 — Connect to local LLM (Ollama)

---

## 🔷 Install & run model

ollama pull mistral

---

## 🔷 Python LLM call

import requests

  

def ask_llm(insight):

    prompt = f"""

You are a fleet data analyst.

  

Analyze the following driver insight and explain:

  

- behavior

- risks

- recommendations

  

Insight:

{insight}

"""

  

    response = requests.post(

        "[http://localhost:11434/api/generate](http://localhost:11434/api/generate)",

        json={

            "model": "mistral",

            "prompt": prompt,

            "stream": False

        }

    )

  

    return response.json()['response']

  
  

result = ask_llm(insight)

  

print(result)

---

### ✅ Example output:

```
Driver D123 shows an aggressive driving pattern, with a high number of hard braking events (45) and rapid accelerations (32).

This behavior increases mechanical stress on the braking system and engine components, particularly due to elevated RPM levels.

If continued, this may lead to accelerated brake wear and higher maintenance costs.

Recommendation:
- Encourage smoother acceleration and braking habits
- Monitor RPM thresholds
- Consider driver training programs
```

---

# ✅ 6) Step 6 — Add anomaly detection (important upgrade)

---

## 🔷 Example with Isolation Forest

from sklearn.ensemble import IsolationForest

  

# Build dataset of multiple sessions

feature_df = pd.DataFrame([

    features,  # current

    # add historical data here

])

  

model = IsolationForest(contamination=0.1)

model.fit(feature_df)

  

feature_df['anomaly'] = model.predict(feature_df)

  

print(feature_df)

---

### Output:

```
-1 → anomaly
 1 → normal
```

---

# ✅ 7) Step 7 — Feeding anomalies into LLM

if feature_df.iloc[0]['anomaly'] == -1:

    insight['type'] = "anomaly"

    insight['message'] = "Unusual driving pattern detected"

``

---

# ✅ 8) Final architecture for your PoC

```
OSI PI Data
   ↓
Pivot (timestamp, tag → columns)
   ↓
Feature Engineering
   ↓
Behavior Models (rules + ML)
   ↓
Insight Object (JSON)
   ↓
Local LLM (Ollama)
   ↓
Human-readable insights
```

---

# ✅ 9) Why this works (important insight)

👉 You are NOT doing:

- “LLM learns telemetry”

👉 You ARE doing:

- Convert telemetry → **semantic signals**
- Detect patterns via ML
- Use LLM → **interpretation layer**

---

# ✅ 10) Next step (if you want to go deeper)

We can extend this into:

✅ Real-time pipeline (Kafka + streaming)  
✅ Multi-truck + fleet benchmarking  
✅ Predict **specific component damage (brakes, suspension)**  
✅ Build a **Streamlit dashboard**

---

# ✅ Final takeaway

You now have a **real, production-style pattern**:

> **Time-series → Features → Models → Insights → LLM explanations**

---

If you want, I can next:

- Turn this into a **full runnable repo structure**
- Add **real damage prediction model (brakes/suspension)**
- Or design a **complete enterprise architecture slide**

Just tell me 👍