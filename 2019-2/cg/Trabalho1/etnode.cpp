#include "etnode.h"
#include<math.h>

ETNode::ETNode(){}
ETNode::ETNode(QLine aresta)
{
    this->ymax = calculaYMax(aresta);
    this->xmin = calculaXMin(aresta);
    this->minv = calculaMInv(aresta);
    this->next = nullptr;
}

ETNode::ETNode(QLine aresta, ETNode *next)
{
    this->ymax = calculaYMax(aresta);
    this->xmin = calculaXMin(aresta);
    this->minv = calculaMInv(aresta);
    this->next = next;
}

void ETNode::setNext(ETNode *next)
{
    this->next = next;
}

int ETNode::calculaYMax(QLine aresta)
{
    return floor(std::max(aresta.y1(),aresta.y2()));
}

int ETNode::calculaXMin(QLine aresta)
{
    if(aresta.y1() < aresta.y2())
    {
        return ceil(aresta.x1());
    }
    return ceil(aresta.x2());
}

double ETNode::calculaMInv(QLine aresta)
{
    double num = aresta.y2() - aresta.y1();
    double den = aresta.x2() - aresta.x1();
    return num/den;

}

void ETNode::atualizaXMin()
{
    this->xmin = ceil(this->xmin * this->minv);
}
