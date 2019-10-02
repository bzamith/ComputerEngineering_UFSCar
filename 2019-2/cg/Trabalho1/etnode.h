#ifndef ETNODE_H
#define ETNODE_H

#include <QLine>

class ETNode
{
    public:
        ETNode();
        ETNode(QLine aresta);
        ETNode(QLine aresta, ETNode *next);
        void setNext(ETNode *next);
    private:
        int ymax, xmin;
        double minv;
        ETNode *next;
        double calculaMInv(QLine aresta);
        int calculaYMax(QLine aresta);
        int calculaXMin(QLine aresta);
        void atualizaXMin();
};

#endif // ETNODE_H
