#include "et.h"
#include "casosteste.h"

#include <QtDebug>
#include <math.h>

ET::ET(){}

ET::ET(QVector<QLine> arestas)
{
//    casosTeste* teste = new casosTeste();
//    arestas = teste->casoTeste3();
    maxLV = encontraMaxLV(arestas);
    for(int i=0; i<maxLV; i++){
        linhasVarredura.append(nullptr);
    }
    populaET(arestas);
    printaET();
}

QVector<ETNode*> ET::getLVs()
{
    return linhasVarredura;
}

bool ET::verificaHorizontal(QLine aresta)
{
    if(aresta.y1() == aresta.y2())
        return true;
    return false;
}

int ET::calculaLV(QLine aresta)
{
    return std::min(aresta.y1(),aresta.y2());
}

/* Encontra a ultima linha de varredura */
int ET::encontraMaxLV(QVector<QLine> arestas)
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

void ET::populaET(QVector<QLine> arestas)
{
    for(int i=0; i<arestas.size();i++)
    {
        ETNode *atual = new ETNode(arestas.at(i));
        if(!verificaHorizontal(arestas.at(i)))
        {
            int level = calculaLV(arestas.at(i));
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


