# OSI-Pi

  

Tipos de filtro de exclusão

  

## Filtros

  

Verifia se o valor recevido difere do último valor recebido em mais de uma "regra de excecão".

  

Se a mudança for menor que o desvio permiotido, o novo ponto é descartado por ser considerado ruído.

  

O objetivo é reduzir o volume de dados logo na entrada, eliminando valores que não representam uma mudança substancial.

  

*Snapshot*

  

Os dados que passam pelo teste de excessão vão para o snapshot, lá se tem o valor mais recente (e qualificado) de cada TAG (último valor recebido por TAG)

  

*Compressão*

  

Os dados do snapshot são então avaliados pelo algorítimo de compressão para saber se será ou não arquivado

  

=> Algorítimo: Porta Oscilante (swinging door)

  

### Exception deviation

  

Desvío mínimo que um valor deve ter em relação ao último valor enviado para o snapshot para ser considerado e não descartado.

  

### Compression deviation

  

O desvío móinimo que um novo valor deve ter em relação à linha de cpmpressão para ser arquivado.

  

## Exceções

  

### 1 - Exception deviator (exc dev)  

  

Verifica a diferença absoluta entre o novo valor e o último recebido (ignorando o sinal)

  

A configuração deve ser menor ou igual à precisão o instrumento/sensor

- precisão: 0.1c

- exc dev: de 0.05c à 0.1 c

  

### 2 - Exception deviation percent (ExcDev perc)

  

ExcDev = (ExcDevPerc * Span) / 100

  

  - ExcDevPerc => Percentual configurado

  - Span => Faixa aceitável

  

#### Span exemplos

  

- Sensor de temperatura

de -20c a 100c => span = 100 - (-20) = 120

de 0f  a 250f  => span = 240 - 0 = 250

  

- Medidor de vazão que mede de 10 a 100m3h

   -> span = 100 - 10 = 90 m3h

**ExecDevPerc sobescreve ExcDev**

  

### Exception maximum

  

Tempo máximo, em segundos, que um ponto pode esperar até ser arquivado, **independentemente**, de ele passar ou não no excdev.

  
  

### Exception mínimum

  

Tempo mínimo para arquivar um novo valor (?????)