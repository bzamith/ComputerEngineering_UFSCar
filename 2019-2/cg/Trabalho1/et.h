#ifndef ET_H
#define ET_H

#include<QVector>
#include<QLine>
#include "etnode.h"

class ET
{
    public:
        ET(QVector<QLine> arestas);
        QVector<ETNode*> getLVs();
        void printaET(); // Printa as LVs da ET
        void populaET(); // Preenche a ET (cria os ETNodes e ordena)
    private:
        int maxLV; // Linha de varredura maxima
        QVector<QLine> arestas;
        QVector<ETNode*> linhasVarredura;
        int calculaLV(int index); // Encontra a linha de varredura de uma aresta
        int encontraMaxLV(); // Encontra a linha de varredura maxima
        bool verificaHorizontal(int index); // Verifica se trata-se de uma aresta horizontal
};

#endif // ET_H
