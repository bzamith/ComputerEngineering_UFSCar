///Protótipos das Funções
/*
   Nome da função: lerCursos
   Objetivos: Leitura do arquvio CURSOS_FILE, com os dados do curso
   Parâmetros Formais:
       -curso[]: Vetor de tCurso (Entrada e saída de dados)
   Retorno: Número de cursos lidos (int nCursos)
*/
int lerCursos(tCurso curso[]);

/*
   Nome da função: mediaCandidato
   Objetivos: Calcular a media dos candidatos
   Parâmetros Formais:
       - i: ID do candidato (Entrada de dados)
       -opcao: Opção de curso escolhida (Entrada de dados)
       -candidato[]: Vetor de tCandidato (Entrada e saída de dados)
       -curso[]: Vetor de tCurso (Entrada e saída de dados)
   Retorno: Média das notas do candidato (double media)
*/
double mediaCandidato(int i, int opcao, tCandidato candidato[], tCurso curso[]);

/*
   Nome da função: lerCandidatos
   Objetivos: Ler dados dos candidatos do arquivo
   Parâmetros Formais:
       -candidato[]: Vetor de tCandidato (Entrada e saída de dados)
       -curso[]: Vetor de tCurso (Entrada e saída de dados)
   Retorno: Número de candidatos lidos (int nCandidatos)
*/
int lerCandidatos(tCandidato candidato[],tCurso curso[]);


/*
   Nome da função: inicializaLista
   Objetivos: Inicializar o vetor match[] e preencher com os dados dos candidatos
   Parâmetros Formais:
       -match[] (tMatch): Vetor de escolha de cursos (Entrada e saída de dados)
       -nSelecionados[MAX_CURSOS][N_GRUPOS] (int): matriz contendo a quantidade de candidatos já alocados para cada curso e grupo (Entrada e saída de dados)
       -candidato[] (tCandidato): Vetor de candidatos (Entrada e saída de dados)
       -nCandidatos (int): Quantidade de candidatos cadastrados (Entrada de dados)
       -nCursos (int): Quantidade de cursos cadastrados (Entrada de dados)
   Retorno: Quantidade de escolhas de curso em match[] (int j)
*/
int inicializaLista(tMatch match[], int nSelecionados[MAX_CURSOS][N_GRUPOS],tCandidato candidato[],int nCandidatos,int nCursos);

/*
   Nome da função: compare
   Objetivos: Implementar o quickSort entre candidatos
   Parâmetros Formais:
       - elem1: Primeiro aluno (Entrada de dados)
       - elem2: Segundo aluno (Entrada de dados)
   Retorno: 1 se a nota de elem1 for maior, -1 se for menor ou 0 se forem iguais
*/
int compare(tMatch *elem1, tMatch *elem2);

/*
   Nome da função: ordenaLista
   Objetivos: Ordenar a lista de escolhas de curso de acordo com a media
   Parâmetros Formais:
       -match[]: Vetor de escolha de cursos (Entrada e saída de dados)
       -nMatch: Número de candidatos na lista (Entrada de dados)
   Retorno: Nenhum (procedimento)
*/
void ordenaLista(tMatch match[],int nMatch);

/*
   Nome da função: fazMatch
   Objetivos: Faz o match de cada candidato para o curso escolhido
   Parametros Formais:
       -match[] (tMatch): Vetor de escolha de cursos ordenado pela nota (Entrada e saída de dados)
       -nSelecionados[MAX_CURSOS][N_GRUPOS] (int): matriz contendo a quantidade de candidatos já alocados para cada curso e grupo (Entrada e saída de dados)
       -candidato[] (tCandidato): Vetor de candidatos (Entrada e saída de dados)
       -curso[] (tCurso): Vetor de cursos (Entrada e saída de dados)
       -nMatch (int): Quantidade de escolhas de curso em match[] (Entrada de dados)
   Retorno: Nenhum (procedimento)
*/
void fazMatch(tMatch match[],int nSelecionados[MAX_CURSOS][N_GRUPOS],tCandidato candidato[],tCurso curso[],int nMatch);

/*
   Nome da função: trocaEscolha
   Objetivos: Função chamada na fazMatch quando um candidato que ja havia
   passado em sua 2º opção, passa na 1º opção, a fim de reoferecer a vaga.
   Parametros Formais:
        -id: ID do candidato(int) (Entrada de dados)
        -pos: posição atual do contador de laço na função anterior(determina até que ponto a busca para o reoferecimento da vaga deve ocorrer)(int) (Entrada de dados)
        -match[]: Vetor contendo os aprovados (Entrada e saída de dados)
        -nSelecionados[MAX_CURSOS][N_GRUPOS] (int): matriz contendo a quantidade de candidatos já alocados para cada curso e grupo (Entrada e saída de dados)
        -candidato[]: vetor de candidatos (Entrada e saída de dados)
        -curso[]: vetor de cursos (Entrada e saída de dados)
   Retorno: Nenhum (procedimento)
*/
void trocaEscolha(int id, int pos,tMatch match[],int nSelecionados[MAX_CURSOS][N_GRUPOS],tCandidato candidato[],tCurso curso[]);

/*
   Nome da função: aprovadosTodos
   Objetivos: Imprimir todos os aprovados
   Parâmetros Formais:
       -match[]: Vetor com os aprovados (Entrada de dados)
       -candidato[]: Vetor com os dados dos candidatos (Entrada de dados)
       -curso[]: Vetor com os dados dos cursos (Entrada de dados)
       -nMatch: Número de aprovados (Entrada de dados)
   Retorno: Nenhum (procedimento)
*/
void aprovadosTodos(tMatch match[],int nMatch,tCandidato candidato[],tCurso curso[]);

/*
   Nome da função: aprovadosCurso
   Objetivos: Imprimir os aprovados separados por cursos
   Parâmetros Formais:
       -match[]: Vetor com os aprovados (Entrada de dados)
       -candidato[]: Vetor com os dados dos candidatos (Entrada de dados)
       -curso[]: Vetor com os dados dos cursos (Entrada de dados)
       -nMatch: Número de aprovados (Entrada de dados)
   Retorno: Nenhum (procedimento)
*/
void aprovadosCurso(tMatch match[],int nMatch,tCandidato candidato[],tCurso curso[],int nCursos);

/*
   Nome da função: aprovadosGrupo
   Objetivos: Imprimir os aprovados separados por grupos
   Parâmetros Formais:
       -match[]: Vetor com os aprovados (Entrada de dados)
       -candidato[]: Vetor com os dados dos candidatos (Entrada de dados)
       -curso[]: Vetor com os dados dos cursos (Entrada de dados)
       -nMatch: Número de aprovados (Entrada de dados)
   Retorno: Nenhum (procedimento)
*/
void aprovadosGrupo(tMatch match[],int nMatch,tCandidato candidato[],tCurso curso[],int nCursos);

/*
   Nome da função: procuraCandidatos
   Objetivos: imprime os resultados de um candidato especifico
   Parâmetros Formais:
       -candidato[]: Vetor com os dados dos candidatos (Entrada de dados)
       -nCandidatos: Int com a quantidade de candidatos (Entrada de dados)
       -curso[]: Vetor com os dados dos cursos (Entrada de dados)
   Retorno: Nenhum (procedimento)
*/
void procuraCandidatos(tCandidato candidato[],int nCandidatos,tCurso curso[]);

/*
   Nome da função: procuraCurso
   Objetivos: imprime os resultados de um curso especifico
   Parâmetros Formais:
       -match[]: Vetor com os aprovados (Entrada de dados)
       -candidato[]: Vetor com os dados dos candidatos (Entrada de dados)
       -curso[]: Vetor com os dados dos cursos (Entrada de dados)
       -nMatch: Número de aprovados (Entrada de dados)
       -nCursos (int): Quantidade de cursos cadastrados (Entrada de dados)
   Retorno: Nenhum (procedimento)
*/
void procuraCurso(tMatch match[],int nMatch,tCandidato candidato[],tCurso curso[],int nCursos);


/*
   Nome da função: menuResultados
   Objetivos: Imprimir resultados obtidos com o match
   Parâmetros Formais:
       -match[]: Vetor com os aprovados (Entrada de dados)
       -nMatch: Número de aprovados (Entrada de dados)
       -candidato[]: Vetor com os dados dos candidatos (Entrada de dados)
       -nCandidatos: Int com a quantidade de candidatos (Entrada de dados)
       -curso[]: Vetor com os dados dos cursos (Entrada de dados)
       -nCursos (int): Quantidade de cursos cadastrados (Entrada de dados)
   Retorno: Nenhum (procedimento)
*/
void menuResultados(tMatch match[],int nMatch,tCandidato candidato[], int nCandidatos, tCurso curso[],int nCursos);
