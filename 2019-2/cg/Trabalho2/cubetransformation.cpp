#include "cubetransformation.h"

#include <QMatrix4x4>
#include <math.h>

vector<QVector3D> CubeTransformation::Transform(vector<QVector3D>& points)
{
    // moves the cube 10 units backwards,
    // so it can fit in the far / near clipping planes
    auto tz = translationZ(-10);
    return applyTransformation (points, tz);
}

vector<vector<float>> CubeTransformation::translationX (float x)
{
    return
    {
        {1, 0, 0, x},
        {0, 1, 0, 0},
        {0, 0, 1, 0},
        {0, 0, 0, 1},
    };
}

vector<vector<float>> CubeTransformation::translationY (float y)
{
    return
    {
        {1, 0, 0, 0},
        {0, 1, 0, y},
        {0, 0, 1, 0},
        {0, 0, 0, 1},
    };
}

vector<vector<float>> CubeTransformation::translationZ (float z)
{
    return
    {
        {1, 0, 0, 0},
        {0, 1, 0, 0},
        {0, 0, 1, z},
        {0, 0, 0, 1},
    };
}


vector<vector<float>> CubeTransformation::scaleX (float x)
{
    return
    {
        {x, 0, 0, 0},
        {0, 1, 0, 0},
        {0, 0, 1, 0},
        {0, 0, 0, 1},
    };
}

vector<vector<float>> CubeTransformation::scaleY (float y)
{
    return
    {
        {1, 0, 0, 0},
        {0, y, 0, 0},
        {0, 0, 1, 0},
        {0, 0, 0, 1},
    };
}

vector<vector<float>> CubeTransformation::scaleZ (float z)
{
    return
    {
        {1, 0, 0, 0},
        {0, 1, 0, 0},
        {0, 0, z, 0},
        {0, 0, 0, 1},
    };
}

vector<vector<float>> CubeTransformation::rotationX (float teta)
{
    float c = cos(teta);
    float s = sin(teta);
    return
    {
        {1, 0, 0, 0},
        {0, c, -s, 0},
        {0, s, c, 0},
        {0, 0, 0, 1},
    };
}

vector<vector<float>> CubeTransformation::rotationY (float teta)
{
    float c = cos(teta);
    float s = sin(teta);
    return
    {
        {c, 0, s, 0},
        {0, 1, 0, 0},
        {-s, 0, c, 0},
        {0, 0, 0, 1},
    };
}

vector<vector<float>> CubeTransformation::rotationZ (float teta)
{
    float c = cos(teta);
    float s = sin(teta);
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
