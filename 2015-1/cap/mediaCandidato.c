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
double mediaCandidato(int i, int opcao, tCandidato candidato[], tCurso curso[])
{
    //declaracao de variavel
    double media;

    //calculo da media
    if (opcao == 1)
    {
        media = (candidato[i].notas.humanas*curso[candidato[i].opcao1.idCurso].pesos.humanas+candidato[i].notas.linguagens*curso[candidato[i].opcao1.idCurso].pesos.linguagens+candidato[i].notas.matematica*curso[candidato[i].opcao1.idCurso].pesos.matematica+candidato[i].notas.natureza*curso[candidato[i].opcao1.idCurso].pesos.natureza+candidato[i].notas.redacao*curso[candidato[i].opcao1.idCurso].pesos.redacao)/(curso[candidato[i].opcao1.idCurso].pesos.redacao+curso[candidato[i].opcao1.idCurso].pesos.natureza+curso[candidato[i].opcao1.idCurso].pesos.matematica+curso[candidato[i].opcao1.idCurso].pesos.linguagens+curso[candidato[i].opcao1.idCurso].pesos.humanas);
    }
    else if (opcao == 2)
    {
        media = (candidato[i].notas.humanas*curso[candidato[i].opcao2.idCurso].pesos.humanas+candidato[i].notas.linguagens*curso[candidato[i].opcao2.idCurso].pesos.linguagens+candidato[i].notas.matematica*curso[candidato[i].opcao2.idCurso].pesos.matematica+candidato[i].notas.natureza*curso[candidato[i].opcao2.idCurso].pesos.natureza+candidato[i].notas.redacao*curso[candidato[i].opcao2.idCurso].pesos.redacao)/(curso[candidato[i].opcao2.idCurso].pesos.redacao+curso[candidato[i].opcao2.idCurso].pesos.natureza+curso[candidato[i].opcao2.idCurso].pesos.matematica+curso[candidato[i].opcao2.idCurso].pesos.linguagens+curso[candidato[i].opcao2.idCurso].pesos.humanas);
    }

    //retorno da media
    return media;
}
