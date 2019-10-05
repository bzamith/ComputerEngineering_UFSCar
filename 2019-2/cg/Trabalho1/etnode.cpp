#include "etnode.h"
#include <math.h>

#include <QDebug>

ETNode::ETNode(QLine aresta)
{
    ymax = calculaYMax(aresta);
    xmin = calculaXMin(aresta);
    minv = calculaMInv(aresta);
    this->next = nullptr;
}

ETNode::ETNode(QLine aresta, ETNode next)
{
    ymax = calculaYMax(aresta);
    xmin = calculaXMin(aresta);
    minv = calculaMInv(aresta);
    this->next = &next;
}

ETNode::ETNode(double xmin, double ymax, double minv)
{
    this->xmin = xmin;
    this->ymax = ymax;
    this->minv = minv;
    this->next = nullptr;
}

double ETNode::calculaMInv(QLine aresta)
{
    double num = aresta.y2()-aresta.y1();
    double den = aresta.x2()-aresta.x1();
    if (num == 0.0)
        return 0.0;
    return den/num;
}

int ETNode::calculaYMax(QLine aresta)
{
    return std::max(aresta.y1(),aresta.y2());
}

int ETNode::calculaXMin(QLine aresta)
{
    if(aresta.y1() < aresta.y2()){
        return aresta.x1();
    }
    return aresta.x2();
}

void ETNode::atualizaXMin()
{
    this->xmin = this->xmin + this->minv;
}

void ETNode::insereUltimo(ETNode* node)
{
    ETNode* atual = this;
    if(this->next == nullptr)
        this->next = node;
    else
    {
        while(atual->next!=nullptr){
            atual = atual->next;
        }
        atual->next = node;
    }
}

void ETNode::insereOrdenado(ETNode* node)
{
    ETNode* atual = this;
    if(this->next == nullptr)
        this->next = node;
    else
    {
        while(atual->next!=nullptr){
            if(atual->next->xmin > node->xmin){
                node->next = atual->next;
                atual->next = node;
                return;
            }
            else
                atual = atual->next;
        }
        atual->next = node;
    }
}

void ETNode::printaNode()
{
    qDebug() << "|" << ymax << "|" << xmin << "|" << minv << " >>> ";
    ETNode* atual = this->next;
    while(atual != nullptr)
    {
        qDebug() << "|" << atual->ymax << "|" << atual->xmin << "|" << atual->minv << " >>> ";
        atual = atual->next;
    }
}
