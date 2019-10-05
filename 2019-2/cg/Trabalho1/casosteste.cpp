#include "casosteste.h"

casosTeste::casosTeste(){}

QVector<QLine> casosTeste::casoTeste1()
{
    QPoint pontoA = QPoint(0,0);
    QPoint pontoB = QPoint(300,400);
    QPoint pontoC = QPoint(700,400);
    QPoint pontoD = QPoint(500,200);
    QPoint pontoE = QPoint(700,0);

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

QVector<QLine> casosTeste::casoTeste2()
{
    QPoint pontoA = QPoint(0,0);
    QPoint pontoB = QPoint(100,600);
    QPoint pontoC = QPoint(700,0);
    QPoint pontoD = QPoint(800,600);

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

QVector<QLine> casosTeste::casoTeste3()
{
    QPoint pontoA = QPoint(200,0);
    QPoint pontoB = QPoint(300,0);
    QPoint pontoC = QPoint(300,200);
    QPoint pontoD = QPoint(400,200);
    QPoint pontoE = QPoint(500,300);
    QPoint pontoF = QPoint(350,400);
    QPoint pontoG = QPoint(250,400);
    QPoint pontoH = QPoint(250,350);
    QPoint pontoI = QPoint(0,350);
    QPoint pontoJ = QPoint(0,150);

    QLine linhaAB = QLine(pontoA,pontoB);
    QLine linhaBC = QLine(pontoB,pontoC);
    QLine linhaCD = QLine(pontoC,pontoD);
    QLine linhaDE = QLine(pontoD,pontoE);
    QLine linhaEF = QLine(pontoE,pontoF);
    QLine linhaFG = QLine(pontoF,pontoG);
    QLine linhaGH = QLine(pontoG,pontoH);
    QLine linhaHI = QLine(pontoH,pontoI);
    QLine linhaIJ = QLine(pontoI,pontoJ);
    QLine linhaAJ = QLine(pontoA,pontoJ);

    QVector<QLine> arestasTeste;
    arestasTeste.append(linhaAB);
    arestasTeste.append(linhaBC);
    arestasTeste.append(linhaCD);
    arestasTeste.append(linhaDE);
    arestasTeste.append(linhaEF);
    arestasTeste.append(linhaFG);
    arestasTeste.append(linhaGH);
    arestasTeste.append(linhaHI);
    arestasTeste.append(linhaIJ);
    arestasTeste.append(linhaAJ);

    return arestasTeste;
}
