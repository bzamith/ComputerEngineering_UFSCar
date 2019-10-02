#ifndef ET_H
#define ET_H

#include<QVector>
#include<QLine>

class ET
{
    public:
        ET();
        ET(QVector<QLine> arestas);
    private:
        int linhasVarredura(QVector<QLine> arestas);
};

#endif // ET_H
