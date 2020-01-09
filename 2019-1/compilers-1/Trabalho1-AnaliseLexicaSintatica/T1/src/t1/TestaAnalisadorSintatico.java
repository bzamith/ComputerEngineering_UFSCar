package t1;

import java.io.IOException;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.RecognitionException;

public class TestaAnalisadorSintatico {

    public static void main(String args[]) throws IOException, RecognitionException {
        
// Descomente as linhas abaixo para testar o analisador gerado.
// Obs: a linha abaixo está configurada para usar como entrada o arquivo lua1.txt
// Modifique-a para testar os demais exemplos
        for(int i=1;i<7;i++){
            if(i != 9){
                System.out.println("Iteracao: " + i);
                SaidaParser out = new SaidaParser();
                CharStream cs = CharStreams.fromStream(TestaAnalisadorSintatico.class.getResourceAsStream("exemplos/lua" + i +".txt"));
                LuaLexer lexer = new LuaLexer(cs);
                CommonTokenStream tokens = new CommonTokenStream(lexer);
                LuaParser parser = new LuaParser(tokens);
                parser.addErrorListener(new T1ErrorListener(out));
                parser.programa();
                if (!out.isModificado()) {
                    out.println("Fim da analise. Sem erros sintaticos.");
                    out.println("Tabela de simbolos:");

                    TabelaDeSimbolos.imprimirTabela(out);
                    System.out.print(out);
                } else {
                    out.println("Fim da analise. Com erros sintaticos.");
                }
            TabelaDeSimbolos.limparTabela();
            System.out.println("\n\n");
            }
        }
    }
}