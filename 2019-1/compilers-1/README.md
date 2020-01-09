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
ConstrucaoCompuladores >> Trabalho1-AnaliseLexicaSintatica >> Descricao.pdf
```

## Trabalho 2 - Análise Semantica

### Descrição

Você precisará fazer um analisador semântico que faça a verificação das regras semânticas
descritas na seção 2. Para isso, pode inserir regras semânticas na própria gramática (arquivo
Luazinha.g4), ou criar um visitante, conforme visto em aula.

```
a) (RECOMENDADO) É recomendado criar um visitante para a análise semântica. Neste caso,
basta utilizar a classe LuazinhaSemanticAnalyzer.java. Essa classe já tem um primeiro
método visitante implementado, e que cria um escopo global. Será necessário adicionar
visitantes para as outras regras, conforme necessário. Atenção para as chamadas aos
outros visitantes. Nesta abordagem, fica a cargo do programador direcionar a navegação.
Caso siga por este caminho, a classe principal (TestaAnalisadorSemantico) já está
configurada e pronta para executar.
b) (NÃO RECOMENDADO) Caso queira, é possível inserir as ações semânticas diretamente
no arquivo da gramática (Luazinha.g4). Neste caso, é preciso lembrar de executar o
ANTLR toda vez que a gramática for alterada. Também é necessário comentar duas linhas
na classe principal (TestaAnalisadorSemantico). Procure por instruções nos comentários.
```

Em qualquer abordagem, a princípio não é necessário alterar as regras sintáticas, basta adicionar
regras semânticas. No entanto, se achar que seu trabalho será mais simples se as regras
sintáticas forem alteradas, fique à vontade para mexer, desde que TODAS AS MUDANÇAS
estejam devidamente documentadas em forma de comentários.

Algumas regras semânticas já estão implementadas, para retornar valores úteis, como nomes
compostos, e linha/coluna de variáveis (para mensagem de erro, conforme abaixo).

As regras poderão utilizar as classes já prontas no projeto do NetBeans:
```
- O objeto “pilhaDeTabelas”, da classe PilhaDeTabelas, está disponível para ser utilizado. Essa
classe disponibiliza métodos como empilhar(), desempilhar() e topo(), para a regra dos escopos
aninhados.
- Cada novo escopo (global, função e for) deve gerar o empilhamento e desempilhamento da
tabela. Para isso, insira as ações necessárias nos locais apropriados da gramática, como visto em
aula (já está feito para o escopo global, no visitor).
- A cada término de escopo deve haver o desempilhamento da respectiva tabela de símbolos.
Nesse momento, o conteúdo daquele escopo será impresso. Ou seja, a saída dos casos de teste
irá mostrar os escopos não na ordem em que aparecem, mas na ordem em que são
desempilhados. Observe as saídas esperadas dos casos de teste, em especial os caso de teste 02,
para compreender a lógica de impressão.
- A classe TabelaDeSimbolos deve ser utilizada para amarrar as variáveis e parâmetros. Cada
escopo terá sua própria tabela (empilhada apropriadamente), cujo nome deve ser definido na
sua criação. O nome do escopo global é “global”, o nome do escopo de uma função é o nome da
função (inclusive nomes compostos), e o nome de um escopo “for” é simplesmente “for”.
- Para cada tabela, estão disponíveis métodos para adicionar símbolos e verificar se existe um
símbolo. Para adicionar um símbolo, deve ser especificado um de dois tipos possíveis:
“parametro” ou “variavel” (assim mesmo, sem acentos).
- Veja que existe um médodo TabelaDeSimbolos.existeSimbolo(String), e um método
PilhaDeTabelas.existeSimbolo(String). O primeiro verifica somente em uma tabela. O segundo
verifica em toda a pilha. Analise bem onde usar cada um.
- Veja que existem dois métodos para inserir símbolos na tabela de símbolos. Um deles adiciona
um único símbolo, de um tipo. O outro adiciona uma lista de símbolos do mesmo tipo de uma
única vez, e é útil para declarações múltiplas de variáveis. Analise bem onde usar cada um.
- Para exibir os erros semânticos de variável não amarrada, utilize a chamada:
Mensagens.erroVariavelNaoExiste(int,int,String). (obs: veja que a regra “var” já
está implementada para retornar linha e coluna)
- Tome sempre como base os casos de teste, pois eles servem de exemplo do que deve ser feito,
e também servirão de critério de avaliação.
```

### 2. Semântica da linguagem Lua

Neste trabalho, você irá implementar um analisador semântico, que irá verificar algumas regras da linguagem Lua:

```
- Aninhamento de escopos
- Amarração de variáveis a um determinado escopo (globais, locais e parâmetros)
- Uso de variáveis não amarradas
- Parâmetro “self” implícito (regra semântica opcional)
```

Claro, existem muitas outras regras semânticas da linguagem Lua, mas não serão consideradas. A seguir são descritas essas regras. Consulte o manual da linguagem para mais informações.

### 2.1. Aninhamento de escopos

Em Lua, existe um escopo global, sem delimitação léxica nenhuma, isto é, um arquivo pode conter comandos diretamente, como no exemplo abaixo:

```
-- uma expressão simples, com variáveis globais
x = 10
y = 10
z,h,a = x + y, y*10, 22
print(z)
```

Além disso, é possível declarar funções, como no exemplo abaixo:

```
-- funcao que calcula o fatorial
function fact(n)
	if n == 0 then
		return 1
	else
		return n * fact(n - 1)
	end
end;
print(fact(5))
```

As funções podem ser aninhadas, como no exemplo abaixo:

```
-- funcoes aninhadas, sem variáveis nem parâmetros
function a()
	function b()
	end
	function c()
		function d()
		end
		function e()
		end
	end
	function f()
	end
end;

function g()
	function h()
		function i()
		end
	end
end
```

Cada nova função cria um novo escopo, aninhado ao escopo que o contém. No exemplo acima, existe o escopo global, dentro do qual existe o escopo de “a”, dentro do qual existem os escopos de “b” e “c”, e assim por diante. Além disso, é também possível criar um novo escopo através do comando “for”, como no
exemplo abaixo:

```
-- funcoes aninhadas e for, com variáveis sem sobreposição
x1 = 0
function a()
	x2 = 0
	x3 = 0
	for i=0,10 do
		i = i+2
	end
	function b()
		x4 = 0
end
...
```

Nesse exemplo, o escopo global contém o escopo de “a”. Dentro do escopo de “a”, existe o escopo de “b”, mas também existe um novo escopo, criado a partir da declaração “for” que faz a
iteração de i de 0 a 10. Existem outras formas de criação de escopo, mas não serão tratadas neste trabalho.

### 2.2. Amarração de variáveis a um determinado escopo (globais, locais e parâmetros)

O aninhamento de escopos descrito acima serve basicamente para fazer a amarração de variáveis. Em Lua, não existe declaração de variáveis. Uma variável é amarrada a um escopo quando ela é alvo de um comando de atribuição (para os escopos globais e funções), quando ela é declarada como parâmetro de função (para funções somente), ou quando é definida em um laço “for” (outras formas de amarração não serão consideradas).
Considere o exemplo abaixo

```
x1 = 0
function a()
	x2 = 0
	x3 = 0
	x1 = 10
	for i=0,10 do
		i = i+2
	end
	function b(p3, x2)
		x4 = 0
		local x3 = 10
		x4 = x5
		x6,x7 = 100,200
	end
...

```
Nesse exemplo:
```
- A variável x1 é alvo de atribuição no escopo global, portanto está amarrada ao escopo global.
- A variável x2 é alvo de atribuição no escopo de “a”, portanto está amarrada ao escopo de “a”.
- A variável x3 é alvo de atribuição no escopo de “a”, portanto está amarrada ao escopo de “a”.
- A variável x1 é alvo de atribuição dentro do escopo de “a”, porém, essa nova atribuição (x1 = 10) NÃO CRIA uma nova variável, pois x1 já existe em um escopo visível (o escopo global nesse caso). Trata-se da mesma variável.
- A variável i é definida no comando “for”, portanto está amarrada ao escopo desse “for”.
- A variável p3 é parâmetro de “b”, e portanto está amarrada ao escopo de “b”.
- A função “b” também define um parâmetro chamado x2. Já existe uma variável x2 amarrada a um escopo mais amplo e visível (escopo de “a”). Porém, como se trata de um parâmetro, É CRIADA UMA NOVA VARIÁVEL, que fica amarrada ao escopo de “b”. Nesse escopo, portanto, existem DUAS variáveis x2, mas a segunda está se sobrepondo à primeira.
- A variável x4 é alvo de atribuição no escopo de “b”, e portanto está amarrada ao escopo de “b”.
- A variável x3 é alvo de atribuição dentro do escopo de “b”. Já existe uma variável x3 amarrada a um escopo mais amplo e visível (escopo de “a”). Porém, a chamada local x3 = 10 CRIA UMA NOVA VARIÁVEL, devido ao prefixo “local”, que força a amarração de uma nova variável mesmo que já exista uma disponível em um escopo mais amplo.
- A atribuição x4 = x5 NÃO CRIA UMA VARIÁVEL x5, pois somente são criadas (e amarradas) as variáveis do lado esquerdo da atribuição. Nesse exemplo, espera-se que a variável x5 já exista e esteja amarrada apropriadamente a um escopo visível.
- As variáveis x6 e x7 são alvos de atribuição em uma única instrução, e portanto são amarradas ao mesmo tempo ao escopo onde aparecem (“b”).
```
Em resumo:
```
- Um comando de atribuição cria uma nova variável, amarrada ao escopo onde a atribuição acontece.
- Somente são criadas (e amarradas) as variáveis que aparecem no lado esquerdo da atribuição.
- Se a variável envolvida na atribuição já existir em um escopo visível, não é criada uma nova variável. Trata-se da mesma variável.
- Se a variável envolvida na atribuição já existir em um escopo visível, mas existir o prefixo “local”, será criada uma nova variável, no escopo atual. (Não será considerado o caso da variável ser declarada duas vezes com “local” em um mesmo escopo)
- Uma declaração de função com parâmetros cria novas variáveis para os parâmetros, amarradas ao escopo da função.
- Um comando “for” cria novas variáveis que porventura apareçam em sua estrutura, amarradas ao escopo do “for”. (Neste trabalho, mesmo que uma variável definida em um “for” já exista em um escopo visível, será criada uma nova variável).
```

### 2.3. Uso de variáveis não amarradas

Variáveis que aparecem em expressões, lado direito de atribuição, dentro de um print, dentro de um if, dentro de um while, etc, devem estar amarradas a um escopo visível. Caso contrário, trata-se de um erro semântico. No exemplo abaixo:

```
-- funcoes simples, apenas com variaveis, e globais
-- usando variáveis não amarradas
x1 = x
function a()
	x2 = x11 + 2
	if x3 > 4 then x3 = 5 end
end;
x1 = x2
```

Existem os seguintes erros semânticos:
```
- A variável x é usada no lado direito na atribuição x1 = x, no entanto não está amarrada ao escopo global.
- A variável x11 é usada no lado direito da atribuição x2 = x11 + 2, no entanto não está amarrada a nenhum escopo visível (nem “a” e nem o global).
- A variável x3 é usada dentro de um comando “if”, no entanto não está amarrada a nenhum escopo visível (nem “a” e nem o global)
- A variável x2 é usada no lado direito da atribuição x1 = x2, no entanto está amarrada a um escopo não visível (“a”), e não está amarrada no escopo global.
```

### 2.4. Parâmetro “self” implícito (regra semântica opcional)

Como já visto, uma função gera um novo escopo, e seus parâmetros são variáveis amarradas a ele. No exemplo:

```
function math.soma(a,b)
	return a + b
end;
```

É criado um escopo “math.soma”, e duas variáveis a e b são amarradas a ele.
Em Lua, funções podem ser definidas como métodos, através do caractere “:”. Segundo a documentação da linguagem Lua, uma definição:
```
function x.y.f:g(a,b)
end
```

é equivalente a:

```
function x.y.f.g(self,a,b)
end
```
Ou seja, existe um parâmetro implícito, chamado “self”, que é utilizado para que a função seja acessada de uma forma “orientada a objetos” (ou seja, um método de uma classe).
Portanto, no exemplo abaixo:
```
function math:multiplica(e,f)
	return e * f
end;
```
É criado um escopo “math.multiplica”, e três variáveis (self, e, f) são amarradas a ele.
Obs: essa regra é opcional, mas poderá ajudar na nota, como descrito na descrição do projeto.

### Mais informações

Para mais informações sobre o trabalho, consultar a descrição do projeto na pasta:

```
ConstrucaoCompuladores >> Trabalho2-AnaliseSemantica >> Descricao.pdf
```



## Antlr 4
Para mais detalhes sobre instalação e utilização do Antlr acesse:

```
https://www.antlr.org/
https://github.com/antlr/antlr4/
```

Ou consulte os colaboradores deste projeto

## Lua
Para mais detalhes sobre a linguagem Lua, acesse:

```
http://www.lua.org
```

Ou para acessar o manual, que contém todas as regras sintáticas da linguagem, acesse:
```
http://www.lua.org/manual/5.1/pt/manual.html#2.1
```

