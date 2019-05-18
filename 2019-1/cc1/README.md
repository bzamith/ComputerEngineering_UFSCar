# ConstrucaoCompiladores
Trabalho apresentado a disciplina construção de compiladores na Universidade Federal de São Carlos sobre orientação do Professor Doutor Daniel Lucredio.

## Trabalho 1 - Análise Lexica e Sintática

### Descrição
### Tarefa 1 - Analisar léxico

Com relação ao analisador léxico, você não precisará implementar todas as convenções léxicas da
linguagem Lua, apenas o subconjunto descrito a seguir.

```
a) Palavras reservadas (todas)
b) Símbolos reservados (todos)
c) Nomes
d) Cadeias de caracteres (apenas as versões curtas, sem sequência de escape, quebras de linha
não permitidas)
e) Constantes numéricas (apenas decimais, sem sinal, com dígitos antes e depois do ponto
decimal opcionais)
```

Espaços em branco e comentários curtos deverão ser IGNORADOS pelo analisador léxico.


### Tarefa 2 - Analisar Sintático
O manual da Lua já contém a gramática da linguagem, no
final. Para transformá-la para a sintaxe do ANTLR, as seguintes traduções são necessárias:

```
"::="
=> ":"
{regra} => (regra)*
[regra] => (regra)?
'cadeias' devem ser envoltas por aspas simples
toda regra deve terminar com ";"
```

Algumas dicas:
- Crie uma regra nova, no início da gramática (depois dos padrões léxicos). Ela será necessária nos
testes:
programa : trecho;
- É necessário alterar um pouco a gramática do manual da Lua, pois o ANTLR não tolera certos
tipos de recursividade. Utilize as técnicas vistas em sala de aula para fazer a gramática funcionar.
Analise a gramática com cuidado, faça testes e tente encontrar a solução. Utilize também o
mecanismo de desenho dos diagramas para ajudar (Menu Janela -> Syntax Diagram).
Obs: Os seis exemplos fornecidos devem compilar sem erros. Utilize-os como base para o
desenvolvimento. Mas também procure testar os casos de teste "oficiais", para verificar o bom
funcionamento do seu analisador.

### Tarefa 3 - Tabela de símbolos
Além de fazer a análise sintática, o seu analisador deverá montar uma tabela de símbolos
simplificada. A estrutura da tabela já está pronta, assim como o código que a imprime na saída.
Basta portanto inserir as chamadas corretamente, dentro das regras sintáticas, e gerar o
analisador novamente.
Para inserir um elemento na tabela de símbolos, insira uma ação semântica chamando o método
"adicionarSimbolo". Ex:

```
regra : TK { TabelaDeSimbolos.adicionarSimbolo($TK.text,Tipo.VARIAVEL); }
;
```

O método é público e "static" , portanto nada mais é necessário. Consulte o roteiro da aula 4
para mais detalhes sobre ações semânticas, tipos de retorno, etc. Esses conceitos serão
necessários para a realização do trabalho. O manual do ANTLR também pode ser consultado
(acesse-o no site do antlr).
Há dois tipos de símbolos a serem inseridos na tabela: VARIAVEL ou FUNCAO. Toda variável
usada deve aparecer na tabela, na ordem em que aparece, sem duplicação. Toda função, usada
ou declarada, também deve aparecer na tabela, na ordem em que aparece, sem duplicação.
Utilize os casos de teste como referência para entender o que deve ser feito. Analise a gramática
cuidadosamente e decida onde inserir as ações semânticas para produzir o resultado correto.
Não é necessário tratar duplicatas, detalhes de instanciação, etc, pois as classes fornecidas já
fazem esse trabalho. Você só precisará mexer no arquivo Lua.g4.

### Entrega

O trabalho será entregue, bem como, só foi realizado alterações no arquivo Lua.g4. Todos os outros códigos foram de autoria do professor, ou geração automática através do antlr.

Ainda, o arquivo .zip com nome 628093_e_628301_e_595160, é o arquivo encaminhado para o professor. Este contém o arquivo lua.g4, com todas as alterações realizadas.

### Mais informações

Para mais informações sobre o trabalho, consultar a descrição do projeto na pasta:

```
ConstrucaoCompuladores >> AnaliseSitatica >> Descricao.pdf
```


### Antlr 4
Para mais detalhes sobre instalação e utilização do Antlr acesse:

```
https://www.antlr.org/
https://github.com/antlr/antlr4/
```

Ou consulte os colaboradores deste projeto

### Lua
Para mais detalhes sobre a linguagem Lua, acesse:

```
http://www.lua.org
```

Ou para acessar o manual, que contém todas as regras sintáticas da linguagem, acesse:
```
http://www.lua.org/manual/5.1/pt/manual.html#2.1
```


## Trabalho 2 - Ainda não disponibilizado
