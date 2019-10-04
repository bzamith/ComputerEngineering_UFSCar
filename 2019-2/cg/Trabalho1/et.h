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
    private:
        QVector<ETNode*> linhasVarredura;
        int maxLV; // Linha de varredura maxima
        int calculaLV(QLine aresta); // Encontra a linha de varredura de uma aresta
        bool verificaHorizontal(QLine aresta); // Verifica se trata-se de uma aresta horizontal
        int encontraMaxLV(QVector<QLine> arestas); // Encontra a linha de varredura maxima
        void populaET(QVector<QLine> arestas); // Preenche a ET (cria os ETNodes e ordena)

        // Casos de teste para checagem manual
        QVector<QLine> casoTeste1();
        QVector<QLine> casoTeste2();
        QVector<QLine> casoTeste3();

};

#endif // ET_H
