#include "aet.h"
#include <QDebug>
#include<math.h>

AET::AET() {}

AET::AET(QVector<ETNode*> etPreenchida)
{
    this->etPreenchida = etPreenchida;
    populaAET();
}

QVector<QLine> AET::getLVs(){
    return tracos;
}

void AET::populaAET()
{
    //Comeca recebendo o primeiro da AET
    niveis.append(etPreenchida.at(0));
    etPreenchida.removeFirst();
    printaAET(0);
    calculaRange(0);
    int i = 0;
    while(!(etPreenchida.isEmpty() && niveis.at(i)==nullptr))
    {
        i++;
        // Copia do nivel anterior
        niveis.append(niveis.at(i-1));
        // Checa se nao tem nenhum com y atingido
        removeYAtingidos(i);
        // Atualiza xmin
        atualizaXMins(i);
        // Junta com o da et
        mergeET(i);
        //Calcula range
        printaAET(i);
        calculaRange(i);
    }
}

void AET::printaAET(int level)
{
    qDebug() << "*** Printa AET ***";
    if (niveis.at(level) != nullptr){
       qDebug() << "LV = " << level;
       niveis.at(level)->printaNode();
    }
}

void AET::calculaRange(int index){
    if(niveis.at(index)!=nullptr){
        ETNode* atual = niveis.at(index);
        while(atual != nullptr){
            QPoint p1 = QPoint(ceil(atual->xmin),index);
            QPoint p2 = QPoint(floor(atual->next->xmin),index);
            qDebug() << "[" << ceil(atual->xmin) << "," << floor(atual->next->xmin) << ")";
            tracos.append(QLine(p1,p2));
            atual = atual->next->next;
        }
    }
}

void AET::removeYAtingidos(int index)
{
   ETNode* atual = niveis.at(index);
   if(atual==nullptr)
        return;
   while(atual->ymax==index){
       niveis.replace(index,atual->next);
       atual=atual->next;
       if(atual==nullptr)
           return;
   }
   if(atual!=nullptr)
   {
       while(atual->next!=nullptr)
       {
           if(atual->next->ymax == index){
               atual->next = atual->next->next;
           }
           atual = atual->next;
           if (atual == nullptr)
               return;
       }
   }
}

void AET::atualizaXMins(int index)
{
   ETNode* atual = niveis.at(index);
   if(atual==nullptr)
       return;
   while(atual != nullptr)
   {
       atual->atualizaXMin();
       atual = atual->next;
   }
}

void AET::mergeET(int i)
{
    if(!etPreenchida.isEmpty())
    {
        if(etPreenchida.first()!=nullptr)
        {
            if(niveis.at(i)==nullptr)
            {
                niveis.insert(i,etPreenchida.first());
            }
            else
            {
                ETNode* atual = etPreenchida.first();
                while(atual!=nullptr)
                {
                    ETNode* proximo = atual->next;
                    atual->next = nullptr;
                    if(niveis.at(i)->xmin >= atual->xmin)
                    {
                        atual->next = niveis.at(i);
                        niveis.replace(i,atual);
                    }
                    else{
                        niveis.at(i)->insereOrdenado(atual);
                    }
                    atual = proximo;
                }
            }
        }
        //Remove da ET
        etPreenchida.removeFirst();
    }
}
