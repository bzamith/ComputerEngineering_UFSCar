#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    encerrou = false;
}

MainWindow::~MainWindow()
{
    delete ui;
}

// Inseriu translacao
void MainWindow::on_tOk_clicked()
{
    if(!encerrou){
        QString tipo = "Translação";
        QString eixo = ui->tEixo->currentText();
        QString valor = ui->tValor->text();
        if(this->confereEntrada(valor)){
            QVector<QString> transf = {tipo.at(0),eixo.at(eixo.size()-1),valor};
            this->transformacoes.push_back(transf);

            QString index;
            index.setNum(this->transformacoes.size());

            QString novaAcao = index + ". " + tipo + " de " + valor + " no " + eixo;
            ui->listaAcoes->append(novaAcao);
        }
        ui->areaDesenho->transformeCube(this->transformacoes);
        ui->areaDesenho->update();
    }
}

// Inseriu escala
void MainWindow::on_sOk_clicked()
{
    if(!encerrou){
        QString tipo = "Escala";
        QString eixo = ui->sEixo->currentText();
        QString valor = ui->sValor->text();
        if(this->confereEntrada(valor)){
            QVector<QString> transf = {tipo.at(0),eixo.at(eixo.size()-1),valor};
            this->transformacoes.push_back(transf);

            QString index;
            index.setNum(this->transformacoes.size());

            QString novaAcao = index + ". " + tipo + " de " + valor + " no " + eixo;
            ui->listaAcoes->append(novaAcao);
        }
    }
    ui->areaDesenho->transformeCube(this->transformacoes);
    ui->areaDesenho->update();
}

// Inseriu rotacao
void MainWindow::on_rOk_clicked()
{
    if(!encerrou){
        QString tipo = "Rotação";
        QString eixo = ui->rEixo->currentText();
        QString valor = ui->rValor->text();
        if(this->confereEntrada(valor)){
            QVector<QString> transf = {tipo.at(0),eixo.at(eixo.size()-1),valor};
            this->transformacoes.push_back(transf);

            QString index;
            index.setNum(this->transformacoes.size());

            QString novaAcao = index + ". " + tipo + " de " + valor + " graus no " + eixo;
            ui->listaAcoes->append(novaAcao);
        }
    }
    ui->areaDesenho->transformeCube(this->transformacoes);
    ui->areaDesenho->update();
}

bool MainWindow::confereEntrada(QString valor){
    if(valor.isEmpty())
        return false;
    bool isNumeric = false;
    valor.toDouble(&isNumeric);
    if(isNumeric == false)
        return false;
    return true;
}

void MainWindow::on_botaoLimpa_clicked()
{
    if(!encerrou){
        //encerrou = true;
        this->transformacoes.clear();
        ui->listaAcoes->clear();
        ui->areaDesenho->novoCubo();
        ui->areaDesenho->update();
    }
}
