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
    bool iniciou;
    bool encerrou;
    QColor cor;
    explicit AreaPoligono(QWidget *parent = nullptr);
    void limparTudo();
    QVector<QPoint> getVertices();
    QVector<QLine> getArestas();
    void fechaPoligono(); // Desenha a ultima aresta que conecta
    void teste();
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
