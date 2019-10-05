#ifndef ETNODE_H
#define ETNODE_H

#include <QLine>

class ETNode
{
    public:
        ETNode(QLine aresta);
        ETNode(QLine aresta, ETNode next);
        ETNode(double xmin, double ymax, double minv);
        // Atributos da classe ETNode
        double ymax, xmin, minv;
        ETNode *next;
        void insereOrdenado(ETNode* node); // Insere uma ETNode no next mas de maneira ordenada (linked list)
        void insereUltimo(ETNode* node); // Insere uma ETNode no fim, transverse
        void printaNode();
        void atualizaXMin(); // Método que soma o xmin com o minv
    private:
        double calculaMInv(QLine aresta);
        int calculaYMax(QLine aresta);
        int calculaXMin(QLine aresta);

};

#endif // ETNODE_H
