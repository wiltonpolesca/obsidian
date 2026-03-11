graph TD
    Main[O LIVRO DOS ESPÍRITOS] --> Nucleo[<b>Núcleo Central:</b><br/>Parte Primeira Cap. 1 ao 4<br/>Parte Segunda Cap. 1 ao 6]

    %% Second Level Connections
    Nucleo --> P2_6_11[Parte Segunda<br/>Mundo espírita<br/>Capítulos 6 ao 11]
    Nucleo --> P3_1_12[Parte Terceira<br/>Leis Morais<br/>Capítulos 1 ao 12]
    Nucleo --> P4_1_2[Parte Quarta<br/>Esperanças e consolações<br/>Capítulos 1 e 2]
    Nucleo --> MultiPart[Parte Primeira Cap. 2, 3 e 4<br/>Parte Segunda Cap. 9, 10 e 11<br/>Parte Terceira Cap. 4 e 5]
    Nucleo --> Intro[Introdução e Prolegômenos]

    %% Third Level (Books)
    P2_6_11 <--> Mediums[Base para a construção de<br/><b>O livro dos médiuns</b>]
    P3_1_12 <--> Evangelho[Base para a construção de<br/><b>O evangelho segundo o espiritismo</b>]
    P4_1_2 <--> CeuInferno[Base para a construção de<br/><b>O céu e o inferno</b>]
    MultiPart <--> Genese[Base para a construção de<br/><b>A gênese</b>]
    Intro <--> OqueE[Base para a construção de<br/><b>O que é o espiritismo</b>]

    %% Specific Formatting
    style Main fill:#fff,stroke:#333,stroke-width:2px
    style Nucleo fill:#f9f9f9,stroke:#333,stroke-width:1px