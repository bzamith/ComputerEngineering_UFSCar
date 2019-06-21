// Generated from Lua.g4 by ANTLR 4.7.2
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link LuaParser}.
 */
public interface LuaListener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link LuaParser#programa}.
	 * @param ctx the parse tree
	 */
	void enterPrograma(LuaParser.ProgramaContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuaParser#programa}.
	 * @param ctx the parse tree
	 */
	void exitPrograma(LuaParser.ProgramaContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuaParser#bloco}.
	 * @param ctx the parse tree
	 */
	void enterBloco(LuaParser.BlocoContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuaParser#bloco}.
	 * @param ctx the parse tree
	 */
	void exitBloco(LuaParser.BlocoContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuaParser#trecho}.
	 * @param ctx the parse tree
	 */
	void enterTrecho(LuaParser.TrechoContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuaParser#trecho}.
	 * @param ctx the parse tree
	 */
	void exitTrecho(LuaParser.TrechoContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuaParser#comando}.
	 * @param ctx the parse tree
	 */
	void enterComando(LuaParser.ComandoContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuaParser#comando}.
	 * @param ctx the parse tree
	 */
	void exitComando(LuaParser.ComandoContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuaParser#ultimocomando}.
	 * @param ctx the parse tree
	 */
	void enterUltimocomando(LuaParser.UltimocomandoContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuaParser#ultimocomando}.
	 * @param ctx the parse tree
	 */
	void exitUltimocomando(LuaParser.UltimocomandoContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuaParser#nomedafuncao}.
	 * @param ctx the parse tree
	 */
	void enterNomedafuncao(LuaParser.NomedafuncaoContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuaParser#nomedafuncao}.
	 * @param ctx the parse tree
	 */
	void exitNomedafuncao(LuaParser.NomedafuncaoContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuaParser#listavar}.
	 * @param ctx the parse tree
	 */
	void enterListavar(LuaParser.ListavarContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuaParser#listavar}.
	 * @param ctx the parse tree
	 */
	void exitListavar(LuaParser.ListavarContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuaParser#listadenomes}.
	 * @param ctx the parse tree
	 */
	void enterListadenomes(LuaParser.ListadenomesContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuaParser#listadenomes}.
	 * @param ctx the parse tree
	 */
	void exitListadenomes(LuaParser.ListadenomesContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuaParser#listaexp}.
	 * @param ctx the parse tree
	 */
	void enterListaexp(LuaParser.ListaexpContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuaParser#listaexp}.
	 * @param ctx the parse tree
	 */
	void exitListaexp(LuaParser.ListaexpContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuaParser#exp}.
	 * @param ctx the parse tree
	 */
	void enterExp(LuaParser.ExpContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuaParser#exp}.
	 * @param ctx the parse tree
	 */
	void exitExp(LuaParser.ExpContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuaParser#exp2}.
	 * @param ctx the parse tree
	 */
	void enterExp2(LuaParser.Exp2Context ctx);
	/**
	 * Exit a parse tree produced by {@link LuaParser#exp2}.
	 * @param ctx the parse tree
	 */
	void exitExp2(LuaParser.Exp2Context ctx);
	/**
	 * Enter a parse tree produced by {@link LuaParser#expprefixo}.
	 * @param ctx the parse tree
	 */
	void enterExpprefixo(LuaParser.ExpprefixoContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuaParser#expprefixo}.
	 * @param ctx the parse tree
	 */
	void exitExpprefixo(LuaParser.ExpprefixoContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuaParser#expprefixo2}.
	 * @param ctx the parse tree
	 */
	void enterExpprefixo2(LuaParser.Expprefixo2Context ctx);
	/**
	 * Exit a parse tree produced by {@link LuaParser#expprefixo2}.
	 * @param ctx the parse tree
	 */
	void exitExpprefixo2(LuaParser.Expprefixo2Context ctx);
	/**
	 * Enter a parse tree produced by {@link LuaParser#var}.
	 * @param ctx the parse tree
	 */
	void enterVar(LuaParser.VarContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuaParser#var}.
	 * @param ctx the parse tree
	 */
	void exitVar(LuaParser.VarContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuaParser#args}.
	 * @param ctx the parse tree
	 */
	void enterArgs(LuaParser.ArgsContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuaParser#args}.
	 * @param ctx the parse tree
	 */
	void exitArgs(LuaParser.ArgsContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuaParser#funcao}.
	 * @param ctx the parse tree
	 */
	void enterFuncao(LuaParser.FuncaoContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuaParser#funcao}.
	 * @param ctx the parse tree
	 */
	void exitFuncao(LuaParser.FuncaoContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuaParser#corpodafuncao}.
	 * @param ctx the parse tree
	 */
	void enterCorpodafuncao(LuaParser.CorpodafuncaoContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuaParser#corpodafuncao}.
	 * @param ctx the parse tree
	 */
	void exitCorpodafuncao(LuaParser.CorpodafuncaoContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuaParser#listapar}.
	 * @param ctx the parse tree
	 */
	void enterListapar(LuaParser.ListaparContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuaParser#listapar}.
	 * @param ctx the parse tree
	 */
	void exitListapar(LuaParser.ListaparContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuaParser#construtortabela}.
	 * @param ctx the parse tree
	 */
	void enterConstrutortabela(LuaParser.ConstrutortabelaContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuaParser#construtortabela}.
	 * @param ctx the parse tree
	 */
	void exitConstrutortabela(LuaParser.ConstrutortabelaContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuaParser#listadecampos}.
	 * @param ctx the parse tree
	 */
	void enterListadecampos(LuaParser.ListadecamposContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuaParser#listadecampos}.
	 * @param ctx the parse tree
	 */
	void exitListadecampos(LuaParser.ListadecamposContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuaParser#campo}.
	 * @param ctx the parse tree
	 */
	void enterCampo(LuaParser.CampoContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuaParser#campo}.
	 * @param ctx the parse tree
	 */
	void exitCampo(LuaParser.CampoContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuaParser#separadordecampos}.
	 * @param ctx the parse tree
	 */
	void enterSeparadordecampos(LuaParser.SeparadordecamposContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuaParser#separadordecampos}.
	 * @param ctx the parse tree
	 */
	void exitSeparadordecampos(LuaParser.SeparadordecamposContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuaParser#opbin}.
	 * @param ctx the parse tree
	 */
	void enterOpbin(LuaParser.OpbinContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuaParser#opbin}.
	 * @param ctx the parse tree
	 */
	void exitOpbin(LuaParser.OpbinContext ctx);
	/**
	 * Enter a parse tree produced by {@link LuaParser#opunaria}.
	 * @param ctx the parse tree
	 */
	void enterOpunaria(LuaParser.OpunariaContext ctx);
	/**
	 * Exit a parse tree produced by {@link LuaParser#opunaria}.
	 * @param ctx the parse tree
	 */
	void exitOpunaria(LuaParser.OpunariaContext ctx);
}