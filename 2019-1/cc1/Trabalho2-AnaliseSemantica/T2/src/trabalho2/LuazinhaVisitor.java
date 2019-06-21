// Generated from Luazinha.g4 by ANTLR 4.7.2
package trabalho2;
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link LuazinhaParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface LuazinhaVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link LuazinhaParser#programa}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitPrograma(LuazinhaParser.ProgramaContext ctx);
	/**
	 * Visit a parse tree produced by {@link LuazinhaParser#trecho}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitTrecho(LuazinhaParser.TrechoContext ctx);
	/**
	 * Visit a parse tree produced by {@link LuazinhaParser#bloco}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBloco(LuazinhaParser.BlocoContext ctx);
	/**
	 * Visit a parse tree produced by the {@code comandoAtribuicao}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitComandoAtribuicao(LuazinhaParser.ComandoAtribuicaoContext ctx);
	/**
	 * Visit a parse tree produced by the {@code comandoChamadaDeFuncao}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitComandoChamadaDeFuncao(LuazinhaParser.ComandoChamadaDeFuncaoContext ctx);
	/**
	 * Visit a parse tree produced by the {@code comandoDo}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitComandoDo(LuazinhaParser.ComandoDoContext ctx);
	/**
	 * Visit a parse tree produced by the {@code comandoWhile}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitComandoWhile(LuazinhaParser.ComandoWhileContext ctx);
	/**
	 * Visit a parse tree produced by the {@code comandoRepeat}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitComandoRepeat(LuazinhaParser.ComandoRepeatContext ctx);
	/**
	 * Visit a parse tree produced by the {@code comandoIf}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitComandoIf(LuazinhaParser.ComandoIfContext ctx);
	/**
	 * Visit a parse tree produced by the {@code comandoFor1}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitComandoFor1(LuazinhaParser.ComandoFor1Context ctx);
	/**
	 * Visit a parse tree produced by the {@code comandoFor2}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitComandoFor2(LuazinhaParser.ComandoFor2Context ctx);
	/**
	 * Visit a parse tree produced by the {@code comandoFunction}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitComandoFunction(LuazinhaParser.ComandoFunctionContext ctx);
	/**
	 * Visit a parse tree produced by the {@code comandoLocalFunction}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitComandoLocalFunction(LuazinhaParser.ComandoLocalFunctionContext ctx);
	/**
	 * Visit a parse tree produced by the {@code comandoLocalAtribuicao}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitComandoLocalAtribuicao(LuazinhaParser.ComandoLocalAtribuicaoContext ctx);
	/**
	 * Visit a parse tree produced by {@link LuazinhaParser#ultimocomando}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitUltimocomando(LuazinhaParser.UltimocomandoContext ctx);
	/**
	 * Visit a parse tree produced by {@link LuazinhaParser#nomedafuncao}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNomedafuncao(LuazinhaParser.NomedafuncaoContext ctx);
	/**
	 * Visit a parse tree produced by {@link LuazinhaParser#listavar}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitListavar(LuazinhaParser.ListavarContext ctx);
	/**
	 * Visit a parse tree produced by {@link LuazinhaParser#var}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitVar(LuazinhaParser.VarContext ctx);
	/**
	 * Visit a parse tree produced by {@link LuazinhaParser#listadenomes}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitListadenomes(LuazinhaParser.ListadenomesContext ctx);
	/**
	 * Visit a parse tree produced by {@link LuazinhaParser#listaexp}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitListaexp(LuazinhaParser.ListaexpContext ctx);
	/**
	 * Visit a parse tree produced by {@link LuazinhaParser#exp}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExp(LuazinhaParser.ExpContext ctx);
	/**
	 * Visit a parse tree produced by {@link LuazinhaParser#expprefixo}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExpprefixo(LuazinhaParser.ExpprefixoContext ctx);
	/**
	 * Visit a parse tree produced by the {@code expPrefixo2Var}
	 * labeled alternative in {@link LuazinhaParser#expprefixo2}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExpPrefixo2Var(LuazinhaParser.ExpPrefixo2VarContext ctx);
	/**
	 * Visit a parse tree produced by the {@code expPrefixo2ChamadaDeFuncao}
	 * labeled alternative in {@link LuazinhaParser#expprefixo2}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExpPrefixo2ChamadaDeFuncao(LuazinhaParser.ExpPrefixo2ChamadaDeFuncaoContext ctx);
	/**
	 * Visit a parse tree produced by the {@code expPrefixo2Exp}
	 * labeled alternative in {@link LuazinhaParser#expprefixo2}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExpPrefixo2Exp(LuazinhaParser.ExpPrefixo2ExpContext ctx);
	/**
	 * Visit a parse tree produced by {@link LuazinhaParser#chamadadefuncao}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitChamadadefuncao(LuazinhaParser.ChamadadefuncaoContext ctx);
	/**
	 * Visit a parse tree produced by {@link LuazinhaParser#args}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitArgs(LuazinhaParser.ArgsContext ctx);
	/**
	 * Visit a parse tree produced by {@link LuazinhaParser#funcao}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitFuncao(LuazinhaParser.FuncaoContext ctx);
	/**
	 * Visit a parse tree produced by {@link LuazinhaParser#corpodafuncao}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCorpodafuncao(LuazinhaParser.CorpodafuncaoContext ctx);
	/**
	 * Visit a parse tree produced by the {@code listaParListaDeNomes}
	 * labeled alternative in {@link LuazinhaParser#listapar}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitListaParListaDeNomes(LuazinhaParser.ListaParListaDeNomesContext ctx);
	/**
	 * Visit a parse tree produced by the {@code listaParVarargs}
	 * labeled alternative in {@link LuazinhaParser#listapar}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitListaParVarargs(LuazinhaParser.ListaParVarargsContext ctx);
	/**
	 * Visit a parse tree produced by {@link LuazinhaParser#construtortabela}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitConstrutortabela(LuazinhaParser.ConstrutortabelaContext ctx);
	/**
	 * Visit a parse tree produced by {@link LuazinhaParser#listadecampos}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitListadecampos(LuazinhaParser.ListadecamposContext ctx);
	/**
	 * Visit a parse tree produced by {@link LuazinhaParser#campo}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitCampo(LuazinhaParser.CampoContext ctx);
	/**
	 * Visit a parse tree produced by {@link LuazinhaParser#separadordecampos}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSeparadordecampos(LuazinhaParser.SeparadordecamposContext ctx);
	/**
	 * Visit a parse tree produced by {@link LuazinhaParser#opbin}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOpbin(LuazinhaParser.OpbinContext ctx);
	/**
	 * Visit a parse tree produced by {@link LuazinhaParser#opunaria}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitOpunaria(LuazinhaParser.OpunariaContext ctx);
}