///Define as constantes
#define TAM_NOME 100
#define MAX_CURSOS 100
#define MAX_CANDIDATOS 5000
#define MAX_MATCH 10000
#define N_GRUPOS 5

///Arquivos
#define CURSOS_FILE "cursos.txt"
#define CANDIDATOS_FILE "candidatos.txt"
#define OUTPUT_TODOS_FILE "aprovados_todos.csv"
#define OUTPUT_CURSO_FILE "aprovados_por_curso.csv"
#define OUTPUT_CURSO_GRUPOS_FILE "aprovados_por_curso_grupos.csv"

///Estutura de Dados///
// tNotas: referente as notas de cada candidato
// USADA EM tCandidato
typedef struct {
    double redacao;     // Referente a nota do candidato na prova de redação
    double linguagens;  // Referente a nota do candidato na prova de Linguagens, Códigos e suas tecnologias
    double matematica;  // Referente a nota do candidato na prova de Matemática e suas tecnologias
    double natureza;    // Referente a nota do candidato na prova de Ciências da Natureza e suas tecnologias
    double humanas;     // Referente a nota do candidato na prova de Ciências Humanas e suas tecnologias
} tNotas;

// tCurso: referente a cada curso
typedef struct {
    char nome[TAM_NOME];      // Nome do curso
    int vagas[N_GRUPOS+1];             // Total de vagas disponibilizadas
    tNotas pesos;             // Armazena os pesos de cada prova
} tCurso;

// tInscricao: referente a inscrição de cada candidato
typedef struct {
    int idCurso;         // Armazena o ID do curso que o candidato colocou na opção - -1 significa que nao quer usar a opçao (somente valido para 2 opcao)
    int grupo;           // Referente ao grupo que o candidato se inscreveu
    double media;      // Nota média
} tInscricao;

// tCandidato: referente a cada candidato
typedef struct {
    char nome[TAM_NOME];    // Nome do candidato
    tNotas notas;           // Referente as notas das provas do candidato
    tInscricao opcao1;
    tInscricao opcao2;
    int classificado; //-2 = classificado na 1 opcao | -1 = Nao classificado | numeros positivos = id do curso classificado na 2 opcao
} tCandidato;

// tMatch
typedef struct {
    int idCandidato; //id candidato
    int idCurso; //id do curso
    double media;
    int opcao; //1 opcao ou 2 opcao
    int grupo; //cota
    int classificado; //0 ou 1
} tMatch;

typedef int (*compfn)(const void*, const void*);
