// Generated from Luazinha.g4 by ANTLR 4.7.2
package trabalho2;
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link LuazinhaParser}.
 */
public interface LuazinhaListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link LuazinhaParser#programa}.
	 * @param ctx the parse tree
	 */
	void enterPrograma(LuazinhaParser.ProgramaContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuazinhaParser#programa}.
	 * @param ctx the parse tree
	 */
	void exitPrograma(LuazinhaParser.ProgramaContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuazinhaParser#trecho}.
	 * @param ctx the parse tree
	 */
	void enterTrecho(LuazinhaParser.TrechoContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuazinhaParser#trecho}.
	 * @param ctx the parse tree
	 */
	void exitTrecho(LuazinhaParser.TrechoContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuazinhaParser#bloco}.
	 * @param ctx the parse tree
	 */
	void enterBloco(LuazinhaParser.BlocoContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuazinhaParser#bloco}.
	 * @param ctx the parse tree
	 */
	void exitBloco(LuazinhaParser.BlocoContext ctx);
	/**
	 * Enter a parse tree produced by the {@code comandoAtribuicao}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 */
	void enterComandoAtribuicao(LuazinhaParser.ComandoAtribuicaoContext ctx);
	/**
	 * Exit a parse tree produced by the {@code comandoAtribuicao}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 */
	void exitComandoAtribuicao(LuazinhaParser.ComandoAtribuicaoContext ctx);
	/**
	 * Enter a parse tree produced by the {@code comandoChamadaDeFuncao}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 */
	void enterComandoChamadaDeFuncao(LuazinhaParser.ComandoChamadaDeFuncaoContext ctx);
	/**
	 * Exit a parse tree produced by the {@code comandoChamadaDeFuncao}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 */
	void exitComandoChamadaDeFuncao(LuazinhaParser.ComandoChamadaDeFuncaoContext ctx);
	/**
	 * Enter a parse tree produced by the {@code comandoDo}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 */
	void enterComandoDo(LuazinhaParser.ComandoDoContext ctx);
	/**
	 * Exit a parse tree produced by the {@code comandoDo}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 */
	void exitComandoDo(LuazinhaParser.ComandoDoContext ctx);
	/**
	 * Enter a parse tree produced by the {@code comandoWhile}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 */
	void enterComandoWhile(LuazinhaParser.ComandoWhileContext ctx);
	/**
	 * Exit a parse tree produced by the {@code comandoWhile}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 */
	void exitComandoWhile(LuazinhaParser.ComandoWhileContext ctx);
	/**
	 * Enter a parse tree produced by the {@code comandoRepeat}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 */
	void enterComandoRepeat(LuazinhaParser.ComandoRepeatContext ctx);
	/**
	 * Exit a parse tree produced by the {@code comandoRepeat}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 */
	void exitComandoRepeat(LuazinhaParser.ComandoRepeatContext ctx);
	/**
	 * Enter a parse tree produced by the {@code comandoIf}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 */
	void enterComandoIf(LuazinhaParser.ComandoIfContext ctx);
	/**
	 * Exit a parse tree produced by the {@code comandoIf}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 */
	void exitComandoIf(LuazinhaParser.ComandoIfContext ctx);
	/**
	 * Enter a parse tree produced by the {@code comandoFor1}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 */
	void enterComandoFor1(LuazinhaParser.ComandoFor1Context ctx);
	/**
	 * Exit a parse tree produced by the {@code comandoFor1}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 */
	void exitComandoFor1(LuazinhaParser.ComandoFor1Context ctx);
	/**
	 * Enter a parse tree produced by the {@code comandoFor2}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 */
	void enterComandoFor2(LuazinhaParser.ComandoFor2Context ctx);
	/**
	 * Exit a parse tree produced by the {@code comandoFor2}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 */
	void exitComandoFor2(LuazinhaParser.ComandoFor2Context ctx);
	/**
	 * Enter a parse tree produced by the {@code comandoFunction}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 */
	void enterComandoFunction(LuazinhaParser.ComandoFunctionContext ctx);
	/**
	 * Exit a parse tree produced by the {@code comandoFunction}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 */
	void exitComandoFunction(LuazinhaParser.ComandoFunctionContext ctx);
	/**
	 * Enter a parse tree produced by the {@code comandoLocalFunction}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 */
	void enterComandoLocalFunction(LuazinhaParser.ComandoLocalFunctionContext ctx);
	/**
	 * Exit a parse tree produced by the {@code comandoLocalFunction}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 */
	void exitComandoLocalFunction(LuazinhaParser.ComandoLocalFunctionContext ctx);
	/**
	 * Enter a parse tree produced by the {@code comandoLocalAtribuicao}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 */
	void enterComandoLocalAtribuicao(LuazinhaParser.ComandoLocalAtribuicaoContext ctx);
	/**
	 * Exit a parse tree produced by the {@code comandoLocalAtribuicao}
	 * labeled alternative in {@link LuazinhaParser#comando}.
	 * @param ctx the parse tree
	 */
	void exitComandoLocalAtribuicao(LuazinhaParser.ComandoLocalAtribuicaoContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuazinhaParser#ultimocomando}.
	 * @param ctx the parse tree
	 */
	void enterUltimocomando(LuazinhaParser.UltimocomandoContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuazinhaParser#ultimocomando}.
	 * @param ctx the parse tree
	 */
	void exitUltimocomando(LuazinhaParser.UltimocomandoContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuazinhaParser#nomedafuncao}.
	 * @param ctx the parse tree
	 */
	void enterNomedafuncao(LuazinhaParser.NomedafuncaoContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuazinhaParser#nomedafuncao}.
	 * @param ctx the parse tree
	 */
	void exitNomedafuncao(LuazinhaParser.NomedafuncaoContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuazinhaParser#listavar}.
	 * @param ctx the parse tree
	 */
	void enterListavar(LuazinhaParser.ListavarContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuazinhaParser#listavar}.
	 * @param ctx the parse tree
	 */
	void exitListavar(LuazinhaParser.ListavarContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuazinhaParser#var}.
	 * @param ctx the parse tree
	 */
	void enterVar(LuazinhaParser.VarContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuazinhaParser#var}.
	 * @param ctx the parse tree
	 */
	void exitVar(LuazinhaParser.VarContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuazinhaParser#listadenomes}.
	 * @param ctx the parse tree
	 */
	void enterListadenomes(LuazinhaParser.ListadenomesContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuazinhaParser#listadenomes}.
	 * @param ctx the parse tree
	 */
	void exitListadenomes(LuazinhaParser.ListadenomesContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuazinhaParser#listaexp}.
	 * @param ctx the parse tree
	 */
	void enterListaexp(LuazinhaParser.ListaexpContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuazinhaParser#listaexp}.
	 * @param ctx the parse tree
	 */
	void exitListaexp(LuazinhaParser.ListaexpContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuazinhaParser#exp}.
	 * @param ctx the parse tree
	 */
	void enterExp(LuazinhaParser.ExpContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuazinhaParser#exp}.
	 * @param ctx the parse tree
	 */
	void exitExp(LuazinhaParser.ExpContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuazinhaParser#expprefixo}.
	 * @param ctx the parse tree
	 */
	void enterExpprefixo(LuazinhaParser.ExpprefixoContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuazinhaParser#expprefixo}.
	 * @param ctx the parse tree
	 */
	void exitExpprefixo(LuazinhaParser.ExpprefixoContext ctx);
	/**
	 * Enter a parse tree produced by the {@code expPrefixo2Var}
	 * labeled alternative in {@link LuazinhaParser#expprefixo2}.
	 * @param ctx the parse tree
	 */
	void enterExpPrefixo2Var(LuazinhaParser.ExpPrefixo2VarContext ctx);
	/**
	 * Exit a parse tree produced by the {@code expPrefixo2Var}
	 * labeled alternative in {@link LuazinhaParser#expprefixo2}.
	 * @param ctx the parse tree
	 */
	void exitExpPrefixo2Var(LuazinhaParser.ExpPrefixo2VarContext ctx);
	/**
	 * Enter a parse tree produced by the {@code expPrefixo2ChamadaDeFuncao}
	 * labeled alternative in {@link LuazinhaParser#expprefixo2}.
	 * @param ctx the parse tree
	 */
	void enterExpPrefixo2ChamadaDeFuncao(LuazinhaParser.ExpPrefixo2ChamadaDeFuncaoContext ctx);
	/**
	 * Exit a parse tree produced by the {@code expPrefixo2ChamadaDeFuncao}
	 * labeled alternative in {@link LuazinhaParser#expprefixo2}.
	 * @param ctx the parse tree
	 */
	void exitExpPrefixo2ChamadaDeFuncao(LuazinhaParser.ExpPrefixo2ChamadaDeFuncaoContext ctx);
	/**
	 * Enter a parse tree produced by the {@code expPrefixo2Exp}
	 * labeled alternative in {@link LuazinhaParser#expprefixo2}.
	 * @param ctx the parse tree
	 */
	void enterExpPrefixo2Exp(LuazinhaParser.ExpPrefixo2ExpContext ctx);
	/**
	 * Exit a parse tree produced by the {@code expPrefixo2Exp}
	 * labeled alternative in {@link LuazinhaParser#expprefixo2}.
	 * @param ctx the parse tree
	 */
	void exitExpPrefixo2Exp(LuazinhaParser.ExpPrefixo2ExpContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuazinhaParser#chamadadefuncao}.
	 * @param ctx the parse tree
	 */
	void enterChamadadefuncao(LuazinhaParser.ChamadadefuncaoContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuazinhaParser#chamadadefuncao}.
	 * @param ctx the parse tree
	 */
	void exitChamadadefuncao(LuazinhaParser.ChamadadefuncaoContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuazinhaParser#args}.
	 * @param ctx the parse tree
	 */
	void enterArgs(LuazinhaParser.ArgsContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuazinhaParser#args}.
	 * @param ctx the parse tree
	 */
	void exitArgs(LuazinhaParser.ArgsContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuazinhaParser#funcao}.
	 * @param ctx the parse tree
	 */
	void enterFuncao(LuazinhaParser.FuncaoContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuazinhaParser#funcao}.
	 * @param ctx the parse tree
	 */
	void exitFuncao(LuazinhaParser.FuncaoContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuazinhaParser#corpodafuncao}.
	 * @param ctx the parse tree
	 */
	void enterCorpodafuncao(LuazinhaParser.CorpodafuncaoContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuazinhaParser#corpodafuncao}.
	 * @param ctx the parse tree
	 */
	void exitCorpodafuncao(LuazinhaParser.CorpodafuncaoContext ctx);
	/**
	 * Enter a parse tree produced by the {@code listaParListaDeNomes}
	 * labeled alternative in {@link LuazinhaParser#listapar}.
	 * @param ctx the parse tree
	 */
	void enterListaParListaDeNomes(LuazinhaParser.ListaParListaDeNomesContext ctx);
	/**
	 * Exit a parse tree produced by the {@code listaParListaDeNomes}
	 * labeled alternative in {@link LuazinhaParser#listapar}.
	 * @param ctx the parse tree
	 */
	void exitListaParListaDeNomes(LuazinhaParser.ListaParListaDeNomesContext ctx);
	/**
	 * Enter a parse tree produced by the {@code listaParVarargs}
	 * labeled alternative in {@link LuazinhaParser#listapar}.
	 * @param ctx the parse tree
	 */
	void enterListaParVarargs(LuazinhaParser.ListaParVarargsContext ctx);
	/**
	 * Exit a parse tree produced by the {@code listaParVarargs}
	 * labeled alternative in {@link LuazinhaParser#listapar}.
	 * @param ctx the parse tree
	 */
	void exitListaParVarargs(LuazinhaParser.ListaParVarargsContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuazinhaParser#construtortabela}.
	 * @param ctx the parse tree
	 */
	void enterConstrutortabela(LuazinhaParser.ConstrutortabelaContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuazinhaParser#construtortabela}.
	 * @param ctx the parse tree
	 */
	void exitConstrutortabela(LuazinhaParser.ConstrutortabelaContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuazinhaParser#listadecampos}.
	 * @param ctx the parse tree
	 */
	void enterListadecampos(LuazinhaParser.ListadecamposContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuazinhaParser#listadecampos}.
	 * @param ctx the parse tree
	 */
	void exitListadecampos(LuazinhaParser.ListadecamposContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuazinhaParser#campo}.
	 * @param ctx the parse tree
	 */
	void enterCampo(LuazinhaParser.CampoContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuazinhaParser#campo}.
	 * @param ctx the parse tree
	 */
	void exitCampo(LuazinhaParser.CampoContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuazinhaParser#separadordecampos}.
	 * @param ctx the parse tree
	 */
	void enterSeparadordecampos(LuazinhaParser.SeparadordecamposContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuazinhaParser#separadordecampos}.
	 * @param ctx the parse tree
	 */
	void exitSeparadordecampos(LuazinhaParser.SeparadordecamposContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuazinhaParser#opbin}.
	 * @param ctx the parse tree
	 */
	void enterOpbin(LuazinhaParser.OpbinContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuazinhaParser#opbin}.
	 * @param ctx the parse tree
	 */
	void exitOpbin(LuazinhaParser.OpbinContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuazinhaParser#opunaria}.
	 * @param ctx the parse tree
	 */
	void enterOpunaria(LuazinhaParser.OpunariaContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuazinhaParser#opunaria}.
	 * @param ctx the parse tree
	 */
	void exitOpunaria(LuazinhaParser.OpunariaContext ctx);
}