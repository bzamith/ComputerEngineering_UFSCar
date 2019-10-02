#include "et.h"

#include <QtDebug>

ET::ET(){}

ET::ET(QVector<QLine> arestas)
{
    /* Fazer a funcao que acha o y min de cada uma, que eh um scan line, e cria os ENodes apropriados */
    arestas.pop_back();
}


