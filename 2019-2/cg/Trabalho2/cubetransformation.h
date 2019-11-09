#ifndef CUBETRANSFORMATION_H
#define CUBETRANSFORMATION_H

#include <QVector3D>
#include <vector>
using namespace std;

class CubeTransformation
{
public:
    static vector<QVector3D> Transform(vector<QVector3D>&);

private:
    static vector<vector<float>> translationX (float);
    static vector<vector<float>> translationY (float);
    static vector<vector<float>> translationZ (float);
    static vector<vector<float>> scaleX (float);
    static vector<vector<float>> scaleY (float);
    static vector<vector<float>> scaleZ (float);
    static vector<vector<float>> rotationX (float);
    static vector<vector<float>> rotationY (float);
    static vector<vector<float>> rotationZ (float);

    static vector<QVector3D> applyTransformation (vector<QVector3D>&, vector<vector<float>>);
};

#endif // CUBETRANSFORMATION_H
