#ifndef CUBETRANSFORMATION_H
#define CUBETRANSFORMATION_H

#include <QVector3D>
#include <vector>
using namespace std;

class CubeTransformation
{
public:
    static vector<QVector3D> Transform(vector<QVector3D>&, QVector<QString>);

private:
    static vector<vector<float>> translacaoX (float);
    static vector<vector<float>> translacaoY (float);
    static vector<vector<float>> translacaoZ (float);
    static vector<vector<float>> escalaX (float);
    static vector<vector<float>> escalaY (float);
    static vector<vector<float>> escalaZ (float);
    static vector<vector<float>> rotacaoX (float);
    static vector<vector<float>> rotacaoY (float);
    static vector<vector<float>> rotacaoZ (float);

    static vector<QVector3D> applyTransformation (vector<QVector3D>&, vector<vector<float>>);
};

#endif // CUBETRANSFORMATION_H
