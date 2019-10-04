#include "et.h"

#include <QtDebug>
#include <math.h>

ET::ET(){}

ET::ET(QVector<QLine> arestas)
{
    //arestas = casoTeste3();
    maxLV = encontraMaxLV(arestas);
    for(int i=0; i<maxLV; i++){
        linhasVarredura.append(nullptr);
    }
    populaET(arestas);
    printaET();
}

bool ET::verificaHorizontal(QLine aresta)
{
    if(aresta.y1() == aresta.y2())
        return true;
    return false;
}

int ET::calculaLV(QLine aresta)
{
    return ceil(std::min(aresta.y1(),aresta.y2()));
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
                linhasVarredura.insert(level,atual);
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

QVector<QLine> ET::casoTeste1()
{
    QPoint pontoA = QPoint(0,0);
    QPoint pontoB = QPoint(3,4);
    QPoint pontoC = QPoint(7,4);
    QPoint pontoD = QPoint(5,2);
    QPoint pontoE = QPoint(7,0);

    QLine linhaAB = QLine(pontoA,pontoB);
    QLine linhaBC = QLine(pontoB,pontoC);
    QLine linhaCD = QLine(pontoC,pontoD);
    QLine linhaDE = QLine(pontoD,pontoE);
    QLine linhaAE = QLine(pontoA,pontoE);

    QVector<QLine> arestasTeste;
    arestasTeste.append(linhaDE);
    arestasTeste.append(linhaBC);
    arestasTeste.append(linhaCD);
    arestasTeste.append(linhaAB);
    arestasTeste.append(linhaAE);

    return arestasTeste;
}

QVector<QLine> ET::casoTeste2()
{
    QPoint pontoA = QPoint(0,0);
    QPoint pontoB = QPoint(1,6);
    QPoint pontoC = QPoint(7,0);
    QPoint pontoD = QPoint(8,6);

    QLine linhaAB = QLine(pontoA,pontoB);
    QLine linhaBC = QLine(pontoB,pontoC);
    QLine linhaCD = QLine(pontoC,pontoD);
    QLine linhaAD = QLine(pontoA,pontoD);

    QVector<QLine> arestasTeste;
    arestasTeste.append(linhaAB);
    arestasTeste.append(linhaBC);
    arestasTeste.append(linhaCD);
    arestasTeste.append(linhaAD);

    return arestasTeste;
}

QVector<QLine> ET::casoTeste3()
{
    QPoint pontoA = QPoint(0,0);
    QPoint pontoB = QPoint(3,4);
    QPoint pontoC = QPoint(7,4);
    QPoint pontoD = QPoint(5,2);
    QPoint pontoE = QPoint(7,0);

    QLine linhaAB = QLine(pontoA,pontoB);
    QLine linhaBC = QLine(pontoB,pontoC);
    QLine linhaCD = QLine(pontoC,pontoD);
    QLine linhaDE = QLine(pontoD,pontoE);
    QLine linhaAE = QLine(pontoA,pontoE);
    QLine linhaAD = QLine(pontoA,pontoD);
    QLine linhaAC = QLine(pontoA,pontoC);

    QVector<QLine> arestasTeste;
    arestasTeste.append(linhaDE);
    arestasTeste.append(linhaBC);
    arestasTeste.append(linhaAD);
    arestasTeste.append(linhaCD);
    arestasTeste.append(linhaAC);
    arestasTeste.append(linhaAB);
    arestasTeste.append(linhaAE);

    return arestasTeste;
}

