// Generated from Luazinha.g4 by ANTLR 4.7.2
package trabalho2;
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class LuazinhaParser extends Parser {
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
		T__45=46, T__46=47, NOME=48, CADEIA=49, NUMERO=50, COMENTARIO=51, WS=52;
	public static final int
		RULE_programa = 0, RULE_trecho = 1, RULE_bloco = 2, RULE_comando = 3, 
		RULE_ultimocomando = 4, RULE_nomedafuncao = 5, RULE_listavar = 6, RULE_var = 7, 
		RULE_listadenomes = 8, RULE_listaexp = 9, RULE_exp = 10, RULE_expprefixo = 11, 
		RULE_expprefixo2 = 12, RULE_chamadadefuncao = 13, RULE_args = 14, RULE_funcao = 15, 
		RULE_corpodafuncao = 16, RULE_listapar = 17, RULE_construtortabela = 18, 
		RULE_listadecampos = 19, RULE_campo = 20, RULE_separadordecampos = 21, 
		RULE_opbin = 22, RULE_opunaria = 23;
	private static String[] makeRuleNames() {
		return new String[] {
			"programa", "trecho", "bloco", "comando", "ultimocomando", "nomedafuncao", 
			"listavar", "var", "listadenomes", "listaexp", "exp", "expprefixo", "expprefixo2", 
			"chamadadefuncao", "args", "funcao", "corpodafuncao", "listapar", "construtortabela", 
			"listadecampos", "campo", "separadordecampos", "opbin", "opunaria"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "';'", "'='", "'do'", "'end'", "'while'", "'repeat'", "'until'", 
			"'if'", "'then'", "'elseif'", "'else'", "'for'", "','", "'in'", "'function'", 
			"'local'", "'return'", "'break'", "'.'", "':'", "'['", "']'", "'nil'", 
			"'false'", "'true'", "'...'", "'('", "')'", "'{'", "'}'", "'+'", "'-'", 
			"'*'", "'/'", "'^'", "'%'", "'..'", "'<'", "'<='", "'>'", "'>='", "'=='", 
			"'~='", "'and'", "'or'", "'not'", "'#'"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, null, null, null, null, null, null, null, null, null, null, null, 
			null, null, null, null, null, null, null, null, null, null, null, null, 
			"NOME", "CADEIA", "NUMERO", "COMENTARIO", "WS"
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
	public String getGrammarFileName() { return "Luazinha.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }


	public static String grupo = "<628093,628301,595160>";
	PilhaDeTabelas pilhaDeTabelas = new PilhaDeTabelas();

	public LuazinhaParser(TokenStream input) {
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
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterPrograma(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitPrograma(this);
		}
	}

	public final ProgramaContext programa() throws RecognitionException {
		ProgramaContext _localctx = new ProgramaContext(_ctx, getState());
		enterRule(_localctx, 0, RULE_programa);
		try {
			enterOuterAlt(_localctx, 1);
			{
			pilhaDeTabelas.empilhar(new TabelaDeSimbolos("global")); 
			setState(49);
			trecho();
			pilhaDeTabelas.desempilhar(); 
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
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterTrecho(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitTrecho(this);
		}
	}

	public final TrechoContext trecho() throws RecognitionException {
		TrechoContext _localctx = new TrechoContext(_ctx, getState());
		enterRule(_localctx, 2, RULE_trecho);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(58);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__2) | (1L << T__4) | (1L << T__5) | (1L << T__7) | (1L << T__11) | (1L << T__14) | (1L << T__15) | (1L << NOME))) != 0)) {
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
			if (_la==T__16 || _la==T__17) {
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
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterBloco(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitBloco(this);
		}
	}

	public final BlocoContext bloco() throws RecognitionException {
		BlocoContext _localctx = new BlocoContext(_ctx, getState());
		enterRule(_localctx, 4, RULE_bloco);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(67);
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

	public static class ComandoContext extends ParserRuleContext {
		public ComandoContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_comando; }
	 
		public ComandoContext() { }
		public void copyFrom(ComandoContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class ComandoLocalAtribuicaoContext extends ComandoContext {
		public ListadenomesContext listadenomes;
		public ListadenomesContext listadenomes() {
			return getRuleContext(ListadenomesContext.class,0);
		}
		public ListaexpContext listaexp() {
			return getRuleContext(ListaexpContext.class,0);
		}
		public ComandoLocalAtribuicaoContext(ComandoContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterComandoLocalAtribuicao(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitComandoLocalAtribuicao(this);
		}
	}
	public static class ComandoLocalFunctionContext extends ComandoContext {
		public TerminalNode NOME() { return getToken(LuazinhaParser.NOME, 0); }
		public CorpodafuncaoContext corpodafuncao() {
			return getRuleContext(CorpodafuncaoContext.class,0);
		}
		public ComandoLocalFunctionContext(ComandoContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterComandoLocalFunction(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitComandoLocalFunction(this);
		}
	}
	public static class ComandoIfContext extends ComandoContext {
		public List<ExpContext> exp() {
			return getRuleContexts(ExpContext.class);
		}
		public ExpContext exp(int i) {
			return getRuleContext(ExpContext.class,i);
		}
		public List<BlocoContext> bloco() {
			return getRuleContexts(BlocoContext.class);
		}
		public BlocoContext bloco(int i) {
			return getRuleContext(BlocoContext.class,i);
		}
		public ComandoIfContext(ComandoContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterComandoIf(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitComandoIf(this);
		}
	}
	public static class ComandoAtribuicaoContext extends ComandoContext {
		public ListavarContext listavar;
		public ListavarContext listavar() {
			return getRuleContext(ListavarContext.class,0);
		}
		public ListaexpContext listaexp() {
			return getRuleContext(ListaexpContext.class,0);
		}
		public ComandoAtribuicaoContext(ComandoContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterComandoAtribuicao(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitComandoAtribuicao(this);
		}
	}
	public static class ComandoDoContext extends ComandoContext {
		public BlocoContext bloco() {
			return getRuleContext(BlocoContext.class,0);
		}
		public ComandoDoContext(ComandoContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterComandoDo(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitComandoDo(this);
		}
	}
	public static class ComandoFunctionContext extends ComandoContext {
		public NomedafuncaoContext nomedafuncao;
		public NomedafuncaoContext nomedafuncao() {
			return getRuleContext(NomedafuncaoContext.class,0);
		}
		public CorpodafuncaoContext corpodafuncao() {
			return getRuleContext(CorpodafuncaoContext.class,0);
		}
		public ComandoFunctionContext(ComandoContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterComandoFunction(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitComandoFunction(this);
		}
	}
	public static class ComandoChamadaDeFuncaoContext extends ComandoContext {
		public ChamadadefuncaoContext chamadadefuncao() {
			return getRuleContext(ChamadadefuncaoContext.class,0);
		}
		public ComandoChamadaDeFuncaoContext(ComandoContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterComandoChamadaDeFuncao(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitComandoChamadaDeFuncao(this);
		}
	}
	public static class ComandoWhileContext extends ComandoContext {
		public ExpContext exp() {
			return getRuleContext(ExpContext.class,0);
		}
		public BlocoContext bloco() {
			return getRuleContext(BlocoContext.class,0);
		}
		public ComandoWhileContext(ComandoContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterComandoWhile(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitComandoWhile(this);
		}
	}
	public static class ComandoRepeatContext extends ComandoContext {
		public BlocoContext bloco() {
			return getRuleContext(BlocoContext.class,0);
		}
		public ExpContext exp() {
			return getRuleContext(ExpContext.class,0);
		}
		public ComandoRepeatContext(ComandoContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterComandoRepeat(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitComandoRepeat(this);
		}
	}
	public static class ComandoFor2Context extends ComandoContext {
		public ListadenomesContext listadenomes;
		public ListadenomesContext listadenomes() {
			return getRuleContext(ListadenomesContext.class,0);
		}
		public ListaexpContext listaexp() {
			return getRuleContext(ListaexpContext.class,0);
		}
		public BlocoContext bloco() {
			return getRuleContext(BlocoContext.class,0);
		}
		public ComandoFor2Context(ComandoContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterComandoFor2(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitComandoFor2(this);
		}
	}
	public static class ComandoFor1Context extends ComandoContext {
		public Token NOME;
		public TerminalNode NOME() { return getToken(LuazinhaParser.NOME, 0); }
		public List<ExpContext> exp() {
			return getRuleContexts(ExpContext.class);
		}
		public ExpContext exp(int i) {
			return getRuleContext(ExpContext.class,i);
		}
		public BlocoContext bloco() {
			return getRuleContext(BlocoContext.class,0);
		}
		public ComandoFor1Context(ComandoContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterComandoFor1(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitComandoFor1(this);
		}
	}

	public final ComandoContext comando() throws RecognitionException {
		ComandoContext _localctx = new ComandoContext(_ctx, getState());
		enterRule(_localctx, 6, RULE_comando);
		int _la;
		try {
			setState(155);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,8,_ctx) ) {
			case 1:
				_localctx = new ComandoAtribuicaoContext(_localctx);
				enterOuterAlt(_localctx, 1);
				{
				setState(69);
				((ComandoAtribuicaoContext)_localctx).listavar = listavar();
				setState(70);
				match(T__1);
				setState(71);
				listaexp();
				for(String nome : ((ComandoAtribuicaoContext)_localctx).listavar.nomes)
				                if(!pilhaDeTabelas.existeSimbolo(nome))
				                  pilhaDeTabelas.topo().adicionarSimbolo(nome, "variavel");
				              
				}
				break;
			case 2:
				_localctx = new ComandoChamadaDeFuncaoContext(_localctx);
				enterOuterAlt(_localctx, 2);
				{
				setState(74);
				chamadadefuncao();
				}
				break;
			case 3:
				_localctx = new ComandoDoContext(_localctx);
				enterOuterAlt(_localctx, 3);
				{
				setState(75);
				match(T__2);
				setState(76);
				bloco();
				setState(77);
				match(T__3);
				}
				break;
			case 4:
				_localctx = new ComandoWhileContext(_localctx);
				enterOuterAlt(_localctx, 4);
				{
				setState(79);
				match(T__4);
				setState(80);
				exp(0);
				setState(81);
				match(T__2);
				setState(82);
				bloco();
				setState(83);
				match(T__3);
				}
				break;
			case 5:
				_localctx = new ComandoRepeatContext(_localctx);
				enterOuterAlt(_localctx, 5);
				{
				setState(85);
				match(T__5);
				setState(86);
				bloco();
				setState(87);
				match(T__6);
				setState(88);
				exp(0);
				}
				break;
			case 6:
				_localctx = new ComandoIfContext(_localctx);
				enterOuterAlt(_localctx, 6);
				{
				setState(90);
				match(T__7);
				setState(91);
				exp(0);
				setState(92);
				match(T__8);
				setState(93);
				bloco();
				setState(101);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while (_la==T__9) {
					{
					{
					setState(94);
					match(T__9);
					setState(95);
					exp(0);
					setState(96);
					match(T__8);
					setState(97);
					bloco();
					}
					}
					setState(103);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(106);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==T__10) {
					{
					setState(104);
					match(T__10);
					setState(105);
					bloco();
					}
				}

				setState(108);
				match(T__3);
				}
				break;
			case 7:
				_localctx = new ComandoFor1Context(_localctx);
				enterOuterAlt(_localctx, 7);
				{
				setState(110);
				match(T__11);
				pilhaDeTabelas.empilhar(new TabelaDeSimbolos("for"));
				setState(112);
				((ComandoFor1Context)_localctx).NOME = match(NOME);
				pilhaDeTabelas.topo().adicionarSimbolo(((ComandoFor1Context)_localctx).NOME.getText(), "variavel");
				setState(114);
				match(T__1);
				setState(115);
				exp(0);
				setState(116);
				match(T__12);
				setState(117);
				exp(0);
				setState(120);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==T__12) {
					{
					setState(118);
					match(T__12);
					setState(119);
					exp(0);
					}
				}

				setState(122);
				match(T__2);
				setState(123);
				bloco();
				pilhaDeTabelas.desempilhar();
				setState(125);
				match(T__3);
				}
				break;
			case 8:
				_localctx = new ComandoFor2Context(_localctx);
				enterOuterAlt(_localctx, 8);
				{
				setState(127);
				match(T__11);
				pilhaDeTabelas.empilhar(new TabelaDeSimbolos("for"));
				setState(129);
				((ComandoFor2Context)_localctx).listadenomes = listadenomes();
				setState(130);
				match(T__13);
				setState(131);
				listaexp();
				for(String nome : ((ComandoFor2Context)_localctx).listadenomes.nomes)
				              pilhaDeTabelas.topo().adicionarSimbolo(nome, "variavel");
				            
				setState(133);
				match(T__2);
				setState(134);
				bloco();
				pilhaDeTabelas.desempilhar();
				setState(136);
				match(T__3);
				}
				break;
			case 9:
				_localctx = new ComandoFunctionContext(_localctx);
				enterOuterAlt(_localctx, 9);
				{
				setState(138);
				match(T__14);
				setState(139);
				((ComandoFunctionContext)_localctx).nomedafuncao = nomedafuncao();

				               pilhaDeTabelas.empilhar(new TabelaDeSimbolos(((ComandoFunctionContext)_localctx).nomedafuncao.nome));
				               if (((ComandoFunctionContext)_localctx).nomedafuncao.metodo) {
				                   pilhaDeTabelas.topo().adicionarSimbolo("self", "parametro");
				               }
				               
				setState(141);
				corpodafuncao();
				pilhaDeTabelas.desempilhar();
				}
				break;
			case 10:
				_localctx = new ComandoLocalFunctionContext(_localctx);
				enterOuterAlt(_localctx, 10);
				{
				setState(144);
				match(T__15);
				setState(145);
				match(T__14);
				setState(146);
				match(NOME);
				setState(147);
				corpodafuncao();
				}
				break;
			case 11:
				_localctx = new ComandoLocalAtribuicaoContext(_localctx);
				enterOuterAlt(_localctx, 11);
				{
				setState(148);
				match(T__15);
				setState(149);
				((ComandoLocalAtribuicaoContext)_localctx).listadenomes = listadenomes();
				for(String nome : ((ComandoLocalAtribuicaoContext)_localctx).listadenomes.nomes)
				                pilhaDeTabelas.topo().adicionarSimbolo(nome, "variavel");
				              
				setState(153);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==T__1) {
					{
					setState(151);
					match(T__1);
					setState(152);
					listaexp();
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
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterUltimocomando(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitUltimocomando(this);
		}
	}

	public final UltimocomandoContext ultimocomando() throws RecognitionException {
		UltimocomandoContext _localctx = new UltimocomandoContext(_ctx, getState());
		enterRule(_localctx, 8, RULE_ultimocomando);
		int _la;
		try {
			setState(162);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__16:
				enterOuterAlt(_localctx, 1);
				{
				setState(157);
				match(T__16);
				setState(159);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__14) | (1L << T__22) | (1L << T__23) | (1L << T__24) | (1L << T__25) | (1L << T__26) | (1L << T__28) | (1L << T__31) | (1L << T__45) | (1L << T__46) | (1L << NOME) | (1L << CADEIA) | (1L << NUMERO))) != 0)) {
					{
					setState(158);
					listaexp();
					}
				}

				}
				break;
			case T__17:
				enterOuterAlt(_localctx, 2);
				{
				setState(161);
				match(T__17);
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
		public String nome;
		public boolean metodo;
		public Token n1;
		public Token n2;
		public Token n3;
		public List<TerminalNode> NOME() { return getTokens(LuazinhaParser.NOME); }
		public TerminalNode NOME(int i) {
			return getToken(LuazinhaParser.NOME, i);
		}
		public NomedafuncaoContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_nomedafuncao; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterNomedafuncao(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitNomedafuncao(this);
		}
	}

	public final NomedafuncaoContext nomedafuncao() throws RecognitionException {
		NomedafuncaoContext _localctx = new NomedafuncaoContext(_ctx, getState());
		enterRule(_localctx, 10, RULE_nomedafuncao);
		 ((NomedafuncaoContext)_localctx).metodo =  false; 
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(164);
			((NomedafuncaoContext)_localctx).n1 = match(NOME);
			 ((NomedafuncaoContext)_localctx).nome =  ((NomedafuncaoContext)_localctx).n1.getText(); 
			setState(171);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==T__18) {
				{
				{
				setState(166);
				match(T__18);
				setState(167);
				((NomedafuncaoContext)_localctx).n2 = match(NOME);
				 _localctx.nome += "." + ((NomedafuncaoContext)_localctx).n2.getText(); 
				}
				}
				setState(173);
				_errHandler.sync(this);
				_la = _input.LA(1);
			}
			setState(177);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__19) {
				{
				setState(174);
				match(T__19);
				setState(175);
				((NomedafuncaoContext)_localctx).n3 = match(NOME);
				 ((NomedafuncaoContext)_localctx).metodo =  true; _localctx.nome += "." + ((NomedafuncaoContext)_localctx).n3.getText(); 
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
		public List<String> nomes;
		public VarContext v1;
		public VarContext v2;
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
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterListavar(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitListavar(this);
		}
	}

	public final ListavarContext listavar() throws RecognitionException {
		ListavarContext _localctx = new ListavarContext(_ctx, getState());
		enterRule(_localctx, 12, RULE_listavar);
		 ((ListavarContext)_localctx).nomes =  new ArrayList<String>(); 
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(179);
			((ListavarContext)_localctx).v1 = var();
			 _localctx.nomes.add(((ListavarContext)_localctx).v1.nome); 
			setState(187);
			_errHandler.sync(this);
			_la = _input.LA(1);
			while (_la==T__12) {
				{
				{
				setState(181);
				match(T__12);
				setState(182);
				((ListavarContext)_localctx).v2 = var();
				 _localctx.nomes.add(((ListavarContext)_localctx).v2.nome); 
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

	public static class VarContext extends ParserRuleContext {
		public String nome;
		public int linha;
		public int coluna;
		public Token NOME;
		public TerminalNode NOME() { return getToken(LuazinhaParser.NOME, 0); }
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
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterVar(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitVar(this);
		}
	}

	public final VarContext var() throws RecognitionException {
		VarContext _localctx = new VarContext(_ctx, getState());
		enterRule(_localctx, 14, RULE_var);
		try {
			setState(201);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,14,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(190);
				((VarContext)_localctx).NOME = match(NOME);
				 ((VarContext)_localctx).nome =  ((VarContext)_localctx).NOME.getText(); ((VarContext)_localctx).linha =  (((VarContext)_localctx).NOME!=null?((VarContext)_localctx).NOME.getLine():0); ((VarContext)_localctx).coluna =  (((VarContext)_localctx).NOME!=null?((VarContext)_localctx).NOME.getCharPositionInLine():0); 
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(192);
				expprefixo();
				setState(193);
				match(T__20);
				setState(194);
				exp(0);
				setState(195);
				match(T__21);
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(197);
				expprefixo();
				setState(198);
				match(T__18);
				setState(199);
				match(NOME);
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

	public static class ListadenomesContext extends ParserRuleContext {
		public List<String> nomes;
		public Token n1;
		public Token n2;
		public List<TerminalNode> NOME() { return getTokens(LuazinhaParser.NOME); }
		public TerminalNode NOME(int i) {
			return getToken(LuazinhaParser.NOME, i);
		}
		public ListadenomesContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_listadenomes; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterListadenomes(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitListadenomes(this);
		}
	}

	public final ListadenomesContext listadenomes() throws RecognitionException {
		ListadenomesContext _localctx = new ListadenomesContext(_ctx, getState());
		enterRule(_localctx, 16, RULE_listadenomes);
		 ((ListadenomesContext)_localctx).nomes =  new ArrayList<String>(); 
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(203);
			((ListadenomesContext)_localctx).n1 = match(NOME);
			 _localctx.nomes.add(((ListadenomesContext)_localctx).n1.getText()); 
			setState(210);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,15,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(205);
					match(T__12);
					setState(206);
					((ListadenomesContext)_localctx).n2 = match(NOME);
					 _localctx.nomes.add(((ListadenomesContext)_localctx).n2.getText()); 
					}
					} 
				}
				setState(212);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,15,_ctx);
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
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterListaexp(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitListaexp(this);
		}
	}

	public final ListaexpContext listaexp() throws RecognitionException {
		ListaexpContext _localctx = new ListaexpContext(_ctx, getState());
		enterRule(_localctx, 18, RULE_listaexp);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(218);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,16,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(213);
					exp(0);
					setState(214);
					match(T__12);
					}
					} 
				}
				setState(220);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,16,_ctx);
			}
			setState(221);
			exp(0);
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
		public TerminalNode NUMERO() { return getToken(LuazinhaParser.NUMERO, 0); }
		public TerminalNode CADEIA() { return getToken(LuazinhaParser.CADEIA, 0); }
		public FuncaoContext funcao() {
			return getRuleContext(FuncaoContext.class,0);
		}
		public Expprefixo2Context expprefixo2() {
			return getRuleContext(Expprefixo2Context.class,0);
		}
		public ConstrutortabelaContext construtortabela() {
			return getRuleContext(ConstrutortabelaContext.class,0);
		}
		public OpunariaContext opunaria() {
			return getRuleContext(OpunariaContext.class,0);
		}
		public List<ExpContext> exp() {
			return getRuleContexts(ExpContext.class);
		}
		public ExpContext exp(int i) {
			return getRuleContext(ExpContext.class,i);
		}
		public OpbinContext opbin() {
			return getRuleContext(OpbinContext.class,0);
		}
		public ExpContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_exp; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterExp(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitExp(this);
		}
	}

	public final ExpContext exp() throws RecognitionException {
		return exp(0);
	}

	private ExpContext exp(int _p) throws RecognitionException {
		ParserRuleContext _parentctx = _ctx;
		int _parentState = getState();
		ExpContext _localctx = new ExpContext(_ctx, _parentState);
		ExpContext _prevctx = _localctx;
		int _startState = 20;
		enterRecursionRule(_localctx, 20, RULE_exp, _p);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(236);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__22:
				{
				setState(224);
				match(T__22);
				}
				break;
			case T__23:
				{
				setState(225);
				match(T__23);
				}
				break;
			case T__24:
				{
				setState(226);
				match(T__24);
				}
				break;
			case NUMERO:
				{
				setState(227);
				match(NUMERO);
				}
				break;
			case CADEIA:
				{
				setState(228);
				match(CADEIA);
				}
				break;
			case T__25:
				{
				setState(229);
				match(T__25);
				}
				break;
			case T__14:
				{
				setState(230);
				funcao();
				}
				break;
			case T__26:
			case NOME:
				{
				setState(231);
				expprefixo2();
				}
				break;
			case T__28:
				{
				setState(232);
				construtortabela();
				}
				break;
			case T__31:
			case T__45:
			case T__46:
				{
				setState(233);
				opunaria();
				setState(234);
				exp(1);
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
			_ctx.stop = _input.LT(-1);
			setState(244);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,18,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					if ( _parseListeners!=null ) triggerExitRuleEvent();
					_prevctx = _localctx;
					{
					{
					_localctx = new ExpContext(_parentctx, _parentState);
					pushNewRecursionContext(_localctx, _startState, RULE_exp);
					setState(238);
					if (!(precpred(_ctx, 2))) throw new FailedPredicateException(this, "precpred(_ctx, 2)");
					setState(239);
					opbin();
					setState(240);
					exp(3);
					}
					} 
				}
				setState(246);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,18,_ctx);
			}
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			unrollRecursionContexts(_parentctx);
		}
		return _localctx;
	}

	public static class ExpprefixoContext extends ParserRuleContext {
		public List<TerminalNode> NOME() { return getTokens(LuazinhaParser.NOME); }
		public TerminalNode NOME(int i) {
			return getToken(LuazinhaParser.NOME, i);
		}
		public List<ExpContext> exp() {
			return getRuleContexts(ExpContext.class);
		}
		public ExpContext exp(int i) {
			return getRuleContext(ExpContext.class,i);
		}
		public ExpprefixoContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_expprefixo; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterExpprefixo(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitExpprefixo(this);
		}
	}

	public final ExpprefixoContext expprefixo() throws RecognitionException {
		ExpprefixoContext _localctx = new ExpprefixoContext(_ctx, getState());
		enterRule(_localctx, 22, RULE_expprefixo);
		try {
			int _alt;
			enterOuterAlt(_localctx, 1);
			{
			setState(247);
			match(NOME);
			setState(256);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,20,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					setState(254);
					_errHandler.sync(this);
					switch (_input.LA(1)) {
					case T__20:
						{
						setState(248);
						match(T__20);
						setState(249);
						exp(0);
						setState(250);
						match(T__21);
						}
						break;
					case T__18:
						{
						setState(252);
						match(T__18);
						setState(253);
						match(NOME);
						}
						break;
					default:
						throw new NoViableAltException(this);
					}
					} 
				}
				setState(258);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,20,_ctx);
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

	public static class Expprefixo2Context extends ParserRuleContext {
		public Expprefixo2Context(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_expprefixo2; }
	 
		public Expprefixo2Context() { }
		public void copyFrom(Expprefixo2Context ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class ExpPrefixo2ChamadaDeFuncaoContext extends Expprefixo2Context {
		public ChamadadefuncaoContext chamadadefuncao() {
			return getRuleContext(ChamadadefuncaoContext.class,0);
		}
		public ExpPrefixo2ChamadaDeFuncaoContext(Expprefixo2Context ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterExpPrefixo2ChamadaDeFuncao(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitExpPrefixo2ChamadaDeFuncao(this);
		}
	}
	public static class ExpPrefixo2ExpContext extends Expprefixo2Context {
		public ExpContext exp() {
			return getRuleContext(ExpContext.class,0);
		}
		public ExpPrefixo2ExpContext(Expprefixo2Context ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterExpPrefixo2Exp(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitExpPrefixo2Exp(this);
		}
	}
	public static class ExpPrefixo2VarContext extends Expprefixo2Context {
		public VarContext var;
		public VarContext var() {
			return getRuleContext(VarContext.class,0);
		}
		public ExpPrefixo2VarContext(Expprefixo2Context ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterExpPrefixo2Var(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitExpPrefixo2Var(this);
		}
	}

	public final Expprefixo2Context expprefixo2() throws RecognitionException {
		Expprefixo2Context _localctx = new Expprefixo2Context(_ctx, getState());
		enterRule(_localctx, 24, RULE_expprefixo2);
		try {
			setState(267);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,21,_ctx) ) {
			case 1:
				_localctx = new ExpPrefixo2VarContext(_localctx);
				enterOuterAlt(_localctx, 1);
				{
				setState(259);
				((ExpPrefixo2VarContext)_localctx).var = var();
				 if(!pilhaDeTabelas.existeSimbolo(((ExpPrefixo2VarContext)_localctx).var.nome))
				                Mensagens.erroVariavelNaoExiste(((ExpPrefixo2VarContext)_localctx).var.linha, ((ExpPrefixo2VarContext)_localctx).var.coluna, ((ExpPrefixo2VarContext)_localctx).var.nome);
				            
				}
				break;
			case 2:
				_localctx = new ExpPrefixo2ChamadaDeFuncaoContext(_localctx);
				enterOuterAlt(_localctx, 2);
				{
				setState(262);
				chamadadefuncao();
				}
				break;
			case 3:
				_localctx = new ExpPrefixo2ExpContext(_localctx);
				enterOuterAlt(_localctx, 3);
				{
				setState(263);
				match(T__26);
				setState(264);
				exp(0);
				setState(265);
				match(T__27);
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

	public static class ChamadadefuncaoContext extends ParserRuleContext {
		public ExpprefixoContext expprefixo() {
			return getRuleContext(ExpprefixoContext.class,0);
		}
		public ArgsContext args() {
			return getRuleContext(ArgsContext.class,0);
		}
		public TerminalNode NOME() { return getToken(LuazinhaParser.NOME, 0); }
		public ChamadadefuncaoContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_chamadadefuncao; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterChamadadefuncao(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitChamadadefuncao(this);
		}
	}

	public final ChamadadefuncaoContext chamadadefuncao() throws RecognitionException {
		ChamadadefuncaoContext _localctx = new ChamadadefuncaoContext(_ctx, getState());
		enterRule(_localctx, 26, RULE_chamadadefuncao);
		try {
			setState(277);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,22,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(269);
				expprefixo();
				setState(270);
				args();
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(272);
				expprefixo();
				setState(273);
				match(T__19);
				setState(274);
				match(NOME);
				setState(275);
				args();
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
		public TerminalNode CADEIA() { return getToken(LuazinhaParser.CADEIA, 0); }
		public ArgsContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_args; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterArgs(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitArgs(this);
		}
	}

	public final ArgsContext args() throws RecognitionException {
		ArgsContext _localctx = new ArgsContext(_ctx, getState());
		enterRule(_localctx, 28, RULE_args);
		int _la;
		try {
			setState(286);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case T__26:
				enterOuterAlt(_localctx, 1);
				{
				setState(279);
				match(T__26);
				setState(281);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__14) | (1L << T__22) | (1L << T__23) | (1L << T__24) | (1L << T__25) | (1L << T__26) | (1L << T__28) | (1L << T__31) | (1L << T__45) | (1L << T__46) | (1L << NOME) | (1L << CADEIA) | (1L << NUMERO))) != 0)) {
					{
					setState(280);
					listaexp();
					}
				}

				setState(283);
				match(T__27);
				}
				break;
			case T__28:
				enterOuterAlt(_localctx, 2);
				{
				setState(284);
				construtortabela();
				}
				break;
			case CADEIA:
				enterOuterAlt(_localctx, 3);
				{
				setState(285);
				match(CADEIA);
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
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterFuncao(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitFuncao(this);
		}
	}

	public final FuncaoContext funcao() throws RecognitionException {
		FuncaoContext _localctx = new FuncaoContext(_ctx, getState());
		enterRule(_localctx, 30, RULE_funcao);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(288);
			match(T__14);
			setState(289);
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
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterCorpodafuncao(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitCorpodafuncao(this);
		}
	}

	public final CorpodafuncaoContext corpodafuncao() throws RecognitionException {
		CorpodafuncaoContext _localctx = new CorpodafuncaoContext(_ctx, getState());
		enterRule(_localctx, 32, RULE_corpodafuncao);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(291);
			match(T__26);
			setState(293);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__25 || _la==NOME) {
				{
				setState(292);
				listapar();
				}
			}

			setState(295);
			match(T__27);
			setState(296);
			bloco();
			setState(297);
			match(T__3);
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
		public ListaparContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_listapar; }
	 
		public ListaparContext() { }
		public void copyFrom(ListaparContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class ListaParVarargsContext extends ListaparContext {
		public ListaParVarargsContext(ListaparContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterListaParVarargs(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitListaParVarargs(this);
		}
	}
	public static class ListaParListaDeNomesContext extends ListaparContext {
		public ListadenomesContext listadenomes;
		public ListadenomesContext listadenomes() {
			return getRuleContext(ListadenomesContext.class,0);
		}
		public ListaParListaDeNomesContext(ListaparContext ctx) { copyFrom(ctx); }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterListaParListaDeNomes(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitListaParListaDeNomes(this);
		}
	}

	public final ListaparContext listapar() throws RecognitionException {
		ListaparContext _localctx = new ListaparContext(_ctx, getState());
		enterRule(_localctx, 34, RULE_listapar);
		int _la;
		try {
			setState(307);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case NOME:
				_localctx = new ListaParListaDeNomesContext(_localctx);
				enterOuterAlt(_localctx, 1);
				{
				setState(299);
				((ListaParListaDeNomesContext)_localctx).listadenomes = listadenomes();
				setState(302);
				_errHandler.sync(this);
				_la = _input.LA(1);
				if (_la==T__12) {
					{
					setState(300);
					match(T__12);
					setState(301);
					match(T__25);
					}
				}

				for(String nome : ((ListaParListaDeNomesContext)_localctx).listadenomes.nomes)
				              pilhaDeTabelas.topo().adicionarSimbolo(nome, "parametro");
				            
				}
				break;
			case T__25:
				_localctx = new ListaParVarargsContext(_localctx);
				enterOuterAlt(_localctx, 2);
				{
				setState(306);
				match(T__25);
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
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterConstrutortabela(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitConstrutortabela(this);
		}
	}

	public final ConstrutortabelaContext construtortabela() throws RecognitionException {
		ConstrutortabelaContext _localctx = new ConstrutortabelaContext(_ctx, getState());
		enterRule(_localctx, 36, RULE_construtortabela);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(309);
			match(T__28);
			setState(311);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__14) | (1L << T__20) | (1L << T__22) | (1L << T__23) | (1L << T__24) | (1L << T__25) | (1L << T__26) | (1L << T__28) | (1L << T__31) | (1L << T__45) | (1L << T__46) | (1L << NOME) | (1L << CADEIA) | (1L << NUMERO))) != 0)) {
				{
				setState(310);
				listadecampos();
				}
			}

			setState(313);
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
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterListadecampos(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitListadecampos(this);
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
			setState(315);
			campo();
			setState(321);
			_errHandler.sync(this);
			_alt = getInterpreter().adaptivePredict(_input,29,_ctx);
			while ( _alt!=2 && _alt!=org.antlr.v4.runtime.atn.ATN.INVALID_ALT_NUMBER ) {
				if ( _alt==1 ) {
					{
					{
					setState(316);
					separadordecampos();
					setState(317);
					campo();
					}
					} 
				}
				setState(323);
				_errHandler.sync(this);
				_alt = getInterpreter().adaptivePredict(_input,29,_ctx);
			}
			setState(325);
			_errHandler.sync(this);
			_la = _input.LA(1);
			if (_la==T__0 || _la==T__12) {
				{
				setState(324);
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
		public TerminalNode NOME() { return getToken(LuazinhaParser.NOME, 0); }
		public CampoContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_campo; }
		@Override
		public void enterRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterCampo(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitCampo(this);
		}
	}

	public final CampoContext campo() throws RecognitionException {
		CampoContext _localctx = new CampoContext(_ctx, getState());
		enterRule(_localctx, 40, RULE_campo);
		try {
			setState(337);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,31,_ctx) ) {
			case 1:
				enterOuterAlt(_localctx, 1);
				{
				setState(327);
				match(T__20);
				setState(328);
				exp(0);
				setState(329);
				match(T__21);
				setState(330);
				match(T__1);
				setState(331);
				exp(0);
				}
				break;
			case 2:
				enterOuterAlt(_localctx, 2);
				{
				setState(333);
				match(NOME);
				setState(334);
				match(T__1);
				setState(335);
				exp(0);
				}
				break;
			case 3:
				enterOuterAlt(_localctx, 3);
				{
				setState(336);
				exp(0);
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
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterSeparadordecampos(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitSeparadordecampos(this);
		}
	}

	public final SeparadordecamposContext separadordecampos() throws RecognitionException {
		SeparadordecamposContext _localctx = new SeparadordecamposContext(_ctx, getState());
		enterRule(_localctx, 42, RULE_separadordecampos);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(339);
			_la = _input.LA(1);
			if ( !(_la==T__0 || _la==T__12) ) {
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
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterOpbin(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitOpbin(this);
		}
	}

	public final OpbinContext opbin() throws RecognitionException {
		OpbinContext _localctx = new OpbinContext(_ctx, getState());
		enterRule(_localctx, 44, RULE_opbin);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(341);
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
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).enterOpunaria(this);
		}
		@Override
		public void exitRule(ParseTreeListener listener) {
			if ( listener instanceof LuazinhaListener ) ((LuazinhaListener)listener).exitOpunaria(this);
		}
	}

	public final OpunariaContext opunaria() throws RecognitionException {
		OpunariaContext _localctx = new OpunariaContext(_ctx, getState());
		enterRule(_localctx, 46, RULE_opunaria);
		int _la;
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(343);
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

	public boolean sempred(RuleContext _localctx, int ruleIndex, int predIndex) {
		switch (ruleIndex) {
		case 10:
			return exp_sempred((ExpContext)_localctx, predIndex);
		}
		return true;
	}
	private boolean exp_sempred(ExpContext _localctx, int predIndex) {
		switch (predIndex) {
		case 0:
			return precpred(_ctx, 2);
		}
		return true;
	}

	public static final String _serializedATN =
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3\66\u015c\4\2\t\2"+
		"\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4\13"+
		"\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22\t\22"+
		"\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31\t\31"+
		"\3\2\3\2\3\2\3\2\3\3\3\3\5\39\n\3\7\3;\n\3\f\3\16\3>\13\3\3\3\3\3\5\3"+
		"B\n\3\5\3D\n\3\3\4\3\4\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5"+
		"\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3"+
		"\5\7\5f\n\5\f\5\16\5i\13\5\3\5\3\5\5\5m\n\5\3\5\3\5\3\5\3\5\3\5\3\5\3"+
		"\5\3\5\3\5\3\5\3\5\3\5\5\5{\n\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3"+
		"\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5\3\5"+
		"\3\5\3\5\3\5\3\5\5\5\u009c\n\5\5\5\u009e\n\5\3\6\3\6\5\6\u00a2\n\6\3\6"+
		"\5\6\u00a5\n\6\3\7\3\7\3\7\3\7\3\7\7\7\u00ac\n\7\f\7\16\7\u00af\13\7\3"+
		"\7\3\7\3\7\5\7\u00b4\n\7\3\b\3\b\3\b\3\b\3\b\3\b\7\b\u00bc\n\b\f\b\16"+
		"\b\u00bf\13\b\3\t\3\t\3\t\3\t\3\t\3\t\3\t\3\t\3\t\3\t\3\t\5\t\u00cc\n"+
		"\t\3\n\3\n\3\n\3\n\3\n\7\n\u00d3\n\n\f\n\16\n\u00d6\13\n\3\13\3\13\3\13"+
		"\7\13\u00db\n\13\f\13\16\13\u00de\13\13\3\13\3\13\3\f\3\f\3\f\3\f\3\f"+
		"\3\f\3\f\3\f\3\f\3\f\3\f\3\f\3\f\5\f\u00ef\n\f\3\f\3\f\3\f\3\f\7\f\u00f5"+
		"\n\f\f\f\16\f\u00f8\13\f\3\r\3\r\3\r\3\r\3\r\3\r\3\r\7\r\u0101\n\r\f\r"+
		"\16\r\u0104\13\r\3\16\3\16\3\16\3\16\3\16\3\16\3\16\3\16\5\16\u010e\n"+
		"\16\3\17\3\17\3\17\3\17\3\17\3\17\3\17\3\17\5\17\u0118\n\17\3\20\3\20"+
		"\5\20\u011c\n\20\3\20\3\20\3\20\5\20\u0121\n\20\3\21\3\21\3\21\3\22\3"+
		"\22\5\22\u0128\n\22\3\22\3\22\3\22\3\22\3\23\3\23\3\23\5\23\u0131\n\23"+
		"\3\23\3\23\3\23\5\23\u0136\n\23\3\24\3\24\5\24\u013a\n\24\3\24\3\24\3"+
		"\25\3\25\3\25\3\25\7\25\u0142\n\25\f\25\16\25\u0145\13\25\3\25\5\25\u0148"+
		"\n\25\3\26\3\26\3\26\3\26\3\26\3\26\3\26\3\26\3\26\3\26\5\26\u0154\n\26"+
		"\3\27\3\27\3\30\3\30\3\31\3\31\3\31\2\3\26\32\2\4\6\b\n\f\16\20\22\24"+
		"\26\30\32\34\36 \"$&(*,.\60\2\5\4\2\3\3\17\17\3\2!/\4\2\"\"\60\61\2\u0178"+
		"\2\62\3\2\2\2\4<\3\2\2\2\6E\3\2\2\2\b\u009d\3\2\2\2\n\u00a4\3\2\2\2\f"+
		"\u00a6\3\2\2\2\16\u00b5\3\2\2\2\20\u00cb\3\2\2\2\22\u00cd\3\2\2\2\24\u00dc"+
		"\3\2\2\2\26\u00ee\3\2\2\2\30\u00f9\3\2\2\2\32\u010d\3\2\2\2\34\u0117\3"+
		"\2\2\2\36\u0120\3\2\2\2 \u0122\3\2\2\2\"\u0125\3\2\2\2$\u0135\3\2\2\2"+
		"&\u0137\3\2\2\2(\u013d\3\2\2\2*\u0153\3\2\2\2,\u0155\3\2\2\2.\u0157\3"+
		"\2\2\2\60\u0159\3\2\2\2\62\63\b\2\1\2\63\64\5\4\3\2\64\65\b\2\1\2\65\3"+
		"\3\2\2\2\668\5\b\5\2\679\7\3\2\28\67\3\2\2\289\3\2\2\29;\3\2\2\2:\66\3"+
		"\2\2\2;>\3\2\2\2<:\3\2\2\2<=\3\2\2\2=C\3\2\2\2><\3\2\2\2?A\5\n\6\2@B\7"+
		"\3\2\2A@\3\2\2\2AB\3\2\2\2BD\3\2\2\2C?\3\2\2\2CD\3\2\2\2D\5\3\2\2\2EF"+
		"\5\4\3\2F\7\3\2\2\2GH\5\16\b\2HI\7\4\2\2IJ\5\24\13\2JK\b\5\1\2K\u009e"+
		"\3\2\2\2L\u009e\5\34\17\2MN\7\5\2\2NO\5\6\4\2OP\7\6\2\2P\u009e\3\2\2\2"+
		"QR\7\7\2\2RS\5\26\f\2ST\7\5\2\2TU\5\6\4\2UV\7\6\2\2V\u009e\3\2\2\2WX\7"+
		"\b\2\2XY\5\6\4\2YZ\7\t\2\2Z[\5\26\f\2[\u009e\3\2\2\2\\]\7\n\2\2]^\5\26"+
		"\f\2^_\7\13\2\2_g\5\6\4\2`a\7\f\2\2ab\5\26\f\2bc\7\13\2\2cd\5\6\4\2df"+
		"\3\2\2\2e`\3\2\2\2fi\3\2\2\2ge\3\2\2\2gh\3\2\2\2hl\3\2\2\2ig\3\2\2\2j"+
		"k\7\r\2\2km\5\6\4\2lj\3\2\2\2lm\3\2\2\2mn\3\2\2\2no\7\6\2\2o\u009e\3\2"+
		"\2\2pq\7\16\2\2qr\b\5\1\2rs\7\62\2\2st\b\5\1\2tu\7\4\2\2uv\5\26\f\2vw"+
		"\7\17\2\2wz\5\26\f\2xy\7\17\2\2y{\5\26\f\2zx\3\2\2\2z{\3\2\2\2{|\3\2\2"+
		"\2|}\7\5\2\2}~\5\6\4\2~\177\b\5\1\2\177\u0080\7\6\2\2\u0080\u009e\3\2"+
		"\2\2\u0081\u0082\7\16\2\2\u0082\u0083\b\5\1\2\u0083\u0084\5\22\n\2\u0084"+
		"\u0085\7\20\2\2\u0085\u0086\5\24\13\2\u0086\u0087\b\5\1\2\u0087\u0088"+
		"\7\5\2\2\u0088\u0089\5\6\4\2\u0089\u008a\b\5\1\2\u008a\u008b\7\6\2\2\u008b"+
		"\u009e\3\2\2\2\u008c\u008d\7\21\2\2\u008d\u008e\5\f\7\2\u008e\u008f\b"+
		"\5\1\2\u008f\u0090\5\"\22\2\u0090\u0091\b\5\1\2\u0091\u009e\3\2\2\2\u0092"+
		"\u0093\7\22\2\2\u0093\u0094\7\21\2\2\u0094\u0095\7\62\2\2\u0095\u009e"+
		"\5\"\22\2\u0096\u0097\7\22\2\2\u0097\u0098\5\22\n\2\u0098\u009b\b\5\1"+
		"\2\u0099\u009a\7\4\2\2\u009a\u009c\5\24\13\2\u009b\u0099\3\2\2\2\u009b"+
		"\u009c\3\2\2\2\u009c\u009e\3\2\2\2\u009dG\3\2\2\2\u009dL\3\2\2\2\u009d"+
		"M\3\2\2\2\u009dQ\3\2\2\2\u009dW\3\2\2\2\u009d\\\3\2\2\2\u009dp\3\2\2\2"+
		"\u009d\u0081\3\2\2\2\u009d\u008c\3\2\2\2\u009d\u0092\3\2\2\2\u009d\u0096"+
		"\3\2\2\2\u009e\t\3\2\2\2\u009f\u00a1\7\23\2\2\u00a0\u00a2\5\24\13\2\u00a1"+
		"\u00a0\3\2\2\2\u00a1\u00a2\3\2\2\2\u00a2\u00a5\3\2\2\2\u00a3\u00a5\7\24"+
		"\2\2\u00a4\u009f\3\2\2\2\u00a4\u00a3\3\2\2\2\u00a5\13\3\2\2\2\u00a6\u00a7"+
		"\7\62\2\2\u00a7\u00ad\b\7\1\2\u00a8\u00a9\7\25\2\2\u00a9\u00aa\7\62\2"+
		"\2\u00aa\u00ac\b\7\1\2\u00ab\u00a8\3\2\2\2\u00ac\u00af\3\2\2\2\u00ad\u00ab"+
		"\3\2\2\2\u00ad\u00ae\3\2\2\2\u00ae\u00b3\3\2\2\2\u00af\u00ad\3\2\2\2\u00b0"+
		"\u00b1\7\26\2\2\u00b1\u00b2\7\62\2\2\u00b2\u00b4\b\7\1\2\u00b3\u00b0\3"+
		"\2\2\2\u00b3\u00b4\3\2\2\2\u00b4\r\3\2\2\2\u00b5\u00b6\5\20\t\2\u00b6"+
		"\u00bd\b\b\1\2\u00b7\u00b8\7\17\2\2\u00b8\u00b9\5\20\t\2\u00b9\u00ba\b"+
		"\b\1\2\u00ba\u00bc\3\2\2\2\u00bb\u00b7\3\2\2\2\u00bc\u00bf\3\2\2\2\u00bd"+
		"\u00bb\3\2\2\2\u00bd\u00be\3\2\2\2\u00be\17\3\2\2\2\u00bf\u00bd\3\2\2"+
		"\2\u00c0\u00c1\7\62\2\2\u00c1\u00cc\b\t\1\2\u00c2\u00c3\5\30\r\2\u00c3"+
		"\u00c4\7\27\2\2\u00c4\u00c5\5\26\f\2\u00c5\u00c6\7\30\2\2\u00c6\u00cc"+
		"\3\2\2\2\u00c7\u00c8\5\30\r\2\u00c8\u00c9\7\25\2\2\u00c9\u00ca\7\62\2"+
		"\2\u00ca\u00cc\3\2\2\2\u00cb\u00c0\3\2\2\2\u00cb\u00c2\3\2\2\2\u00cb\u00c7"+
		"\3\2\2\2\u00cc\21\3\2\2\2\u00cd\u00ce\7\62\2\2\u00ce\u00d4\b\n\1\2\u00cf"+
		"\u00d0\7\17\2\2\u00d0\u00d1\7\62\2\2\u00d1\u00d3\b\n\1\2\u00d2\u00cf\3"+
		"\2\2\2\u00d3\u00d6\3\2\2\2\u00d4\u00d2\3\2\2\2\u00d4\u00d5\3\2\2\2\u00d5"+
		"\23\3\2\2\2\u00d6\u00d4\3\2\2\2\u00d7\u00d8\5\26\f\2\u00d8\u00d9\7\17"+
		"\2\2\u00d9\u00db\3\2\2\2\u00da\u00d7\3\2\2\2\u00db\u00de\3\2\2\2\u00dc"+
		"\u00da\3\2\2\2\u00dc\u00dd\3\2\2\2\u00dd\u00df\3\2\2\2\u00de\u00dc\3\2"+
		"\2\2\u00df\u00e0\5\26\f\2\u00e0\25\3\2\2\2\u00e1\u00e2\b\f\1\2\u00e2\u00ef"+
		"\7\31\2\2\u00e3\u00ef\7\32\2\2\u00e4\u00ef\7\33\2\2\u00e5\u00ef\7\64\2"+
		"\2\u00e6\u00ef\7\63\2\2\u00e7\u00ef\7\34\2\2\u00e8\u00ef\5 \21\2\u00e9"+
		"\u00ef\5\32\16\2\u00ea\u00ef\5&\24\2\u00eb\u00ec\5\60\31\2\u00ec\u00ed"+
		"\5\26\f\3\u00ed\u00ef\3\2\2\2\u00ee\u00e1\3\2\2\2\u00ee\u00e3\3\2\2\2"+
		"\u00ee\u00e4\3\2\2\2\u00ee\u00e5\3\2\2\2\u00ee\u00e6\3\2\2\2\u00ee\u00e7"+
		"\3\2\2\2\u00ee\u00e8\3\2\2\2\u00ee\u00e9\3\2\2\2\u00ee\u00ea\3\2\2\2\u00ee"+
		"\u00eb\3\2\2\2\u00ef\u00f6\3\2\2\2\u00f0\u00f1\f\4\2\2\u00f1\u00f2\5."+
		"\30\2\u00f2\u00f3\5\26\f\5\u00f3\u00f5\3\2\2\2\u00f4\u00f0\3\2\2\2\u00f5"+
		"\u00f8\3\2\2\2\u00f6\u00f4\3\2\2\2\u00f6\u00f7\3\2\2\2\u00f7\27\3\2\2"+
		"\2\u00f8\u00f6\3\2\2\2\u00f9\u0102\7\62\2\2\u00fa\u00fb\7\27\2\2\u00fb"+
		"\u00fc\5\26\f\2\u00fc\u00fd\7\30\2\2\u00fd\u0101\3\2\2\2\u00fe\u00ff\7"+
		"\25\2\2\u00ff\u0101\7\62\2\2\u0100\u00fa\3\2\2\2\u0100\u00fe\3\2\2\2\u0101"+
		"\u0104\3\2\2\2\u0102\u0100\3\2\2\2\u0102\u0103\3\2\2\2\u0103\31\3\2\2"+
		"\2\u0104\u0102\3\2\2\2\u0105\u0106\5\20\t\2\u0106\u0107\b\16\1\2\u0107"+
		"\u010e\3\2\2\2\u0108\u010e\5\34\17\2\u0109\u010a\7\35\2\2\u010a\u010b"+
		"\5\26\f\2\u010b\u010c\7\36\2\2\u010c\u010e\3\2\2\2\u010d\u0105\3\2\2\2"+
		"\u010d\u0108\3\2\2\2\u010d\u0109\3\2\2\2\u010e\33\3\2\2\2\u010f\u0110"+
		"\5\30\r\2\u0110\u0111\5\36\20\2\u0111\u0118\3\2\2\2\u0112\u0113\5\30\r"+
		"\2\u0113\u0114\7\26\2\2\u0114\u0115\7\62\2\2\u0115\u0116\5\36\20\2\u0116"+
		"\u0118\3\2\2\2\u0117\u010f\3\2\2\2\u0117\u0112\3\2\2\2\u0118\35\3\2\2"+
		"\2\u0119\u011b\7\35\2\2\u011a\u011c\5\24\13\2\u011b\u011a\3\2\2\2\u011b"+
		"\u011c\3\2\2\2\u011c\u011d\3\2\2\2\u011d\u0121\7\36\2\2\u011e\u0121\5"+
		"&\24\2\u011f\u0121\7\63\2\2\u0120\u0119\3\2\2\2\u0120\u011e\3\2\2\2\u0120"+
		"\u011f\3\2\2\2\u0121\37\3\2\2\2\u0122\u0123\7\21\2\2\u0123\u0124\5\"\22"+
		"\2\u0124!\3\2\2\2\u0125\u0127\7\35\2\2\u0126\u0128\5$\23\2\u0127\u0126"+
		"\3\2\2\2\u0127\u0128\3\2\2\2\u0128\u0129\3\2\2\2\u0129\u012a\7\36\2\2"+
		"\u012a\u012b\5\6\4\2\u012b\u012c\7\6\2\2\u012c#\3\2\2\2\u012d\u0130\5"+
		"\22\n\2\u012e\u012f\7\17\2\2\u012f\u0131\7\34\2\2\u0130\u012e\3\2\2\2"+
		"\u0130\u0131\3\2\2\2\u0131\u0132\3\2\2\2\u0132\u0133\b\23\1\2\u0133\u0136"+
		"\3\2\2\2\u0134\u0136\7\34\2\2\u0135\u012d\3\2\2\2\u0135\u0134\3\2\2\2"+
		"\u0136%\3\2\2\2\u0137\u0139\7\37\2\2\u0138\u013a\5(\25\2\u0139\u0138\3"+
		"\2\2\2\u0139\u013a\3\2\2\2\u013a\u013b\3\2\2\2\u013b\u013c\7 \2\2\u013c"+
		"\'\3\2\2\2\u013d\u0143\5*\26\2\u013e\u013f\5,\27\2\u013f\u0140\5*\26\2"+
		"\u0140\u0142\3\2\2\2\u0141\u013e\3\2\2\2\u0142\u0145\3\2\2\2\u0143\u0141"+
		"\3\2\2\2\u0143\u0144\3\2\2\2\u0144\u0147\3\2\2\2\u0145\u0143\3\2\2\2\u0146"+
		"\u0148\5,\27\2\u0147\u0146\3\2\2\2\u0147\u0148\3\2\2\2\u0148)\3\2\2\2"+
		"\u0149\u014a\7\27\2\2\u014a\u014b\5\26\f\2\u014b\u014c\7\30\2\2\u014c"+
		"\u014d\7\4\2\2\u014d\u014e\5\26\f\2\u014e\u0154\3\2\2\2\u014f\u0150\7"+
		"\62\2\2\u0150\u0151\7\4\2\2\u0151\u0154\5\26\f\2\u0152\u0154\5\26\f\2"+
		"\u0153\u0149\3\2\2\2\u0153\u014f\3\2\2\2\u0153\u0152\3\2\2\2\u0154+\3"+
		"\2\2\2\u0155\u0156\t\2\2\2\u0156-\3\2\2\2\u0157\u0158\t\3\2\2\u0158/\3"+
		"\2\2\2\u0159\u015a\t\4\2\2\u015a\61\3\2\2\2\"8<ACglz\u009b\u009d\u00a1"+
		"\u00a4\u00ad\u00b3\u00bd\u00cb\u00d4\u00dc\u00ee\u00f6\u0100\u0102\u010d"+
		"\u0117\u011b\u0120\u0127\u0130\u0135\u0139\u0143\u0147\u0153";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}