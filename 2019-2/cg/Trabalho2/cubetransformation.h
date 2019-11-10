#ifndef CUBETRANSFORMATION_H
#define CUBETRANSFORMATION_H

#include <QVector3D>
#include <vector>
using namespace std;

class CubeTransformation
{
public:
    static vector<QVector3D> Transform(vector<QVector3D>&, QVector<QString> transf);

private:
    static vector<vector<float>> translacao (float, float, float);
    static vector<vector<float>> escala (float, float, float);
    static vector<vector<float>> rotacaoX (float);
    static vector<vector<float>> rotacaoY (float);
    static vector<vector<float>> rotacaoZ (float);

    static vector<QVector3D> applyTransformation (vector<QVector3D>&, vector<vector<float>>);
    static QVector3D applyTransformation (QVector3D&, vector<vector<float>>);
};

#endif // CUBETRANSFORMATION_H
