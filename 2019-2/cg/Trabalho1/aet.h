#ifndef AET_H
#define AET_H

#include "et.h"

class AET
{
    public:
        AET(QVector<ETNode*> etPreenchida);
        QVector<QLine> getTracos();
        void printaAET(int level);
        void populaAET();
    private:
        QVector<ETNode*> linhasVarredura;
        QVector<ETNode*> etPreenchida;
        QVector<QLine> tracos;
        void calculaRange(int index);
        void removeYAtingidos(int index);
        void atualizaXMins(int index);
        void mergeET(int index);
};

#endif // AET_H
