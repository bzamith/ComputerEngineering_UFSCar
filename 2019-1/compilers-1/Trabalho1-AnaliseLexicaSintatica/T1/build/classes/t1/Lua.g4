grammar Lua;

//Membros do grupo: Bruna Zamith(Turma A-Ter), Marcos Faglioni(Turma A-Ter) e Pedro Vinicius(Turma B-Seg)
@members {
   public static String grupo="<628093,628301,595160>";
}


programa : trecho {System.out.println("oi5");};


trecho : (comando (';')?)* (ultimocomando (';')?)?;


bloco : trecho;


//exp1 insere o nome de funcoes que fazem parte do pacote nativo na tabela, e portanto, nao possuem declaracoes no codigo analisado
//expprefixo foi incluido no lugar de chamadafuncao para remover uma recursividade encadeada
comando : listavar '=' listaexp 
        | exp1=expprefixo args 
        | expprefixo ':' Nome args
        | 'do' bloco 'end' 
        | 'while' exp 'do' bloco 'end' 
        | 'repeat' bloco 'until' exp 
        | 'if' exp 'then' bloco ('elseif' exp 'then' bloco)* ('else' bloco)? 'end' 
        | 'for' Nome '=' exp ',' exp (',' exp)? 'do' bloco 'end'
        | 'for' listadenomes 'in' listaexp 'do' bloco 'end'
        | 'function' nomedafuncao corpodafuncao 
        | 'local' 'function' Nome corpodafuncao 
        | 'local' listadenomes ('=' listaexp)?
        ;

chamadadefuncao : var args cf2 
                | '(' exp ')' args cf2 
                | var ':' Nome args cf2 
                | '(' exp ')' ':' Nome args cf2 
                | cf2
                ;


cf2 : args cf2 
    | ':' Nome args cf2
    ;


ultimocomando : 'return' (listaexp)? 
              | 'break'
              ;


//nome insere na tabela o nome de funcoes que são declaradas no programa analisado
nomedafuncao : nome=Nome {TabelaDeSimbolos.adicionarSimbolo($nome.text,Tipo.FUNCAO);} {System.out.println("oi2");} ('.' Nome)* (':' Nome)?;


Nome : ('a'..'z' | 'A'..'Z' | '_') ('a'..'z' | 'A'..'Z' | '_' | '0'..'9')*;


Numero : ('0'..'9')+ 
       | ('0'..'9')+ ('.' ('0'..'9')+)?
       ;


listavar : var (',' var)*;


//nome1 e nome2 insere o nome de variaveis declaradas em lista recursivamente (var1, var2, var3, ...) na tabela de simbolos
listadenomes : nome1=Nome {TabelaDeSimbolos.adicionarSimbolo($nome1.text,Tipo.VARIAVEL);} (',' nome2=Nome {TabelaDeSimbolos.adicionarSimbolo($nome2.text,Tipo.VARIAVEL);})*;


listaexp : (exp ',')* exp;


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


exp2 : (opbin exp)*;


Cadeia : ( '\'' (.*?) '\'')
       | ('"' (.*?) '"');


//nome1 insere o nome de funções que são instanciadas de outras bibliotecas na tabela
expprefixo : nome1=Nome expprefixo2 {System.out.println("oi3");} {TabelaDeSimbolos.adicionarSimbolo($nome1.text,Tipo.FUNCAO);}
           | nome1=Nome ('.' nome2=Nome expprefixo2) {System.out.println("oi");} {TabelaDeSimbolos.adicionarSimbolo($nome1.text + '.' + $nome2.text,Tipo.FUNCAO);}
           | '(' exp ')' expprefixo2
           ;

expprefixo2 : args expprefixo2
            | ':' Nome args expprefixo2
            | '[' exp ']' expprefixo2
            | 
            ;

//nome insere o nome de variavel declarada na tabela de simbolos
var : nome=Nome {TabelaDeSimbolos.adicionarSimbolo($nome.text,Tipo.VARIAVEL);}  
    | expprefixo '[' exp ']'
    | expprefixo '.' Nome
    ;


args : '(' (listaexp)? ')' 
     | construtortabela 
     | Cadeia
     ;


funcao : 'function' corpodafuncao;


corpodafuncao : '(' (listapar)? ')' bloco 'end';


listapar : listadenomes (',' '...')? 
         | '...'
         ;


construtortabela : '{' (listadecampos)? '}';


listadecampos : campo (separadordecampos campo)* (separadordecampos)?;


campo : '[' exp ']' '=' exp 
      | Nome '=' exp 
      | exp
      ;


separadordecampos : ',' | ';';


opbin : '+'  | '-'   | '*' 
      | '/'  | '^'   | '%'  
      | '..' | '<'   | '<=' 
      | '>'  | '>='  | '==' 
      | '~=' | 'and' | 'or'
      ;


opunaria : '-' 
         | 'not' 
         | '#'
         ;


COMENTARIO : '--' (.*?) ('\n' | '\r') -> skip;


WS : (' ' | '\n' | '\r' | '\t') -> skip;