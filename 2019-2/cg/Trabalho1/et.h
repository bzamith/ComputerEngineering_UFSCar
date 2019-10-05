#ifndef ET_H
#define ET_H

#include<QVector>
#include<QLine>
#include "etnode.h"

class ET
{
    public:
        ET();
        ET(QVector<QLine> arestas);
        void printaET(); // Printa as LVs da ET
        QVector<ETNode*> getLVs();
    private:
        int maxLV; // Linha de varredura maxima
        int calculaLV(QLine aresta); // Encontra a linha de varredura de uma aresta
        bool verificaHorizontal(QLine aresta); // Verifica se trata-se de uma aresta horizontal
        int encontraMaxLV(QVector<QLine> arestas); // Encontra a linha de varredura maxima
        void populaET(QVector<QLine> arestas); // Preenche a ET (cria os ETNodes e ordena)
        QVector<ETNode*> linhasVarredura;
};

#endif // ET_H
