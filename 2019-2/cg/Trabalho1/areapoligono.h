#ifndef AREAPOLIGONO_H
#define AREAPOLIGONO_H

#include <QWidget>
#include <QGraphicsView>
#include <QGraphicsScene>
#include <QGraphicsEllipseItem>
#include <QMouseEvent>

namespace Ui {
class AreaPoligono;
}

class AreaPoligono : public QWidget
{
    Q_OBJECT

public:
    bool iniciou, encerrou, comecouAlterar, alterou;
    int valorAlterar;
    QColor cor;
    QVector<QPoint> getVertices();
    QVector<QLine> getArestas();
    explicit AreaPoligono(QWidget *parent = nullptr);
    void limpaTudo();
    void criaArestas();
    void scanLine();
    ~AreaPoligono();

protected:
    void mousePressEvent(QMouseEvent *event);
    void paintEvent(QPaintEvent *event);

private:
    Ui::AreaPoligono *ui;
    QVector<QPoint> vertices;
    QVector<QLine> arestas;
};


#endif // AREAPOLIGONO_H
