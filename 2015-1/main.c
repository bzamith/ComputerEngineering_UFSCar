/*
Projeto SISU
Autores: Alunos de CAP 2015-S1 025070-B
Professor: Ricardo Rodrigues Ciferri
Data: 01/07/2015
*/

///Includes da bibliotecas
#include <stdio.h>
#include <string.h>

///Includes das estruturas e funções
#include "estruturaDados.c"
#include "prototiposFuncoes.c"
#include "lerCurso.c"
#include "mediaCandidato.c"
#include "lerCandidato.c"
#include "inicializaLista.c"
#include "compare.c"
#include "ordenaLista.c"
#include "fazMatch.c"
#include "trocaEscolha.c"
#include "aprovadosCurso.c"
#include "aprovadosGrupo.c"
#include "aprovadosTodos.c"
#include "procuraCandidatos.c"
#include "procuraCurso.c"
#include "menuResultados.c"

///Função Principal
int main()
{
    //declaração e inicialização de variaveis
    int nCursos; //quantidade de cursos
    int nCandidatos; //quantidade de candidatos
    int nMatch; //quantidade de escolhas no vetor match
    int nSelecionados[MAX_CURSOS][5]={0}; //quantidade de candidatos ja elecionados pra cada curso e grupo

    //vetores
    tCurso curso[MAX_CURSOS]; //vetor de cursos
    tCandidato candidato[MAX_CANDIDATOS]; //vetor de candidatos
    tMatch match[MAX_MATCH]; //vetor de classificação dos candidatos - GERAL

    //cor
    system("color 2F");

    /**INFORMACOES**/
    printf("PROJETO SISU\n\nInicializacao:\n\n");
    /**PROCESSO DE LEITURA DE DADOS DO ARQUIVO**/
    nCursos=lerCursos(curso);
    nCandidatos=lerCandidatos(candidato,curso);
    /**ORGANIZAÇÂO DE DADOS**/
    nMatch = inicializaLista(match,nSelecionados,candidato,nCandidatos,nCursos);
    ordenaLista(match,nMatch);
    /**MATCH**/
    fazMatch(match,nSelecionados,candidato,curso,nMatch);
    /**PAUSE E LIMPEZA DA TELA**/
    printf("\n\n");
    system("pause");
    system("cls");
    /**OUTPUT DOS RESULTADOS**/
    menuResultados(match, nMatch, candidato, nCandidatos, curso,nCursos);

    //encerra o programa
    return 0;
}

