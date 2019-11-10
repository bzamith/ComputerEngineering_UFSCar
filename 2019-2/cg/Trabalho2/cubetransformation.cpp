#include "cubetransformation.h"

#include <QMatrix4x4>
#include <math.h>

#define PI 3.14159265

vector<QVector3D> CubeTransformation::Transform(vector<QVector3D>& points, QVector<QString> infoTransformacao)
{
    QString tipo = infoTransformacao.at(0);
    QString eixo = infoTransformacao.at(1);
    float valor = infoTransformacao.at(2).toFloat();

    vector<vector<float>> transformacao;

    if(tipo.toUpper() == "T"){
        if(eixo.toUpper() == "X")
            transformacao = translacao(valor,0,0);
        else if(eixo.toUpper()=="Y")
            transformacao = translacao(0,valor,0);
        else
            transformacao = translacao(0,0,valor);
    }
    else if(tipo.toUpper() == "E"){
        if(eixo.toUpper() == "X")
            transformacao = escala(valor, 1, 1);
        else if(eixo.toUpper()=="Y")
            transformacao = escala(1,valor,1);
        else
            transformacao = escala(1,1,valor);
    }
    else{
        if(eixo.toUpper() == "X")
            transformacao = rotacaoX(valor);
        else if(eixo.toUpper()=="Y")
            transformacao = rotacaoY(valor);
        else
            transformacao = rotacaoZ(valor);
    }
    points = applyTransformation(points,transformacao);
    return points;
}

vector<vector<float>> CubeTransformation::translacao(float x, float y, float z)
{
    return
    {
        {1, 0, 0, x},
        {0, 1, 0, y},
        {0, 0, 1, z},
        {0, 0, 0, 1},
    };
}

vector<vector<float>> CubeTransformation::escala(float x, float y, float z)
{
    return
    {
        {x, 0, 0, 0},
        {0, y, 0, 0},
        {0, 0, z, 0},
        {0, 0, 0, 1},
    };
}

vector<vector<float>> CubeTransformation::rotacaoX(float theta)
{
    float theta_radians = theta*PI/180;
    float c = cos(theta_radians);
    float s = sin(theta_radians);
    return
    {
        {1, 0, 0, 0},
        {0, c, -s, 0},
        {0, s, c, 0},
        {0, 0, 0, 1},
    };
}

vector<vector<float>> CubeTransformation::rotacaoY(float theta)
{
    float theta_radians = theta*PI/180;
    float c = cos(theta_radians);
    float s = sin(theta_radians);
    return
    {
        {c, 0, s, 0},
        {0, 1, 0, 0},
        {-s, 0, c, 0},
        {0, 0, 0, 1},
    };
}

vector<vector<float>> CubeTransformation::rotacaoZ(float theta)
{
    float theta_radians = theta*PI/180;
    float c = cos(theta_radians);
    float s = sin(theta_radians);
    return
    {
        {c, -s, 0, 0},
        {s, c, 0, 0},
        {0, 0, 1, 0},
        {0, 0, 0, 1},
    };
}

vector<QVector3D> CubeTransformation::applyTransformation (vector<QVector3D>& pts,
                                                           vector<vector<float>> trans)
{
    vector<QVector3D> outpts (pts.size());

    for (size_t i = 0; i < pts.size(); i++) {
        auto pt = pts[i];
        pt = applyTransformation(pt,trans);
        outpts[i] = pt;
    }

    return outpts;
}

QVector3D CubeTransformation::applyTransformation (QVector3D& pt,
                                                           vector<vector<float>> trans)
{
    QVector3D outpt;
    float div = trans[3][0] * pt.x() + trans[3][1] * pt.y() + trans[3][2] * pt.z() + trans[3][3];
     outpt = QVector3D(
                (trans[0][0] * pt.x() + trans[0][1] * pt.y() + trans[0][2] * pt.z() + trans[0][3])/div,
                (trans[1][0] * pt.x() + trans[1][1] * pt.y() + trans[1][2] * pt.z() + trans[1][3])/div,
                (trans[2][0] * pt.x() + trans[2][1] * pt.y() + trans[2][2] * pt.z() + trans[2][3])/div
        );

    return outpt;
}

