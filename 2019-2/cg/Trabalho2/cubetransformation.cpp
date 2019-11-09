#include "cubetransformation.h"

#include <QMatrix4x4>
#include <math.h>

vector<QVector3D> CubeTransformation::Transform(vector<QVector3D>& points, QVector<QString> infoTransformacao)
{
    QString tipo = infoTransformacao.at(0);
    QString eixo = infoTransformacao.at(1);
    float valor = infoTransformacao.at(2).toFloat();

    vector<vector<float>> transformacao;

    if(tipo.toUpper() == "T"){
        if(eixo.toUpper() == "X")
            transformacao = translacaoX(valor);
        else if(eixo.toUpper()=="Y")
            transformacao = translacaoY(valor);
        else
            transformacao = translacaoZ(valor);
    }
    else if(tipo.toUpper() == "E"){
        if(eixo.toUpper() == "X")
            transformacao = escalaX(valor);
        else if(eixo.toUpper()=="Y")
            transformacao = escalaY(valor);
        else
            transformacao = escalaZ(valor);
    }
    else{
        if(eixo.toUpper() == "X")
            transformacao = rotacaoX(valor);
        else if(eixo.toUpper()=="Y")
            transformacao = rotacaoY(valor);
        else
            transformacao = rotacaoZ(valor);
    }

    return applyTransformation (points, transformacao);
}

vector<vector<float>> CubeTransformation::translacaoX(float x)
{
    return
    {
        {1, 0, 0, x},
        {0, 1, 0, 0},
        {0, 0, 1, 0},
        {0, 0, 0, 1},
    };
}

vector<vector<float>> CubeTransformation::translacaoY(float y)
{
    return
    {
        {1, 0, 0, 0},
        {0, 1, 0, y},
        {0, 0, 1, 0},
        {0, 0, 0, 1},
    };
}

vector<vector<float>> CubeTransformation::translacaoZ(float z)
{
    return
    {
        {1, 0, 0, 0},
        {0, 1, 0, 0},
        {0, 0, 1, z},
        {0, 0, 0, 1},
    };
}


vector<vector<float>> CubeTransformation::escalaX(float x)
{
    return
    {
        {x, 0, 0, 0},
        {0, 1, 0, 0},
        {0, 0, 1, 0},
        {0, 0, 0, 1},
    };
}

vector<vector<float>> CubeTransformation::escalaY(float y)
{
    return
    {
        {1, 0, 0, 0},
        {0, y, 0, 0},
        {0, 0, 1, 0},
        {0, 0, 0, 1},
    };
}

vector<vector<float>> CubeTransformation::escalaZ(float z)
{
    return
    {
        {1, 0, 0, 0},
        {0, 1, 0, 0},
        {0, 0, z, 0},
        {0, 0, 0, 1},
    };
}

vector<vector<float>> CubeTransformation::rotacaoX(float theta)
{
    float c = cos(theta);
    float s = sin(theta);
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
    float c = cos(theta);
    float s = sin(theta);
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
    float c = cos(theta);
    float s = sin(theta);
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

        outpts[i] = QVector3D(
                trans[0][0] * pt.x() + trans[0][1] * pt.y() + trans[0][2] * pt.z() + trans[0][3],
                trans[1][0] * pt.x() + trans[1][1] * pt.y() + trans[1][2] * pt.z() + trans[1][3],
                trans[2][0] * pt.x() + trans[2][1] * pt.y() + trans[2][2] * pt.z() + trans[2][3]
        );
    }

    return outpts;
}
