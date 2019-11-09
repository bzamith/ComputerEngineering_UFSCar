#include "areapoligono.h"
#include "ui_areapoligono.h"
#include "et.h"
#include "aet.h"

#include <QPointF>
#include <QPainter>
#include <QColor>
#include <QDebug>
#include <math.h>

AreaPoligono::AreaPoligono(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::AreaPoligono)
{
    ui->setupUi(this);
    iniciou = false; /* Iniciou o desenho */
    encerrou = false; /* Encerrou o desenho */
    comecouAlterar = false;
    alterou = false;
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

void AreaPoligono::criaArestas()
{
    arestas.clear();
    if(!vertices.empty())
    {
        if(vertices.size()>1)
        {
            for(int i=0; i<vertices.size()-1; i++){
                QLine linha = QLine(vertices.at(i),vertices.at(i+1));
                arestas.append(linha);
            }
            QLine linha = QLine(vertices.first(),vertices.last());
            arestas.append(linha);
        }
    }
}

/* Esvazia os vertices e as arestas (depois de pressionar o botao Limpar */
void AreaPoligono::limpaTudo()
{
    vertices.clear();
    arestas.clear();
}


void AreaPoligono::scanLine()
{
    if (arestas.size()>1)
    {
        ET et = ET(arestas);
        et.populaET();
        AET aet = AET(et.getLVs());
        aet.populaAET();
        arestas = aet.getTracos();
        update();
    }
}

/* Encontra os vertices (pelo clique) e desenha as arestas entre vertices consecutivos */
void AreaPoligono::mousePressEvent(QMouseEvent *event)
{
    if(iniciou && !encerrou)
    {
        int x = floor(event->pos().x());
        int y = floor(event->pos().y());
        qDebug() << x << "|"<< y;
        QPoint ponto = QPoint(x,y);
        vertices.append(ponto);

        if(vertices.size()>1)
        {
            QLine linha = QLine(vertices.at(vertices.size()-2),vertices.last());
            arestas.append(linha);
        }
        update();
    }
    else if(encerrou && comecouAlterar){
        int x = floor(event->pos().x());
        int y = floor(event->pos().y());
        QPoint ponto = QPoint(x,y);
        vertices.replace(valorAlterar,ponto);
        criaArestas();
        alterou = true;
        comecouAlterar = false;
        scanLine();
        update();
    }
}

/* Desenha na tela */
void AreaPoligono::paintEvent(QPaintEvent *event)
{
    QPainter painter(this);
    QPen linepen(cor);
    linepen.setCapStyle(Qt::RoundCap);
    painter.setRenderHint(QPainter::Antialiasing,true);
    painter.setPen(linepen);
    if(!comecouAlterar)
    {
        if(!vertices.empty() && !encerrou)
        {
            linepen.setWidth(9);
            painter.setPen(linepen);
            painter.drawPoints(vertices);
        }
        if(!arestas.empty() && encerrou)
        {
            linepen.setWidth(1);
            painter.setPen(linepen);
            painter.drawLines(arestas);
        }
    }
    else{
        if(!vertices.empty() && encerrou)
        {
            linepen.setWidth(9);
            painter.setPen(linepen);
            painter.drawPoint(vertices.at(valorAlterar));
        }
    }
}

