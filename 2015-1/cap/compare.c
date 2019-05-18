/*
   Nome da função: compare
   Objetivos: Implementar o quickSort entre candidatos
   Parâmetros Formais:
       - elem1: Primeiro aluno (Entrada de dados)
       - elem2: Segundo aluno (Entrada de dados)
   Retorno: 1 se a nota de elem1 for maior, -1 se for menor ou 0 se forem iguais
*/
int compare(tMatch *elem1, tMatch *elem2)
{
   if ( elem1->media < elem2->media)
      return 1;

   else if (elem1->media > elem2->media)
      return -1;

   else
      return 0;
}
