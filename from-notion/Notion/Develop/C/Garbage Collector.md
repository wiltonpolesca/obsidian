---

---
O garbage collector separa a memória em três gerações

Geração 0 => últimos conteúdos alocados em memória

Geração 1 =>  Conteúdos que estavam na geração 0 e não foram desalocados, com isso foi promovido para geração 1

Geração 2 => Conteúdo que estava na geração 1 e não foi desalocado, sendo promovido para geração 2

O custo para limpar a geração 1 é muito mais custoso que a geração 0 e a geração 2 é extremamente caro para limpar, impactando muito a performance do software

# Comandos

| Número de execuções do GC | GC.CollectionCount(0) => //geração 0GC.CollectionCount(1) => //geração 1 ==> Se chegar aqui convém verificar se existem objetos alocados incorretamenteGC.CollectionCount(2) => //geração 2 ==> Se chegar aqui o código tem problema de implementação (uso ruim de recursos) |
| --- | --- |
| Obter a memória que está sendo utilizada pelo processo | mb => Process.GetCurrentProcess().WorkingSet64 / 1024 / 1024 |

# Ferramentas

| Para acompanhar otimização | https://benchmarkdotnet.org |
| --- | --- |
|   |   |

# Conversão implicita de tipo

Interessante na utilização de tipos complexos no lugar de utilizar um tipo primitivo na representação, exemplo criando um tipo CPF.

public struct Cpf {

private readonly string _value;

//Usando o construtor privado, evita o uso de new na criação de novos objetos, obrigando o desenvolvedor usar a conversao implicita

// para criar um novo objeto.

private Cpf(string value) {

_value = value;

}

public override string ToString() => _value;

// VALIDAÇÃO

// para a validação, temos dois métodos, o Parse e o TryParse.

// Parse => levanta uma excessão quando algo está errado

// TryParse => retorna um indicativo, um valor, que indica que funcionou ou não.

public static Cpf Parse( string value) {

if (TryParse(value, out var result)) {

return result;

}

throw new ArgumentException("...");

}

public static bool TryParse(string value, out Cpf cpf) {

/// add validação

...

/// se ok, cria o objeto de retorno

cpf = new Cpf( value);

return true;

}

// Conversão implicita, recebe uma string e devolve uma instância do tipo CPF iniciada com o valor recebido

public static implicit operator Cpf(string input) => new Parse(input);

}

Exemplo de uso

public static main (string args) {

Cpf cpf = "99.999.000-98";

}