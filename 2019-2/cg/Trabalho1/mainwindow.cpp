#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <QDebug>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}

/* Pressionando o botao de controle */
void MainWindow::on_botaoControle_clicked()
{
    if(ui->botaoControle->text() == "Iniciar")
    {
        ui->areaPoligono->iniciou = true;
        ui->botaoControle->setText("Encerrar");
    }
    else if(ui->botaoControle->text() == "Encerrar")
    {
        ui->areaPoligono->encerrou = true;
        ui->areaPoligono->fechaPoligono();
        ui->areaPoligono->teste();
        ui->botaoControle->setText("Limpar");
    }
    else if(ui->botaoControle->text() == "Limpar")
    {
        ui->areaPoligono->limparTudo();
        ui->areaPoligono->iniciou = false;
        ui->areaPoligono->encerrou = false;
        ui->areaPoligono->update();
        ui->botaoControle->setText("Iniciar");
    }
}

/* Selecionando a cor */
void MainWindow::on_dropdownCores_currentTextChanged(const QString &arg1)
{
    QString cor = ui->dropdownCores->currentText();
    if (!ui->areaPoligono->iniciou){
        if (cor == "Black")
            ui->areaPoligono->cor = Qt::black;
        else if(cor == "Red")
            ui->areaPoligono->cor = Qt::red;
        else if (cor == "Blue")
            ui->areaPoligono->cor = Qt::blue;
        else if (cor == "Cyan")
            ui->areaPoligono->cor = Qt::cyan;
        else if (cor == "Yellow")
            ui->areaPoligono->cor = Qt::yellow;
        else if (cor == "Red")
            ui->areaPoligono->cor = Qt::red;
        else if (cor == "Magenta")
            ui->areaPoligono->cor = Qt::magenta;
        else if (cor == "Gray")
            ui->areaPoligono->cor = Qt::gray;
        else if (cor == "Green")
            ui->areaPoligono->cor = Qt::green;
    }
}

