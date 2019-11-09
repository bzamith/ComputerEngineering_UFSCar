#include "aet.h"
#include <QDebug>
#include<math.h>

AET::AET(QVector<ETNode*> etPreenchida)
{
    this->etPreenchida = etPreenchida;
}

QVector<QLine> AET::getTracos(){
    return tracos;
}

void AET::populaAET()
{
    qDebug() << "*** Printa AET ***";
    //Comeca recebendo o primeiro da AET
    linhasVarredura.append(etPreenchida.at(0));
    etPreenchida.removeFirst();
    printaAET(0);
    calculaRange(0);
    int i = 0;
    while(!(etPreenchida.isEmpty() && linhasVarredura.at(i)==nullptr))
    {
        i++;
        // Copia do nivel anterior
        linhasVarredura.append(linhasVarredura.at(i-1));
        // Checa se nao tem nenhum com y atingido
        removeYAtingidos(i);
        // Atualiza xmin
        atualizaXMins(i);
        // Junta com o da et
        mergeET(i);
        //Calcula range
        calculaRange(i);
    }
}

void AET::printaAET(int level)
{
     if (linhasVarredura.at(level) != nullptr){
       qDebug() << "LV = " << level;
       linhasVarredura.at(level)->printaNode();
    }
}

void AET::calculaRange(int index){
    if(linhasVarredura.at(index)!=nullptr){
        ETNode* atual = linhasVarredura.at(index);
        while(atual != nullptr){
            QPoint p1 = QPoint(ceil(atual->xmin),index);
            QPoint p2 = QPoint(floor(atual->next->xmin),index);
            //qDebug() << "[" << ceil(atual->xmin) << "," << floor(atual->next->xmin) << ")";
            tracos.append(QLine(p1,p2));
            atual = atual->next->next;
        }
    }
}

void AET::removeYAtingidos(int index)
{
   ETNode* atual = linhasVarredura.at(index);
   if(atual==nullptr)
        return;
   while(atual->ymax==index){
       linhasVarredura.replace(index,atual->next);
       atual=atual->next;
       if(atual==nullptr)
           return;
   }
   if(atual!=nullptr)
   {
       while(atual->next!=nullptr)
       {
           if(atual->next->ymax == index)
               atual->next = atual->next->next;
           else
               atual = atual->next;
           if (atual == nullptr)
               return;
       }
   }
}

void AET::atualizaXMins(int index)
{
   ETNode* novo;
   ETNode* atual = linhasVarredura.at(index);
   if(atual==nullptr)
       return;

   atual->atualizaXMin();
   novo = new ETNode(atual->xmin, atual->ymax, atual->minv);
   atual = atual->next;
   linhasVarredura.replace(index,novo);
   while(atual != nullptr)
   {
       atual->atualizaXMin();
       novo = new ETNode(atual->xmin, atual->ymax, atual->minv);
       if(linhasVarredura.at(index)->xmin >= novo->xmin)
       {
           novo->next = linhasVarredura.at(index);
           linhasVarredura.replace(index,novo);
       }
       else{
           linhasVarredura.at(index)->insereOrdenado(novo);
       }
       atual = atual->next;
   }

}

void AET::mergeET(int index)
{
    if(!etPreenchida.isEmpty())
    {
        if(etPreenchida.first()!=nullptr)
        {
            if(linhasVarredura.at(index)==nullptr)
            {
                linhasVarredura.replace(index,etPreenchida.first());
            }
            else
            {
                ETNode* atual = etPreenchida.first();
                while(atual!=nullptr)
                {
                    ETNode* proximo = atual->next;
                    atual->next = nullptr;
                    if(linhasVarredura.at(index)->xmin >= atual->xmin)
                    {
                        atual->next = linhasVarredura.at(index);
                        linhasVarredura.replace(index,atual);
                    }
                    else{
                        linhasVarredura.at(index)->insereOrdenado(atual);
                    }
                    atual = proximo;
                }
            }
            printaAET(index);
        }
        //Remove da ET
        etPreenchida.removeFirst();
    }
}
