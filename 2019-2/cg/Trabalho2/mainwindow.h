#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QVector>
#include "cube.h"

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();
    QVector<QVector<QString>> transformacoes;
    bool encerrou;

private slots:
    void on_tOk_clicked();

    void on_sOk_clicked();

    void on_rOk_clicked();

    void on_botaoLimpa_clicked();

private:
    Ui::MainWindow *ui;
    bool confereEntrada(QString valor);
};
#endif // MAINWINDOW_H
