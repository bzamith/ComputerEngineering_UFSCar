#include "areapoligono.h"
#include "ui_areapoligono.h"

#include <et.cpp>
#include <QPointF>
#include <QPainter>
#include <QColor>
#include <QDebug>

AreaPoligono::AreaPoligono(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::AreaPoligono)
{
    ui->setupUi(this);
    iniciou = false; /* Iniciou o desenho */
    encerrou = false; /* Encerrou o desenho */
    cor = Qt::black; /* Cor das linhas e do preenchimento */
}

AreaPoligono::~AreaPoligono()
{
    delete ui;
}

QVector<QPoint> AreaPoligono::getVertices()
{
    return vertices;
}

QVector<QLine> AreaPoligono::getArestas()
{
    return arestas;
}

/* Apos clicar em encerrar, se tiver mais que 2 lados, fecha o poligo */
void AreaPoligono::fechaPoligono()
{
    if(!vertices.empty())
    {
        if(vertices.size()>2)
        {
            QLine linha = QLine(vertices.first(),vertices.last());
            arestas.append(linha);
            update();
        }
    }
}

/* Esvazia os vertices e as arestas (depois de pressionar o botao Limpar */
void AreaPoligono::limparTudo()
{
    vertices.clear();
    arestas.clear();
}

/* Encontra os vertices (pelo clique) e desenha as arestas entre vertices consecutivos */
void AreaPoligono::mousePressEvent(QMouseEvent *event)
{
    if(iniciou && !encerrou)
    {
        QPoint ponto = event->pos();
        vertices.append(ponto);
        if(vertices.size()>1)
        {
            QLine linha = QLine(vertices.at(vertices.size()-2),vertices.last());
            arestas.append(linha);
        }
        update();
    }
}

/* Desenha na tela */
void AreaPoligono::paintEvent(QPaintEvent *event)
{
    QPainter painter(this);
    QPen linepen(cor);
    linepen.setCapStyle(Qt::RoundCap);
    linepen.setWidth(1);
    painter.setRenderHint(QPainter::Antialiasing,true);
    painter.setPen(linepen);
    if(!vertices.empty())
    {
        painter.drawPoints(vertices);
    }
    if(!arestas.empty())
    {
        painter.drawLines(arestas);
    }
}



