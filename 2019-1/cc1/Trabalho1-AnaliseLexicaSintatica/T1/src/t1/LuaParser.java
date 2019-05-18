// Generated from Lua.g4 by ANTLR 4.7.2
package t1;
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class LuaParser extends Parser {
	static { RuntimeMetaData.checkVersion("4.7.2", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, T__1=2, T__2=3, T__3=4, T__4=5, T__5=6, T__6=7, T__7=8, T__8=9, 
		T__9=10, T__10=11, T__11=12, T__12=13, T__13=14, T__14=15, T__15=16, T__16=17, 
		T__17=18, T__18=19, T__19=20, T__20=21, T__21=22, T__22=23, T__23=24, 
		T__24=25, T__25=26, T__26=27, T__27=28, T__28=29, T__29=30, T__30=31, 
		T__31=32, T__32=33, T__33=34, T__34=35, T__35=36, T__36=37, T__37=38, 
		T__38=39, T__39=40, T__40=41, T__41=42, T__42=43, T__43=44, T__44=45, 
		T__45=46, T__46=47, Nome=48, Numero=49, Cadeia=50, COMENTARIO=51, WS=52;
	public static final int
		RULE_programa = 0, RULE_bloco = 1, RULE_trecho = 2, RULE_comando = 3, 
		RULE_ultimocomando = 4, RULE_nomedafuncao = 5, RULE_listavar = 6, RULE_listadenomes = 7, 
		RULE_listaexp = 8, RULE_exp = 9, RULE_exp2 = 10, RULE_expprefixo = 11, 
		RULE_expprefixo2 = 12, RULE_var = 13, RULE_args = 14, RULE_funcao = 15, 
		RULE_corpodafuncao = 16, RULE_listapar = 17, RULE_construtortabela = 18, 
		RULE_listadecampos = 19, RULE_campo = 20, RULE_separadordecampos = 21, 
		RULE_opbin = 22, RULE_opunaria = 23;
	private static String[] makeRuleNames() {
		return new String[] {
			"programa", "bloco", "trecho", "comando", "ultimocomando", "nomedafuncao", 
			"listavar", "listadenomes", "listaexp", "exp", "exp2", "expprefixo", 
			"expprefixo2", "var", "args", "funcao", "corpodafuncao", "listapar", 
			"construtortabela", "listadecampos", "campo", "separadordecampos", "opbin", 
			"opunaria"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "';'", "'='", "':'", "'do'", "'end'", "'while'", "'repeat'", "'until'", 
			"'if'", "'then'", "'elseif'", "'else'", "'for'", "','", "'in'", "'function'", 
			"'local'", "'return'", "'break'", "'.'", "'nil'", "'false'", "'true'", 
			"'...'", "'('", "')'", "'['", "']'", "'{'", "'}'", "'+'", "'-'", "'*'", 
			"'/'", "'^'", "'%'", "'..'", "'<'", "'<='", "'>'", "'>='", "'=='", "'~='", 
			"'and'", "'or'", "'not'", "'#'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, null, null, null, null, null, null, null, null, null, null, null, 
			"Nome", "Numero", "Cadeia", "COMENTARIO", "WS"
		};
	}
	private static final String[] _SYMBOLIC_NAMES = makeSymbolicNames();
	public static final Vocabulary VOCABULARY = new VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	@Deprecated
	public static final String[] tokenNames;
	static {
		tokenNames = new String[_SYMBOLIC_NAMES.length];
		for (int i = 0; i < tokenNames.length; i++) {
			tokenNames[i] = VOCABULARY.getLiteralName(i);
			if (tokenNames[i] == null) {
				tokenNames[i] = VOCABULARY.getSymbolicName(i);
			}

			if (tokenNames[i] == null) {
				tokenNames[i] = "<INVALID>";
			}
		}
	}

	@Override
	@Deprecated
	public String[] getTokenNames() {
		return tokenNames;
	}

	@Override

	public Vocabulary getVocabulary() {
		return VOCABULARY;
	}

	@Override
	public String getGrammarFileName() { return "Lua.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }


	   public static String grupo="<628093,628301,595160>";

	public LuaParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	public static class ProgramaContext extends ParserRuleContext {
		public TrechoContext trecho() {
			return getRuleContext(TrechoContext.class,0);
		}
		public ProgramaContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_programa; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).enterPrograma(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).exitPrograma(this);
		}
	}

	public final ProgramaContext programa() throws RecognitionException {
		ProgramaContext _localctx = new ProgramaContext(_ctx, getState());
		enterRule(_localctx, 0, RULE_programa);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(48);
			trecho();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class BlocoContext extends ParserRuleContext {
		public TrechoContext trecho() {
			return getRuleContext(TrechoContext.class,0);
		}
		public BlocoContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_bloco; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).enterBloco(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).exitBloco(this);
		}
	}

	public final BlocoContext bloco() throws RecognitionException {
		BlocoContext _localctx = new BlocoContext(_ctx, getState());
		enterRule(_localctx, 2, RULE_bloco);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(50);
			trecho();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class TrechoContext extends ParserRuleContext {
		public List<ComandoContext> comando() {
			return getRuleContexts(ComandoContext.class);
		}
		public ComandoContext comando(int i) {
			return getRuleContext(ComandoContext.class,i);
		}
		public UltimocomandoContext ultimocomando() {
			return getRuleContext(UltimocomandoContext.class,0);
		}
		public TrechoContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_trecho; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).enterTrecho(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).exitTrecho(this);
		}
	}

	public final TrechoContext trecho() throws RecognitionException {
		TrechoContext _localctx = new TrechoContext(_ctx, getState());
		enterRule(_localctx, 4, RULE_trecho);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(58);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__3) | (1L << T__5) | (1L << T__6) | (1L << T__8) | (1L << T__12) | (1L << T__15) | (1L << T__16) | (1L << T__24) | (1L << Nome))) != 0)) {
				{
				{
				setState(52);
				comando();
				setState(54);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==T__0) {
					{
					setState(53);
					match(T__0);
					}
				}

				}
				}
				setState(60);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(65);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__17 || _la==T__18) {
				{
				setState(61);
				ultimocomando();
				setState(63);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==T__0) {
					{
					setState(62);
					match(T__0);
					}
				}

				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ComandoContext extends ParserRuleContext {
		public ExpprefixoContext exp1;
		public ArgsContext a2;
		public Token nome1;
		public ListaexpContext list;
		public ListavarContext listavar() {
			return getRuleContext(ListavarContext.class,0);
		}
		public ListaexpContext listaexp() {
			return getRuleContext(ListaexpContext.class,0);
		}
		public ArgsContext args() {
			return getRuleContext(ArgsContext.class,0);
		}
		public ExpprefixoContext expprefixo() {
			return getRuleContext(ExpprefixoContext.class,0);
		}
		public TerminalNode Nome() { return getToken(LuaParser.Nome, 0); }
		public List<BlocoContext> bloco() {
			return getRuleContexts(BlocoContext.class);
		}
		public BlocoContext bloco(int i) {
			return getRuleContext(BlocoContext.class,i);
		}
		public List<ExpContext> exp() {
			return getRuleContexts(ExpContext.class);
		}
		public ExpContext exp(int i) {
			return getRuleContext(ExpContext.class,i);
		}
		public ListadenomesContext listadenomes() {
			return getRuleContext(ListadenomesContext.class,0);
		}
		public NomedafuncaoContext nomedafuncao() {
			return getRuleContext(NomedafuncaoContext.class,0);
		}
		public CorpodafuncaoContext corpodafuncao() {
			return getRuleContext(CorpodafuncaoContext.class,0);
		}
		public ComandoContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_comando; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).enterComando(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).exitComando(this);
		}
	}

	public final ComandoContext comando() throws RecognitionException {
		ComandoContext _localctx = new ComandoContext(_ctx, getState());
		enterRule(_localctx, 6, RULE_comando);
		int _la;
		try {
			setState(160);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,8,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(67);
				listavar();
				setState(68);
				match(T__1);
				setState(69);
				listaexp();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				{
				setState(71);
				((ComandoContext)_localctx).exp1 = expprefixo();
				setState(72);
				args();
				}
				 TabelaDeSimbolos.adicionarSimbolo((((ComandoContext)_localctx).exp1!=null?_input.getText(((ComandoContext)_localctx).exp1.start,((ComandoContext)_localctx).exp1.stop):null), Tipo.FUNCAO); 
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				{
				setState(76);
				expprefixo();
				setState(77);
				match(T__2);
				setState(78);
				match(Nome);
				setState(79);
				((ComandoContext)_localctx).a2 = args();
				}
				}
				break;
			case 4:
				enterOuterAlt(_localctx, 4);
				{
				setState(81);
				expprefixo();
				setState(82);
				match(T__2);
				setState(83);
				match(Nome);
				setState(84);
				args();
				}
				break;
			case 5:
				enterOuterAlt(_localctx, 5);
				{
				setState(86);
				match(T__3);
				setState(87);
				bloco();
				setState(88);
				match(T__4);
				}
				break;
			case 6:
				enterOuterAlt(_localctx, 6);
				{
				setState(90);
				match(T__5);
				setState(91);
				exp();
				setState(92);
				match(T__3);
				setState(93);
				bloco();
				setState(94);
				match(T__4);
				}
				break;
			case 7:
				enterOuterAlt(_localctx, 7);
				{
				setState(96);
				match(T__6);
				setState(97);
				bloco();
				setState(98);
				match(T__7);
				setState(99);
				exp();
				}
				break;
			case 8:
				enterOuterAlt(_localctx, 8);
				{
				setState(101);
				match(T__8);
				setState(102);
				exp();
				setState(103);
				match(T__9);
				setState(104);
				bloco();
				setState(112);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==T__10) {
					{
					{
					setState(105);
					match(T__10);
					setState(106);
					exp();
					setState(107);
					match(T__9);
					setState(108);
					bloco();
					}
					}
					setState(114);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(117);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==T__11) {
					{
					setState(115);
					match(T__11);
					setState(116);
					bloco();
					}
				}

				setState(119);
				match(T__4);
				}
				break;
			case 9:
				enterOuterAlt(_localctx, 9);
				{
				setState(121);
				match(T__12);
				setState(122);
				((ComandoContext)_localctx).nome1 = match(Nome);
				 TabelaDeSimbolos.adicionarSimbolo((((ComandoContext)_localctx).nome1!=null?((ComandoContext)_localctx).nome1.getText():null), Tipo.VARIAVEL); 
				setState(124);
				match(T__1);
				setState(125);
				exp();
				setState(126);
				match(T__13);
				setState(127);
				exp();
				setState(130);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==T__13) {
					{
					setState(128);
					match(T__13);
					setState(129);
					exp();
					}
				}

				setState(132);
				match(T__3);
				setState(133);
				bloco();
				setState(134);
				match(T__4);
				}
				break;
			case 10:
				enterOuterAlt(_localctx, 10);
				{
				setState(136);
				match(T__12);
				setState(137);
				listadenomes();
				setState(138);
				match(T__14);
				setState(139);
				listaexp();
				setState(140);
				match(T__3);
				setState(141);
				bloco();
				setState(142);
				match(T__4);
				}
				break;
			case 11:
				enterOuterAlt(_localctx, 11);
				{
				setState(144);
				match(T__15);
				setState(145);
				nomedafuncao();
				setState(146);
				corpodafuncao();
				}
				break;
			case 12:
				enterOuterAlt(_localctx, 12);
				{
				setState(148);
				match(T__16);
				setState(149);
				match(T__15);
				setState(150);
				match(Nome);
				setState(151);
				corpodafuncao();
				}
				break;
			case 13:
				enterOuterAlt(_localctx, 13);
				{
				setState(152);
				match(T__16);
				setState(153);
				listadenomes();
				setState(158);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==T__1) {
					{
					setState(154);
					match(T__1);
					setState(155);
					((ComandoContext)_localctx).list = listaexp();
					 TabelaDeSimbolos.adicionarSimbolo((((ComandoContext)_localctx).list!=null?_input.getText(((ComandoContext)_localctx).list.start,((ComandoContext)_localctx).list.stop):null), Tipo.VARIAVEL); 
					}
				}

				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class UltimocomandoContext extends ParserRuleContext {
		public ListaexpContext listaexp() {
			return getRuleContext(ListaexpContext.class,0);
		}
		public UltimocomandoContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_ultimocomando; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).enterUltimocomando(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).exitUltimocomando(this);
		}
	}

	public final UltimocomandoContext ultimocomando() throws RecognitionException {
		UltimocomandoContext _localctx = new UltimocomandoContext(_ctx, getState());
		enterRule(_localctx, 8, RULE_ultimocomando);
		int _la;
		try {
			setState(167);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__17:
				enterOuterAlt(_localctx, 1);
				{
				setState(162);
				match(T__17);
				setState(164);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__15) | (1L << T__20) | (1L << T__21) | (1L << T__22) | (1L << T__23) | (1L << T__24) | (1L << T__28) | (1L << T__31) | (1L << T__45) | (1L << T__46) | (1L << Nome) | (1L << Numero) | (1L << Cadeia))) != 0)) {
					{
					setState(163);
					listaexp();
					}
				}

				}
				break;
			case T__18:
				enterOuterAlt(_localctx, 2);
				{
				setState(166);
				match(T__18);
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class NomedafuncaoContext extends ParserRuleContext {
		public Token nome;
		public List<TerminalNode> Nome() { return getTokens(LuaParser.Nome); }
		public TerminalNode Nome(int i) {
			return getToken(LuaParser.Nome, i);
		}
		public NomedafuncaoContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_nomedafuncao; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).enterNomedafuncao(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).exitNomedafuncao(this);
		}
	}

	public final NomedafuncaoContext nomedafuncao() throws RecognitionException {
		NomedafuncaoContext _localctx = new NomedafuncaoContext(_ctx, getState());
		enterRule(_localctx, 10, RULE_nomedafuncao);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(169);
			((NomedafuncaoContext)_localctx).nome = match(Nome);
			TabelaDeSimbolos.adicionarSimbolo((((NomedafuncaoContext)_localctx).nome!=null?((NomedafuncaoContext)_localctx).nome.getText():null),Tipo.FUNCAO);
			setState(175);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==T__19) {
				{
				{
				setState(171);
				match(T__19);
				setState(172);
				match(Nome);
				}
				}
				setState(177);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(180);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__2) {
				{
				setState(178);
				match(T__2);
				setState(179);
				match(Nome);
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ListavarContext extends ParserRuleContext {
		public List<VarContext> var() {
			return getRuleContexts(VarContext.class);
		}
		public VarContext var(int i) {
			return getRuleContext(VarContext.class,i);
		}
		public ListavarContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_listavar; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).enterListavar(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).exitListavar(this);
		}
	}

	public final ListavarContext listavar() throws RecognitionException {
		ListavarContext _localctx = new ListavarContext(_ctx, getState());
		enterRule(_localctx, 12, RULE_listavar);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(182);
			var();
			setState(187);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==T__13) {
				{
				{
				setState(183);
				match(T__13);
				setState(184);
				var();
				}
				}
				setState(189);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ListadenomesContext extends ParserRuleContext {
		public Token nome1;
		public Token nome2;
		public List<TerminalNode> Nome() { return getTokens(LuaParser.Nome); }
		public TerminalNode Nome(int i) {
			return getToken(LuaParser.Nome, i);
		}
		public ListadenomesContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_listadenomes; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).enterListadenomes(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).exitListadenomes(this);
		}
	}

	public final ListadenomesContext listadenomes() throws RecognitionException {
		ListadenomesContext _localctx = new ListadenomesContext(_ctx, getState());
		enterRule(_localctx, 14, RULE_listadenomes);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(190);
			((ListadenomesContext)_localctx).nome1 = match(Nome);
			TabelaDeSimbolos.adicionarSimbolo((((ListadenomesContext)_localctx).nome1!=null?((ListadenomesContext)_localctx).nome1.getText():null),Tipo.VARIAVEL);
			setState(197);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,14,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(192);
					match(T__13);
					setState(193);
					((ListadenomesContext)_localctx).nome2 = match(Nome);
					TabelaDeSimbolos.adicionarSimbolo((((ListadenomesContext)_localctx).nome2!=null?((ListadenomesContext)_localctx).nome2.getText():null),Tipo.VARIAVEL);
					}
					} 
				}
				setState(199);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,14,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ListaexpContext extends ParserRuleContext {
		public List<ExpContext> exp() {
			return getRuleContexts(ExpContext.class);
		}
		public ExpContext exp(int i) {
			return getRuleContext(ExpContext.class,i);
		}
		public ListaexpContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_listaexp; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).enterListaexp(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).exitListaexp(this);
		}
	}

	public final ListaexpContext listaexp() throws RecognitionException {
		ListaexpContext _localctx = new ListaexpContext(_ctx, getState());
		enterRule(_localctx, 16, RULE_listaexp);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(205);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,15,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(200);
					exp();
					setState(201);
					match(T__13);
					}
					} 
				}
				setState(207);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,15,_ctx);
			}
			setState(208);
			exp();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ExpContext extends ParserRuleContext {
		public Exp2Context exp2() {
			return getRuleContext(Exp2Context.class,0);
		}
		public TerminalNode Numero() { return getToken(LuaParser.Numero, 0); }
		public TerminalNode Cadeia() { return getToken(LuaParser.Cadeia, 0); }
		public FuncaoContext funcao() {
			return getRuleContext(FuncaoContext.class,0);
		}
		public ExpprefixoContext expprefixo() {
			return getRuleContext(ExpprefixoContext.class,0);
		}
		public ConstrutortabelaContext construtortabela() {
			return getRuleContext(ConstrutortabelaContext.class,0);
		}
		public OpunariaContext opunaria() {
			return getRuleContext(OpunariaContext.class,0);
		}
		public ExpContext exp() {
			return getRuleContext(ExpContext.class,0);
		}
		public ExpContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_exp; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).enterExp(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).exitExp(this);
		}
	}

	public final ExpContext exp() throws RecognitionException {
		ExpContext _localctx = new ExpContext(_ctx, getState());
		enterRule(_localctx, 18, RULE_exp);
		try {
			setState(235);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__20:
				enterOuterAlt(_localctx, 1);
				{
				setState(210);
				match(T__20);
				setState(211);
				exp2();
				}
				break;
			case T__21:
				enterOuterAlt(_localctx, 2);
				{
				setState(212);
				match(T__21);
				setState(213);
				exp2();
				}
				break;
			case T__22:
				enterOuterAlt(_localctx, 3);
				{
				setState(214);
				match(T__22);
				setState(215);
				exp2();
				}
				break;
			case Numero:
				enterOuterAlt(_localctx, 4);
				{
				setState(216);
				match(Numero);
				setState(217);
				exp2();
				}
				break;
			case Cadeia:
				enterOuterAlt(_localctx, 5);
				{
				setState(218);
				match(Cadeia);
				setState(219);
				exp2();
				}
				break;
			case T__23:
				enterOuterAlt(_localctx, 6);
				{
				setState(220);
				match(T__23);
				setState(221);
				exp2();
				}
				break;
			case T__15:
				enterOuterAlt(_localctx, 7);
				{
				setState(222);
				funcao();
				setState(223);
				exp2();
				}
				break;
			case T__24:
			case Nome:
				enterOuterAlt(_localctx, 8);
				{
				setState(225);
				expprefixo();
				setState(226);
				exp2();
				}
				break;
			case T__28:
				enterOuterAlt(_localctx, 9);
				{
				setState(228);
				construtortabela();
				setState(229);
				exp2();
				}
				break;
			case T__31:
			case T__45:
			case T__46:
				enterOuterAlt(_localctx, 10);
				{
				setState(231);
				opunaria();
				setState(232);
				exp();
				setState(233);
				exp2();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Exp2Context extends ParserRuleContext {
		public List<OpbinContext> opbin() {
			return getRuleContexts(OpbinContext.class);
		}
		public OpbinContext opbin(int i) {
			return getRuleContext(OpbinContext.class,i);
		}
		public List<ExpContext> exp() {
			return getRuleContexts(ExpContext.class);
		}
		public ExpContext exp(int i) {
			return getRuleContext(ExpContext.class,i);
		}
		public Exp2Context(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_exp2; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).enterExp2(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).exitExp2(this);
		}
	}

	public final Exp2Context exp2() throws RecognitionException {
		Exp2Context _localctx = new Exp2Context(_ctx, getState());
		enterRule(_localctx, 20, RULE_exp2);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(242);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,17,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(237);
					opbin();
					setState(238);
					exp();
					}
					} 
				}
				setState(244);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,17,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ExpprefixoContext extends ParserRuleContext {
		public Token nome1;
		public Token nome2;
		public List<TerminalNode> Nome() { return getTokens(LuaParser.Nome); }
		public TerminalNode Nome(int i) {
			return getToken(LuaParser.Nome, i);
		}
		public Expprefixo2Context expprefixo2() {
			return getRuleContext(Expprefixo2Context.class,0);
		}
		public ExpContext exp() {
			return getRuleContext(ExpContext.class,0);
		}
		public ExpprefixoContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_expprefixo; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).enterExpprefixo(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).exitExpprefixo(this);
		}
	}

	public final ExpprefixoContext expprefixo() throws RecognitionException {
		ExpprefixoContext _localctx = new ExpprefixoContext(_ctx, getState());
		enterRule(_localctx, 22, RULE_expprefixo);
		try {
			setState(259);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,18,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(245);
				match(Nome);
				setState(246);
				expprefixo2();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(247);
				((ExpprefixoContext)_localctx).nome1 = match(Nome);
				{
				setState(248);
				match(T__19);
				setState(249);
				((ExpprefixoContext)_localctx).nome2 = match(Nome);
				setState(250);
				expprefixo2();
				}
				TabelaDeSimbolos.adicionarSimbolo((((ExpprefixoContext)_localctx).nome1!=null?((ExpprefixoContext)_localctx).nome1.getText():null) + '.' + (((ExpprefixoContext)_localctx).nome2!=null?((ExpprefixoContext)_localctx).nome2.getText():null),Tipo.FUNCAO);
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(254);
				match(T__24);
				setState(255);
				exp();
				setState(256);
				match(T__25);
				setState(257);
				expprefixo2();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Expprefixo2Context extends ParserRuleContext {
		public ArgsContext args() {
			return getRuleContext(ArgsContext.class,0);
		}
		public Expprefixo2Context expprefixo2() {
			return getRuleContext(Expprefixo2Context.class,0);
		}
		public TerminalNode Nome() { return getToken(LuaParser.Nome, 0); }
		public ExpContext exp() {
			return getRuleContext(ExpContext.class,0);
		}
		public Expprefixo2Context(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_expprefixo2; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).enterExpprefixo2(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).exitExpprefixo2(this);
		}
	}

	public final Expprefixo2Context expprefixo2() throws RecognitionException {
		Expprefixo2Context _localctx = new Expprefixo2Context(_ctx, getState());
		enterRule(_localctx, 24, RULE_expprefixo2);
		try {
			setState(275);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,19,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(261);
				args();
				setState(262);
				expprefixo2();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(264);
				match(T__2);
				setState(265);
				match(Nome);
				setState(266);
				args();
				setState(267);
				expprefixo2();
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(269);
				match(T__26);
				setState(270);
				exp();
				setState(271);
				match(T__27);
				setState(272);
				expprefixo2();
				}
				break;
			case 4:
				enterOuterAlt(_localctx, 4);
				{
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class VarContext extends ParserRuleContext {
		public Token nome;
		public TerminalNode Nome() { return getToken(LuaParser.Nome, 0); }
		public ExpprefixoContext expprefixo() {
			return getRuleContext(ExpprefixoContext.class,0);
		}
		public ExpContext exp() {
			return getRuleContext(ExpContext.class,0);
		}
		public VarContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_var; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).enterVar(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).exitVar(this);
		}
	}

	public final VarContext var() throws RecognitionException {
		VarContext _localctx = new VarContext(_ctx, getState());
		enterRule(_localctx, 26, RULE_var);
		try {
			setState(288);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,20,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(277);
				((VarContext)_localctx).nome = match(Nome);
				TabelaDeSimbolos.adicionarSimbolo((((VarContext)_localctx).nome!=null?((VarContext)_localctx).nome.getText():null),Tipo.VARIAVEL);
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(279);
				expprefixo();
				setState(280);
				match(T__26);
				setState(281);
				exp();
				setState(282);
				match(T__27);
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(284);
				expprefixo();
				setState(285);
				match(T__19);
				setState(286);
				match(Nome);
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ArgsContext extends ParserRuleContext {
		public ListaexpContext listaexp() {
			return getRuleContext(ListaexpContext.class,0);
		}
		public ConstrutortabelaContext construtortabela() {
			return getRuleContext(ConstrutortabelaContext.class,0);
		}
		public TerminalNode Cadeia() { return getToken(LuaParser.Cadeia, 0); }
		public ArgsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_args; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).enterArgs(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).exitArgs(this);
		}
	}

	public final ArgsContext args() throws RecognitionException {
		ArgsContext _localctx = new ArgsContext(_ctx, getState());
		enterRule(_localctx, 28, RULE_args);
		int _la;
		try {
			setState(297);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__24:
				enterOuterAlt(_localctx, 1);
				{
				setState(290);
				match(T__24);
				setState(292);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__15) | (1L << T__20) | (1L << T__21) | (1L << T__22) | (1L << T__23) | (1L << T__24) | (1L << T__28) | (1L << T__31) | (1L << T__45) | (1L << T__46) | (1L << Nome) | (1L << Numero) | (1L << Cadeia))) != 0)) {
					{
					setState(291);
					listaexp();
					}
				}

				setState(294);
				match(T__25);
				}
				break;
			case T__28:
				enterOuterAlt(_localctx, 2);
				{
				setState(295);
				construtortabela();
				}
				break;
			case Cadeia:
				enterOuterAlt(_localctx, 3);
				{
				setState(296);
				match(Cadeia);
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class FuncaoContext extends ParserRuleContext {
		public CorpodafuncaoContext corpodafuncao() {
			return getRuleContext(CorpodafuncaoContext.class,0);
		}
		public FuncaoContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_funcao; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).enterFuncao(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).exitFuncao(this);
		}
	}

	public final FuncaoContext funcao() throws RecognitionException {
		FuncaoContext _localctx = new FuncaoContext(_ctx, getState());
		enterRule(_localctx, 30, RULE_funcao);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(299);
			match(T__15);
			setState(300);
			corpodafuncao();
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class CorpodafuncaoContext extends ParserRuleContext {
		public BlocoContext bloco() {
			return getRuleContext(BlocoContext.class,0);
		}
		public ListaparContext listapar() {
			return getRuleContext(ListaparContext.class,0);
		}
		public CorpodafuncaoContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_corpodafuncao; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).enterCorpodafuncao(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).exitCorpodafuncao(this);
		}
	}

	public final CorpodafuncaoContext corpodafuncao() throws RecognitionException {
		CorpodafuncaoContext _localctx = new CorpodafuncaoContext(_ctx, getState());
		enterRule(_localctx, 32, RULE_corpodafuncao);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(302);
			match(T__24);
			setState(304);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__23 || _la==Nome) {
				{
				setState(303);
				listapar();
				}
			}

			setState(306);
			match(T__25);
			setState(307);
			bloco();
			setState(308);
			match(T__4);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ListaparContext extends ParserRuleContext {
		public ListadenomesContext listadenomes() {
			return getRuleContext(ListadenomesContext.class,0);
		}
		public ListaparContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_listapar; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).enterListapar(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).exitListapar(this);
		}
	}

	public final ListaparContext listapar() throws RecognitionException {
		ListaparContext _localctx = new ListaparContext(_ctx, getState());
		enterRule(_localctx, 34, RULE_listapar);
		int _la;
		try {
			setState(316);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case Nome:
				enterOuterAlt(_localctx, 1);
				{
				setState(310);
				listadenomes();
				setState(313);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==T__13) {
					{
					setState(311);
					match(T__13);
					setState(312);
					match(T__23);
					}
				}

				}
				break;
			case T__23:
				enterOuterAlt(_localctx, 2);
				{
				setState(315);
				match(T__23);
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ConstrutortabelaContext extends ParserRuleContext {
		public ListadecamposContext listadecampos() {
			return getRuleContext(ListadecamposContext.class,0);
		}
		public ConstrutortabelaContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_construtortabela; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).enterConstrutortabela(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).exitConstrutortabela(this);
		}
	}

	public final ConstrutortabelaContext construtortabela() throws RecognitionException {
		ConstrutortabelaContext _localctx = new ConstrutortabelaContext(_ctx, getState());
		enterRule(_localctx, 36, RULE_construtortabela);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(318);
			match(T__28);
			setState(320);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__15) | (1L << T__20) | (1L << T__21) | (1L << T__22) | (1L << T__23) | (1L << T__24) | (1L << T__26) | (1L << T__28) | (1L << T__31) | (1L << T__45) | (1L << T__46) | (1L << Nome) | (1L << Numero) | (1L << Cadeia))) != 0)) {
				{
				setState(319);
				listadecampos();
				}
			}

			setState(322);
			match(T__29);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class ListadecamposContext extends ParserRuleContext {
		public List<CampoContext> campo() {
			return getRuleContexts(CampoContext.class);
		}
		public CampoContext campo(int i) {
			return getRuleContext(CampoContext.class,i);
		}
		public List<SeparadordecamposContext> separadordecampos() {
			return getRuleContexts(SeparadordecamposContext.class);
		}
		public SeparadordecamposContext separadordecampos(int i) {
			return getRuleContext(SeparadordecamposContext.class,i);
		}
		public ListadecamposContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_listadecampos; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).enterListadecampos(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).exitListadecampos(this);
		}
	}

	public final ListadecamposContext listadecampos() throws RecognitionException {
		ListadecamposContext _localctx = new ListadecamposContext(_ctx, getState());
		enterRule(_localctx, 38, RULE_listadecampos);
		int _la;
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(324);
			campo();
			setState(330);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,27,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(325);
					separadordecampos();
					setState(326);
					campo();
					}
					} 
				}
				setState(332);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,27,_ctx);
			}
			setState(334);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__0 || _la==T__13) {
				{
				setState(333);
				separadordecampos();
				}
			}

			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class CampoContext extends ParserRuleContext {
		public List<ExpContext> exp() {
			return getRuleContexts(ExpContext.class);
		}
		public ExpContext exp(int i) {
			return getRuleContext(ExpContext.class,i);
		}
		public TerminalNode Nome() { return getToken(LuaParser.Nome, 0); }
		public CampoContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_campo; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).enterCampo(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).exitCampo(this);
		}
	}

	public final CampoContext campo() throws RecognitionException {
		CampoContext _localctx = new CampoContext(_ctx, getState());
		enterRule(_localctx, 40, RULE_campo);
		try {
			setState(346);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,29,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(336);
				match(T__26);
				setState(337);
				exp();
				setState(338);
				match(T__27);
				setState(339);
				match(T__1);
				setState(340);
				exp();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(342);
				match(Nome);
				setState(343);
				match(T__1);
				setState(344);
				exp();
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(345);
				exp();
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class SeparadordecamposContext extends ParserRuleContext {
		public SeparadordecamposContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_separadordecampos; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).enterSeparadordecampos(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).exitSeparadordecampos(this);
		}
	}

	public final SeparadordecamposContext separadordecampos() throws RecognitionException {
		SeparadordecamposContext _localctx = new SeparadordecamposContext(_ctx, getState());
		enterRule(_localctx, 42, RULE_separadordecampos);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(348);
			_la = _input.LA(1);
			if ( !(_la==T__0 || _la==T__13) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class OpbinContext extends ParserRuleContext {
		public OpbinContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_opbin; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).enterOpbin(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).exitOpbin(this);
		}
	}

	public final OpbinContext opbin() throws RecognitionException {
		OpbinContext _localctx = new OpbinContext(_ctx, getState());
		enterRule(_localctx, 44, RULE_opbin);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(350);
			_la = _input.LA(1);
			if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__30) | (1L << T__31) | (1L << T__32) | (1L << T__33) | (1L << T__34) | (1L << T__35) | (1L << T__36) | (1L << T__37) | (1L << T__38) | (1L << T__39) | (1L << T__40) | (1L << T__41) | (1L << T__42) | (1L << T__43) | (1L << T__44))) != 0)) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class OpunariaContext extends ParserRuleContext {
		public OpunariaContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_opunaria; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).enterOpunaria(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuaListener ) ((LuaListener)listener).exitOpunaria(this);
		}
	}

	public final OpunariaContext opunaria() throws RecognitionException {
		OpunariaContext _localctx = new OpunariaContext(_ctx, getState());
		enterRule(_localctx, 46, RULE_opunaria);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(352);
			_la = _input.LA(1);
			if ( !((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__31) | (1L << T__45) | (1L << T__46))) != 0)) ) {
			_errHandler.recoverInline(this);
			}
			else {
				if ( _input.LA(1)==Token.EOF ) matchedEOF = true;
				_errHandler.reportMatch(this);
				consume();
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static final String _serializedATN =
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3\66\u0165\4\2\t\2"+
		"\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13"+
		"\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22"+
		"\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31\t\31"+
		"\3\2\3\2\3\3\3\3\3\4\3\4\5\49\n\4\7\4;\n\4\f\4\16\4>\13\4\3\4\3\4\5\4"+
		"B\n\4\5\4D\n\4\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5"+
		"\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3"+
		"\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\7\5q\n\5\f\5\16\5t\13\5"+
		"\3\5\3\5\5\5x\n\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\5\5\u0085"+
		"\n\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3"+
		"\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\5\5\u00a1\n\5\5\5\u00a3\n\5\3\6"+
		"\3\6\5\6\u00a7\n\6\3\6\5\6\u00aa\n\6\3\7\3\7\3\7\3\7\7\7\u00b0\n\7\f\7"+
		"\16\7\u00b3\13\7\3\7\3\7\5\7\u00b7\n\7\3\b\3\b\3\b\7\b\u00bc\n\b\f\b\16"+
		"\b\u00bf\13\b\3\t\3\t\3\t\3\t\3\t\7\t\u00c6\n\t\f\t\16\t\u00c9\13\t\3"+
		"\n\3\n\3\n\7\n\u00ce\n\n\f\n\16\n\u00d1\13\n\3\n\3\n\3\13\3\13\3\13\3"+
		"\13\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3\13\3"+
		"\13\3\13\3\13\3\13\3\13\3\13\3\13\3\13\5\13\u00ee\n\13\3\f\3\f\3\f\7\f"+
		"\u00f3\n\f\f\f\16\f\u00f6\13\f\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r\3\r"+
		"\3\r\3\r\3\r\3\r\5\r\u0106\n\r\3\16\3\16\3\16\3\16\3\16\3\16\3\16\3\16"+
		"\3\16\3\16\3\16\3\16\3\16\3\16\5\16\u0116\n\16\3\17\3\17\3\17\3\17\3\17"+
		"\3\17\3\17\3\17\3\17\3\17\3\17\5\17\u0123\n\17\3\20\3\20\5\20\u0127\n"+
		"\20\3\20\3\20\3\20\5\20\u012c\n\20\3\21\3\21\3\21\3\22\3\22\5\22\u0133"+
		"\n\22\3\22\3\22\3\22\3\22\3\23\3\23\3\23\5\23\u013c\n\23\3\23\5\23\u013f"+
		"\n\23\3\24\3\24\5\24\u0143\n\24\3\24\3\24\3\25\3\25\3\25\3\25\7\25\u014b"+
		"\n\25\f\25\16\25\u014e\13\25\3\25\5\25\u0151\n\25\3\26\3\26\3\26\3\26"+
		"\3\26\3\26\3\26\3\26\3\26\3\26\5\26\u015d\n\26\3\27\3\27\3\30\3\30\3\31"+
		"\3\31\3\31\2\2\32\2\4\6\b\n\f\16\20\22\24\26\30\32\34\36 \"$&(*,.\60\2"+
		"\5\4\2\3\3\20\20\3\2!/\4\2\"\"\60\61\2\u0183\2\62\3\2\2\2\4\64\3\2\2\2"+
		"\6<\3\2\2\2\b\u00a2\3\2\2\2\n\u00a9\3\2\2\2\f\u00ab\3\2\2\2\16\u00b8\3"+
		"\2\2\2\20\u00c0\3\2\2\2\22\u00cf\3\2\2\2\24\u00ed\3\2\2\2\26\u00f4\3\2"+
		"\2\2\30\u0105\3\2\2\2\32\u0115\3\2\2\2\34\u0122\3\2\2\2\36\u012b\3\2\2"+
		"\2 \u012d\3\2\2\2\"\u0130\3\2\2\2$\u013e\3\2\2\2&\u0140\3\2\2\2(\u0146"+
		"\3\2\2\2*\u015c\3\2\2\2,\u015e\3\2\2\2.\u0160\3\2\2\2\60\u0162\3\2\2\2"+
		"\62\63\5\6\4\2\63\3\3\2\2\2\64\65\5\6\4\2\65\5\3\2\2\2\668\5\b\5\2\67"+
		"9\7\3\2\28\67\3\2\2\289\3\2\2\29;\3\2\2\2:\66\3\2\2\2;>\3\2\2\2<:\3\2"+
		"\2\2<=\3\2\2\2=C\3\2\2\2><\3\2\2\2?A\5\n\6\2@B\7\3\2\2A@\3\2\2\2AB\3\2"+
		"\2\2BD\3\2\2\2C?\3\2\2\2CD\3\2\2\2D\7\3\2\2\2EF\5\16\b\2FG\7\4\2\2GH\5"+
		"\22\n\2H\u00a3\3\2\2\2IJ\5\30\r\2JK\5\36\20\2KL\3\2\2\2LM\b\5\1\2M\u00a3"+
		"\3\2\2\2NO\5\30\r\2OP\7\5\2\2PQ\7\62\2\2QR\5\36\20\2R\u00a3\3\2\2\2ST"+
		"\5\30\r\2TU\7\5\2\2UV\7\62\2\2VW\5\36\20\2W\u00a3\3\2\2\2XY\7\6\2\2YZ"+
		"\5\4\3\2Z[\7\7\2\2[\u00a3\3\2\2\2\\]\7\b\2\2]^\5\24\13\2^_\7\6\2\2_`\5"+
		"\4\3\2`a\7\7\2\2a\u00a3\3\2\2\2bc\7\t\2\2cd\5\4\3\2de\7\n\2\2ef\5\24\13"+
		"\2f\u00a3\3\2\2\2gh\7\13\2\2hi\5\24\13\2ij\7\f\2\2jr\5\4\3\2kl\7\r\2\2"+
		"lm\5\24\13\2mn\7\f\2\2no\5\4\3\2oq\3\2\2\2pk\3\2\2\2qt\3\2\2\2rp\3\2\2"+
		"\2rs\3\2\2\2sw\3\2\2\2tr\3\2\2\2uv\7\16\2\2vx\5\4\3\2wu\3\2\2\2wx\3\2"+
		"\2\2xy\3\2\2\2yz\7\7\2\2z\u00a3\3\2\2\2{|\7\17\2\2|}\7\62\2\2}~\b\5\1"+
		"\2~\177\7\4\2\2\177\u0080\5\24\13\2\u0080\u0081\7\20\2\2\u0081\u0084\5"+
		"\24\13\2\u0082\u0083\7\20\2\2\u0083\u0085\5\24\13\2\u0084\u0082\3\2\2"+
		"\2\u0084\u0085\3\2\2\2\u0085\u0086\3\2\2\2\u0086\u0087\7\6\2\2\u0087\u0088"+
		"\5\4\3\2\u0088\u0089\7\7\2\2\u0089\u00a3\3\2\2\2\u008a\u008b\7\17\2\2"+
		"\u008b\u008c\5\20\t\2\u008c\u008d\7\21\2\2\u008d\u008e\5\22\n\2\u008e"+
		"\u008f\7\6\2\2\u008f\u0090\5\4\3\2\u0090\u0091\7\7\2\2\u0091\u00a3\3\2"+
		"\2\2\u0092\u0093\7\22\2\2\u0093\u0094\5\f\7\2\u0094\u0095\5\"\22\2\u0095"+
		"\u00a3\3\2\2\2\u0096\u0097\7\23\2\2\u0097\u0098\7\22\2\2\u0098\u0099\7"+
		"\62\2\2\u0099\u00a3\5\"\22\2\u009a\u009b\7\23\2\2\u009b\u00a0\5\20\t\2"+
		"\u009c\u009d\7\4\2\2\u009d\u009e\5\22\n\2\u009e\u009f\b\5\1\2\u009f\u00a1"+
		"\3\2\2\2\u00a0\u009c\3\2\2\2\u00a0\u00a1\3\2\2\2\u00a1\u00a3\3\2\2\2\u00a2"+
		"E\3\2\2\2\u00a2I\3\2\2\2\u00a2N\3\2\2\2\u00a2S\3\2\2\2\u00a2X\3\2\2\2"+
		"\u00a2\\\3\2\2\2\u00a2b\3\2\2\2\u00a2g\3\2\2\2\u00a2{\3\2\2\2\u00a2\u008a"+
		"\3\2\2\2\u00a2\u0092\3\2\2\2\u00a2\u0096\3\2\2\2\u00a2\u009a\3\2\2\2\u00a3"+
		"\t\3\2\2\2\u00a4\u00a6\7\24\2\2\u00a5\u00a7\5\22\n\2\u00a6\u00a5\3\2\2"+
		"\2\u00a6\u00a7\3\2\2\2\u00a7\u00aa\3\2\2\2\u00a8\u00aa\7\25\2\2\u00a9"+
		"\u00a4\3\2\2\2\u00a9\u00a8\3\2\2\2\u00aa\13\3\2\2\2\u00ab\u00ac\7\62\2"+
		"\2\u00ac\u00b1\b\7\1\2\u00ad\u00ae\7\26\2\2\u00ae\u00b0\7\62\2\2\u00af"+
		"\u00ad\3\2\2\2\u00b0\u00b3\3\2\2\2\u00b1\u00af\3\2\2\2\u00b1\u00b2\3\2"+
		"\2\2\u00b2\u00b6\3\2\2\2\u00b3\u00b1\3\2\2\2\u00b4\u00b5\7\5\2\2\u00b5"+
		"\u00b7\7\62\2\2\u00b6\u00b4\3\2\2\2\u00b6\u00b7\3\2\2\2\u00b7\r\3\2\2"+
		"\2\u00b8\u00bd\5\34\17\2\u00b9\u00ba\7\20\2\2\u00ba\u00bc\5\34\17\2\u00bb"+
		"\u00b9\3\2\2\2\u00bc\u00bf\3\2\2\2\u00bd\u00bb\3\2\2\2\u00bd\u00be\3\2"+
		"\2\2\u00be\17\3\2\2\2\u00bf\u00bd\3\2\2\2\u00c0\u00c1\7\62\2\2\u00c1\u00c7"+
		"\b\t\1\2\u00c2\u00c3\7\20\2\2\u00c3\u00c4\7\62\2\2\u00c4\u00c6\b\t\1\2"+
		"\u00c5\u00c2\3\2\2\2\u00c6\u00c9\3\2\2\2\u00c7\u00c5\3\2\2\2\u00c7\u00c8"+
		"\3\2\2\2\u00c8\21\3\2\2\2\u00c9\u00c7\3\2\2\2\u00ca\u00cb\5\24\13\2\u00cb"+
		"\u00cc\7\20\2\2\u00cc\u00ce\3\2\2\2\u00cd\u00ca\3\2\2\2\u00ce\u00d1\3"+
		"\2\2\2\u00cf\u00cd\3\2\2\2\u00cf\u00d0\3\2\2\2\u00d0\u00d2\3\2\2\2\u00d1"+
		"\u00cf\3\2\2\2\u00d2\u00d3\5\24\13\2\u00d3\23\3\2\2\2\u00d4\u00d5\7\27"+
		"\2\2\u00d5\u00ee\5\26\f\2\u00d6\u00d7\7\30\2\2\u00d7\u00ee\5\26\f\2\u00d8"+
		"\u00d9\7\31\2\2\u00d9\u00ee\5\26\f\2\u00da\u00db\7\63\2\2\u00db\u00ee"+
		"\5\26\f\2\u00dc\u00dd\7\64\2\2\u00dd\u00ee\5\26\f\2\u00de\u00df\7\32\2"+
		"\2\u00df\u00ee\5\26\f\2\u00e0\u00e1\5 \21\2\u00e1\u00e2\5\26\f\2\u00e2"+
		"\u00ee\3\2\2\2\u00e3\u00e4\5\30\r\2\u00e4\u00e5\5\26\f\2\u00e5\u00ee\3"+
		"\2\2\2\u00e6\u00e7\5&\24\2\u00e7\u00e8\5\26\f\2\u00e8\u00ee\3\2\2\2\u00e9"+
		"\u00ea\5\60\31\2\u00ea\u00eb\5\24\13\2\u00eb\u00ec\5\26\f\2\u00ec\u00ee"+
		"\3\2\2\2\u00ed\u00d4\3\2\2\2\u00ed\u00d6\3\2\2\2\u00ed\u00d8\3\2\2\2\u00ed"+
		"\u00da\3\2\2\2\u00ed\u00dc\3\2\2\2\u00ed\u00de\3\2\2\2\u00ed\u00e0\3\2"+
		"\2\2\u00ed\u00e3\3\2\2\2\u00ed\u00e6\3\2\2\2\u00ed\u00e9\3\2\2\2\u00ee"+
		"\25\3\2\2\2\u00ef\u00f0\5.\30\2\u00f0\u00f1\5\24\13\2\u00f1\u00f3\3\2"+
		"\2\2\u00f2\u00ef\3\2\2\2\u00f3\u00f6\3\2\2\2\u00f4\u00f2\3\2\2\2\u00f4"+
		"\u00f5\3\2\2\2\u00f5\27\3\2\2\2\u00f6\u00f4\3\2\2\2\u00f7\u00f8\7\62\2"+
		"\2\u00f8\u0106\5\32\16\2\u00f9\u00fa\7\62\2\2\u00fa\u00fb\7\26\2\2\u00fb"+
		"\u00fc\7\62\2\2\u00fc\u00fd\5\32\16\2\u00fd\u00fe\3\2\2\2\u00fe\u00ff"+
		"\b\r\1\2\u00ff\u0106\3\2\2\2\u0100\u0101\7\33\2\2\u0101\u0102\5\24\13"+
		"\2\u0102\u0103\7\34\2\2\u0103\u0104\5\32\16\2\u0104\u0106\3\2\2\2\u0105"+
		"\u00f7\3\2\2\2\u0105\u00f9\3\2\2\2\u0105\u0100\3\2\2\2\u0106\31\3\2\2"+
		"\2\u0107\u0108\5\36\20\2\u0108\u0109\5\32\16\2\u0109\u0116\3\2\2\2\u010a"+
		"\u010b\7\5\2\2\u010b\u010c\7\62\2\2\u010c\u010d\5\36\20\2\u010d\u010e"+
		"\5\32\16\2\u010e\u0116\3\2\2\2\u010f\u0110\7\35\2\2\u0110\u0111\5\24\13"+
		"\2\u0111\u0112\7\36\2\2\u0112\u0113\5\32\16\2\u0113\u0116\3\2\2\2\u0114"+
		"\u0116\3\2\2\2\u0115\u0107\3\2\2\2\u0115\u010a\3\2\2\2\u0115\u010f\3\2"+
		"\2\2\u0115\u0114\3\2\2\2\u0116\33\3\2\2\2\u0117\u0118\7\62\2\2\u0118\u0123"+
		"\b\17\1\2\u0119\u011a\5\30\r\2\u011a\u011b\7\35\2\2\u011b\u011c\5\24\13"+
		"\2\u011c\u011d\7\36\2\2\u011d\u0123\3\2\2\2\u011e\u011f\5\30\r\2\u011f"+
		"\u0120\7\26\2\2\u0120\u0121\7\62\2\2\u0121\u0123\3\2\2\2\u0122\u0117\3"+
		"\2\2\2\u0122\u0119\3\2\2\2\u0122\u011e\3\2\2\2\u0123\35\3\2\2\2\u0124"+
		"\u0126\7\33\2\2\u0125\u0127\5\22\n\2\u0126\u0125\3\2\2\2\u0126\u0127\3"+
		"\2\2\2\u0127\u0128\3\2\2\2\u0128\u012c\7\34\2\2\u0129\u012c\5&\24\2\u012a"+
		"\u012c\7\64\2\2\u012b\u0124\3\2\2\2\u012b\u0129\3\2\2\2\u012b\u012a\3"+
		"\2\2\2\u012c\37\3\2\2\2\u012d\u012e\7\22\2\2\u012e\u012f\5\"\22\2\u012f"+
		"!\3\2\2\2\u0130\u0132\7\33\2\2\u0131\u0133\5$\23\2\u0132\u0131\3\2\2\2"+
		"\u0132\u0133\3\2\2\2\u0133\u0134\3\2\2\2\u0134\u0135\7\34\2\2\u0135\u0136"+
		"\5\4\3\2\u0136\u0137\7\7\2\2\u0137#\3\2\2\2\u0138\u013b\5\20\t\2\u0139"+
		"\u013a\7\20\2\2\u013a\u013c\7\32\2\2\u013b\u0139\3\2\2\2\u013b\u013c\3"+
		"\2\2\2\u013c\u013f\3\2\2\2\u013d\u013f\7\32\2\2\u013e\u0138\3\2\2\2\u013e"+
		"\u013d\3\2\2\2\u013f%\3\2\2\2\u0140\u0142\7\37\2\2\u0141\u0143\5(\25\2"+
		"\u0142\u0141\3\2\2\2\u0142\u0143\3\2\2\2\u0143\u0144\3\2\2\2\u0144\u0145"+
		"\7 \2\2\u0145\'\3\2\2\2\u0146\u014c\5*\26\2\u0147\u0148\5,\27\2\u0148"+
		"\u0149\5*\26\2\u0149\u014b\3\2\2\2\u014a\u0147\3\2\2\2\u014b\u014e\3\2"+
		"\2\2\u014c\u014a\3\2\2\2\u014c\u014d\3\2\2\2\u014d\u0150\3\2\2\2\u014e"+
		"\u014c\3\2\2\2\u014f\u0151\5,\27\2\u0150\u014f\3\2\2\2\u0150\u0151\3\2"+
		"\2\2\u0151)\3\2\2\2\u0152\u0153\7\35\2\2\u0153\u0154\5\24\13\2\u0154\u0155"+
		"\7\36\2\2\u0155\u0156\7\4\2\2\u0156\u0157\5\24\13\2\u0157\u015d\3\2\2"+
		"\2\u0158\u0159\7\62\2\2\u0159\u015a\7\4\2\2\u015a\u015d\5\24\13\2\u015b"+
		"\u015d\5\24\13\2\u015c\u0152\3\2\2\2\u015c\u0158\3\2\2\2\u015c\u015b\3"+
		"\2\2\2\u015d+\3\2\2\2\u015e\u015f\t\2\2\2\u015f-\3\2\2\2\u0160\u0161\t"+
		"\3\2\2\u0161/\3\2\2\2\u0162\u0163\t\4\2\2\u0163\61\3\2\2\2 8<ACrw\u0084"+
		"\u00a0\u00a2\u00a6\u00a9\u00b1\u00b6\u00bd\u00c7\u00cf\u00ed\u00f4\u0105"+
		"\u0115\u0122\u0126\u012b\u0132\u013b\u013e\u0142\u014c\u0150\u015c";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}