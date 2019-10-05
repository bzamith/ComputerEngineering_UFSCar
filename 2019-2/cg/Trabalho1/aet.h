#ifndef AET_H
#define AET_H

#include "et.h"

class AET
{
public:
    AET();
    AET(QVector<ETNode*> etPreenchida);
    QVector<ETNode*> niveis;
    QVector<ETNode*> etPreenchida;
    QVector<QLine> tracos;
    void populaAET();
    void printaAET(int level);
    void calculaRange(int index);
    QVector<QLine> getLVs();
    void removeYAtingidos(int index);
    void atualizaXMins(int index);
    void mergeET(int i);
};

#endif // AET_H
