grammar Lua;

//Membros do grupo: 
//Bruna Zamith        628093 (Turma A-Ter);
//Marcos Faglioni     628301 (Turma A-Ter);
//Pedro Vinicius      595160 (Turma B-Seg).
@members {
   public static String grupo="<628093,628301,595160>";
}


//Regra para iniciar o programa
programa : trecho;


//Bloco e um conjunto de trecho de codigos
bloco : trecho;


//Regra que trata cada linha, como um comando, regras de comando podem ser vistas abaixo
trecho : (comando (';')?)* (ultimocomando (';')?)?;


//Regra que trata cada tipo de comando possivel na linguagem lua
//Explicacao - Tabela: exp1 insere o nome de funcoes que fazem parte do pacote nativo na tabela, e portanto, nao possuem declaracoes no codigo analisado
//Explicacao - Recursividade: expprefixo foi incluido no lugar de chamadafuncao para remover uma recursividade encadeada, assim chamadadefuncoes foi removido para facilitar a remocao de recursividade em exprefixo
comando : listavar '=' listaexp 
        | (exp1=expprefixo args) { TabelaDeSimbolos.adicionarSimbolo($exp1.text, Tipo.FUNCAO); } | (expprefixo ':' Nome a2=args)
        | expprefixo ':' Nome args
        | 'do' bloco 'end' 
        | 'while' exp 'do' bloco 'end' 
        | 'repeat' bloco 'until' exp 
        | 'if' exp 'then' bloco ('elseif' exp 'then' bloco)* ('else' bloco)? 'end' 
        | 'for' nome1=Nome { TabelaDeSimbolos.adicionarSimbolo($nome1.text, Tipo.VARIAVEL); } '=' exp ',' exp (',' exp)? 'do' bloco 'end'
        | 'for' listadenomes 'in' listaexp 'do' bloco 'end'
        | 'function' nomedafuncao corpodafuncao 
        | 'local' 'function' Nome corpodafuncao 
        | 'local' listadenomes ('=' list=listaexp { TabelaDeSimbolos.adicionarSimbolo($list.text, Tipo.VARIAVEL); })?
        ;


//Regra que finaliza um comando ou um bloco
ultimocomando : 'return' (listaexp)? 
              | 'break'
              ;


//Regra com o nome da funcao ou biblioteca/funcao
//Explicacao - Tabela: nome insere na tabela o nome de funcoes que são declaradas no programa analisado
nomedafuncao : nome=Nome {TabelaDeSimbolos.adicionarSimbolo($nome.text,Tipo.FUNCAO);} ('.' Nome)* (':' Nome)?;


//Regra para os nomes, que sao formados por inicializacao por letra maiuscula, ou minuscula ou _, seguido de letra, numero ou _
Nome : ('a'..'z' | 'A'..'Z' | '_') ('a'..'z' | 'A'..'Z' | '_' | '0'..'9')*;


//Regra para numeros, que pode ser inteiro ou ponto flutuante, ambos sem sinal
Numero : ('0'..'9')+ 
       | ('0'..'9')+ ('.' ('0'..'9')+)?
       ;


//Regra para lista com variaveis
listavar : var (',' var)*;


//Regra para lista de nomes
//Explicacao - Tabela: nome1 e nome2 insere o nome de variaveis declaradas em lista recursivamente (var1, var2, var3, ...) na tabela de simbolos
listadenomes : nome1=Nome {TabelaDeSimbolos.adicionarSimbolo($nome1.text,Tipo.VARIAVEL);} (',' nome2=Nome {TabelaDeSimbolos.adicionarSimbolo($nome2.text,Tipo.VARIAVEL);})*;


//Regra para lista de exp (proxima regra define o que e exp)
listaexp : (exp  ',')* exp ;


//Regra que define o que pode ser exp: nil, false, true, numero, cadeia, '...', funcao, exprefixo, construtor de tabela e operacao unaria
//Explicacao - Recursividade: remocao de recursividade conforme visto em sala, onde lista-se as recursividades incialmente, insere a nova regra ao final de cada caso, e remove todas as aparicoes da recursividade.
exp : 'nil' exp2 
    | 'false' exp2 
    | 'true' exp2 
    | Numero exp2 
    | Cadeia exp2 
    | '...' exp2 
    | funcao exp2 
    | expprefixo exp2 
    | construtortabela  exp2 
    | opunaria exp exp2
    ;


//Auxiliar para remocao de recursividade
exp2 : (opbin exp)*;


//Regra para definicao de cadeia na sintaxe lua
Cadeia : ( '\'' (.*?) '\'')
       | ('"' (.*?) '"');


//Regra para o exprefixo
//Explicacao - Tabela: nome1 insere o nome de funções que são instanciadas de outras bibliotecas na tabela
//Explicacao - Recursividade: remover a recursividade a esquerda de chamadadefuncao e var, substituindo em exprefixo e seguindo as regras vistas em sala de aula. A criação de exprefixo 2 faz parte do conjunto de adptacao juntamente com a insercao do vazio na regra criada.
expprefixo : Nome expprefixo2
           | nome1=Nome ('.' nome2=Nome expprefixo2) {TabelaDeSimbolos.adicionarSimbolo($nome1.text + '.' + $nome2.text,Tipo.FUNCAO);}
           | '(' exp ')' expprefixo2
           ;

//regra auxiliar da remocao de recursividade
expprefixo2 : args expprefixo2
            | ':' Nome args expprefixo2
            | '[' exp ']' expprefixo2
            | 
            ;


//Regra para variaveis
//Explicacao - Tabela: nome insere o nome de variavel declarada na tabela de simbolos
var : nome=Nome {TabelaDeSimbolos.adicionarSimbolo($nome.text,Tipo.VARIAVEL);}  
    | expprefixo '[' exp ']'
    | expprefixo '.' Nome
    ;


//Regra para argumentos
args : '(' (listaexp)? ')' 
     | construtortabela 
     | Cadeia
     ;


//Regra que identifica a definicao de uma funcao
funcao : 'function' corpodafuncao;


//Regra que define o corpo de uma funcao
corpodafuncao : '(' (listapar)? ')' bloco 'end';


//Regra para lista de parametros
listapar : listadenomes (',' '...')? 
         | '...'
         ;


//Regra para a construcao da tabela
construtortabela : '{' (listadecampos)? '}';


//Regra para listar campos de uma tabela
listadecampos : campo (separadordecampos campo)* (separadordecampos)?;


//Regra com o campo de uma tabela
campo : '[' exp ']' '=' exp 
      | Nome '=' exp 
      | exp
      ;


//Regra do separador de campos em uma tabela
separadordecampos : ',' | ';';


//Regra das operacoes binarias
opbin : '+'  | '-'   | '*' 
      | '/'  | '^'   | '%'  
      | '..' | '<'   | '<=' 
      | '>'  | '>='  | '==' 
      | '~=' | 'and' | 'or'
      ;


//Regra das operacoes unarias
opunaria : '-' 
         | 'not' 
         | '#'
         ;


//Regra para ignorar comentario. Existe em lua, mas nao esta descrita em 8, no manual de sintaxe lua
COMENTARIO : '--' (.*?) ('\n' | '\r') -> skip;


//Regra para ignorar espacos em brancos, retorno de carro e nova linha
WS : (' ' | '\n' | '\r' | '\t') -> skip;