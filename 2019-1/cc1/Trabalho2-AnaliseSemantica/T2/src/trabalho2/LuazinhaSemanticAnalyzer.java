/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package trabalho2;

/**
 *
 * @author daniellucredio
 */
public class LuazinhaSemanticAnalyzer extends LuazinhaBaseVisitor<Void> {
    // Não esqueça de colocar os RAs do seu grupo na variável a seguir    
    public static String grupo = "<628093,628301,595160>";

    PilhaDeTabelas pilhaDeTabelas = new PilhaDeTabelas();

    @Override
    public Void visitPrograma(LuazinhaParser.ProgramaContext ctx) {
        pilhaDeTabelas.empilhar(new TabelaDeSimbolos("global"));
        
        
        
        // A chamada a seguir invoca o comportamento padrão,
        // que é o de visitar todos os filhos
        super.visitPrograma(ctx);
        // Também poderia substituir por uma chamada específica a
        // outro visitante, como a seguir:
        // visitTrecho(ctx.trecho());
        // Neste caso, é preciso especificar o contexto específico
        // do visitante (trecho)


        // Cuidado para lembrar de inserir corretamente as chamadas
        // dos visitantes a seguir, pois no padrão Visitor do ANTLR,
        // a visitação deve ser explicitamente controlada pelo programador.

        pilhaDeTabelas.desempilhar();
        
        // Deve haver "return null" no final de cada método, devido
        // à verificação de tipos genéricos do Java. Como não estamos
        // utilizando tipo de retorno, não é necessário.
        return null;
    }
    
    // Não é necessário sobrescrever um determinado método visitante
    // se a única coisa que ele faz é visitar os filhos, sem nenhuma
    // ação adicional. O exemplo a seguir serve apenas para ilustrar
    // esse efeito.
//    @Override
//    public Void visitBloco(LuazinhaParser.BlocoContext ctx) {
//        // desnecessário, pois a única coisa que ele faz é visitar os filhos!
//        super.visitBloco(ctx);
//        
//        // desnecessário, pois a única coisa que ele faz é visitar os filhos
//        // (obs, aqui chamando outro visitante ao invés do super)
//        visitTrecho(ctx.trecho());
//        
//        return null;
//    }
    


}
