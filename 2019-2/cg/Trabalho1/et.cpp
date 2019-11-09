#include "et.h"
#include "casosteste.h"

#include <QtDebug>
#include <math.h>

ET::ET(QVector<QLine> arestas)
{
//    casosTeste* teste = new casosTeste();
//    arestas = teste->casoTeste3();
    this->arestas = arestas;
    maxLV = encontraMaxLV();
    for(int i=0; i<maxLV; i++){
        linhasVarredura.append(nullptr);
    }

}

QVector<ETNode*> ET::getLVs()
{
    return linhasVarredura;
}

bool ET::verificaHorizontal(int index)
{
    if(arestas.at(index).y1() == arestas.at(index).y2())
        return true;
    return false;
}

int ET::calculaLV(int index)
{
    return std::min(arestas.at(index).y1(),arestas.at(index).y2());
}

/* Encontra a ultima linha de varredura */
int ET::encontraMaxLV()
{
    int maxLV = 0;
    for(int i=0; i<arestas.size();i++){
        if(arestas.at(i).y1()>maxLV)
            maxLV = arestas.at(i).y1();
        if(arestas.at(i).y2()>maxLV)
            maxLV = arestas.at(i).y2();
    }
    return maxLV;
}

void ET::populaET()
{
    for(int i=0; i<arestas.size();i++)
    {
        if(!verificaHorizontal(i))
        {
            ETNode *atual = new ETNode(arestas.at(i));
            int level = calculaLV(i);
            if(linhasVarredura.at(level)==nullptr)
            {
                linhasVarredura.replace(level,atual);
            }
            else
            {
                if(linhasVarredura.at(level)->xmin >= atual->xmin)
                {
                    atual->next = linhasVarredura.at(level);
                    linhasVarredura.replace(level,atual);
                }
                else{
                    linhasVarredura.at(level)->insereOrdenado(atual);
                }
            }
        }
    }
    printaET();
}

void ET::printaET()
{
    qDebug() << "*** Printa ET ***";
    for(int i=0; i<maxLV; i++)
    {
        if (linhasVarredura.at(i) != nullptr){
            qDebug() << "LV = " << i;
            linhasVarredura.at(i)->printaNode();
        }
    }
}


