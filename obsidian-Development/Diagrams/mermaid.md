# Mermaid

## Diagram types

- erDiagram
- graph/flowchart [DIRECTION]
  - TD[TB] -> Top to Down
  - LR -> Left to Right
  - BT -> Bottom to Top
  - RL -> Right to Left
- sequenceDiagram
-

```mermaid
graph LR
  subgraph "one"
    Box1-..-> |connection description|Box2
    Box3 ==> box4
    Box5 == connection description ==> box6

    Box7 --> Box8 & Box9 --> box10

  end
  subgraph "two"
  B["fa:fa-twitter for peace"]
    B-->C[fa:fa-ban forbidden]
    B-->D(fa:fa-spinner)
    B-->E(A fa:fa-camera-retro perhaps?)
  end
``` 

``` 
   A & B --> C & D

   it is the same as
    A --> C
    A --> D
    B --> C
    B --> D

```

```mermaid
flowchart LR
  A e1@==> B
  e1@{ animate: true }
```

```mermaid

graph TD
  A[a retangle] --It is a description in theline
  B(with round edges)---
  C([astadium-shaped]) ---
  D[[sub-routine]]---
  E{It is a conditional}---
  F>Asymmetric shape]
  G[(Database)]---
  H((Circle))---
  i{rhombus}---
  j{{Hexagon}}
  k[/Parallelogram/]---
  l[\Parallelogram alt\]---
  m[/trapezoid\]---
  m1[/trapezoid alt\]---
  n{{double circle}}
  O@{ shape: bolt }---
  O2@{ shape: notch-rect, label: "Card" }---
  O3@{ shape: docs, label: "Multiple Documents"}---
  O4@{ shape: manual-input, label: "User Input"}---
  O5@{ shape: procs, label: "Process Automation"}
  
```

Other types of shape `id@{shape: [type]}` : https://mermaid.ai/open-source/syntax/flowchart.html#complete-list-of-new-shapes

## Shapes type


