grammar Luazinha;

//Membros do grupo: 
//Bruna Zamith        628093 (Turma A-Ter);
//Marcos Faglioni     628301 (Turma A-Ter);
//Pedro Vinicius      595160 (Turma B-Seg).

@members{
public static String grupo = "<628093,628301,595160>";
PilhaDeTabelas pilhaDeTabelas = new PilhaDeTabelas();
}

programa : {pilhaDeTabelas.empilhar(new TabelaDeSimbolos("global")); }
           trecho
           {pilhaDeTabelas.desempilhar(); }
         ;

trecho : (comando ';'?)* (ultimocomando ';'?)?
       ;

bloco : trecho
      ;

// Alterações:
//   listavar:
//       Nessa regra tem que se percorrer todas as variáveis, checando sua existencia no escopo, e caso não exista, inserir na tabela de simbolos corrente;
//   primerio for:
//       Este primeiro for é fixo para somente uma variavel declarada no comando do for (podem haver outras no corpo do for), assim, cria-se um escopo do for, e em seguida, insere a variavel de controle do for, continua-se a regra, e ao final, desempilha a tabela de simbolos do for;
//   segundo for:
//       Neste for é possivel declarar uma serie de variaveis de controle, assim, devemos criar um novo escopo, em seguida temos que checar se as atribuições são possiveis, ou seja, se não é utilizada nenhuma variável não declarada no lado direito da atribuição, e então inserir na tabela de simbolos cada uma das variaveis de controle, após o término do dor, desempilhar a tabela do for;
//   function:
//       Cria-se um novo escopo, passando o nome da função, executa normalmente a regra, e no final, desempilha a tabela criada;
//   'local' listaDeNomes:
//       Para cada variavel local criada, tem que ser inserida na tabela.
comando :  listavar '=' listaexp 
              {for(String nome : $listavar.nomes)
                if(!pilhaDeTabelas.existeSimbolo(nome))
                  pilhaDeTabelas.topo().adicionarSimbolo(nome, "variavel");
              } #comandoAtribuicao
        |  chamadadefuncao #comandoChamadaDeFuncao
        |  'do' bloco 'end' #comandoDo
        |  'while' exp 'do' bloco 'end' #comandoWhile
        |  'repeat' bloco 'until' exp #comandoRepeat
        |  'if' exp 'then' bloco ('elseif' exp 'then' bloco)* ('else' bloco)? 'end' #comandoIf
        |  'for' 
           {pilhaDeTabelas.empilhar(new TabelaDeSimbolos("for"));}
           NOME
           {pilhaDeTabelas.topo().adicionarSimbolo($NOME.getText(), "variavel");}
           '=' exp ',' exp (',' exp)? 'do' bloco 
           {pilhaDeTabelas.desempilhar();}
           'end' #comandoFor1
        |  'for' 
            {pilhaDeTabelas.empilhar(new TabelaDeSimbolos("for"));}
            listadenomes 'in' listaexp
            {for(String nome : $listadenomes.nomes)
              pilhaDeTabelas.topo().adicionarSimbolo(nome, "variavel");
            }
            'do' bloco 
            {pilhaDeTabelas.desempilhar();}
            'end' #comandoFor2
        |  'function' nomedafuncao
              {
               pilhaDeTabelas.empilhar(new TabelaDeSimbolos($nomedafuncao.nome));
               if ($nomedafuncao.metodo) {
                   pilhaDeTabelas.topo().adicionarSimbolo("self", "parametro");
               }
               }
               corpodafuncao {pilhaDeTabelas.desempilhar();} #comandoFunction
        |  'local' 'function' NOME corpodafuncao #comandoLocalFunction
        |  'local' listadenomes 
              {for(String nome : $listadenomes.nomes)
                pilhaDeTabelas.topo().adicionarSimbolo(nome, "variavel");
              }

          ('=' listaexp)? #comandoLocalAtribuicao
        ;

ultimocomando : 'return' (listaexp)? | 'break'
              ;

nomedafuncao returns [ String nome, boolean metodo ]
@init { $metodo = false; }
    : n1=NOME { $nome = $n1.getText(); }
      ('.' n2=NOME { $nome += "." + $n2.getText(); })*
      (':' n3=NOME { $metodo = true; $nome += "." + $n3.getText(); })?
    ;

listavar returns [ List<String> nomes ]
@init { $nomes = new ArrayList<String>(); }
    : v1=var { $nomes.add($v1.nome); }
      (',' v2=var { $nomes.add($v2.nome); }
      )*
    ;

var returns [ String nome, int linha, int coluna ]
    :  NOME { $nome = $NOME.getText(); $linha = $NOME.line; $coluna = $NOME.pos; } 
    |  expprefixo '[' exp ']'
    |  expprefixo '.' NOME
    ;

listadenomes returns [ List<String> nomes ]
@init{ $nomes = new ArrayList<String>(); }
    : n1=NOME { $nomes.add($n1.getText()); }
      (',' n2=NOME { $nomes.add($n2.getText()); } )*
    ;

listaexp : (exp ',')* exp
         ;

exp :  'nil' | 'false' | 'true' | NUMERO | CADEIA | '...' | funcao | 
       expprefixo2 | construtortabela | exp opbin exp | opunaria exp 
    ;


expprefixo : NOME ( '[' exp ']' | '.' NOME )*
           ;


// Alteração:
//    No caso de uma atribuição, no lado direito, a variável tem que estar previamente declarada (pertencer a tabela), no caso de não pertecer, tem que ser chamado uma função de erro, que retornará como mensagem na saída
expprefixo2 : var 
            { if(!pilhaDeTabelas.existeSimbolo($var.nome))
                Mensagens.erroVariavelNaoExiste($var.linha, $var.coluna, $var.nome);
            }
              #expPrefixo2Var 
            | chamadadefuncao #expPrefixo2ChamadaDeFuncao
            | '(' exp ')' #expPrefixo2Exp
            ;

chamadadefuncao :  expprefixo args |
                   expprefixo ':' NOME args
                ;

args :  '(' (listaexp)? ')' | construtortabela | CADEIA 
     ;

funcao : 'function' corpodafuncao
       ;

corpodafuncao : '(' (listapar)? ')' bloco 'end'
              ;


// Alterações
//   No caso de uma lista de parâmetros, devemos percorrer cada um dos parâmetros e inserir cada um deles na tabela
listapar : listadenomes (',' '...')? 
            {for(String nome : $listadenomes.nomes)
              pilhaDeTabelas.topo().adicionarSimbolo(nome, "parametro");
            }
          #listaParListaDeNomes
         | '...' #listaParVarargs
         ;

construtortabela : '{' (listadecampos)? '}'
                 ;

listadecampos : campo (separadordecampos campo)* (separadordecampos)?
              ;

campo : '[' exp ']' '=' exp | NOME '=' exp | exp
      ;

separadordecampos : ',' | ';'
                  ;

opbin : '+' | '-' | '*' | '/' | '^' | '%' | '..' | '<' | 
        '<=' | '>' | '>=' | '==' | '~=' | 'and' | 'or'
      ;

opunaria : '-' | 'not' | '#'
         ;


NOME	:	('a'..'z' | 'A'..'Z' | '_') ('a'..'z' | 'A'..'Z' | '0'..'9' | '_')*;
CADEIA	:	'\'' ~('\n' | '\r' | '\'')* '\'' | '"' ~('\n' | '\r' | '"')* '"';
NUMERO	:	('0'..'9')+ EXPOENTE? | ('0'..'9')+ '.' ('0'..'9')* EXPOENTE?
		| '.' ('0'..'9')+ EXPOENTE?;
fragment
EXPOENTE	:	('e' | 'E') ( '+' | '-')? ('0'..'9')+;
COMENTARIO
	:	'--' ~('\n' | '\r')* '\r'? '\n' {skip();};
WS	:	(' ' | '\t' | '\r' | '\n') {skip();};
