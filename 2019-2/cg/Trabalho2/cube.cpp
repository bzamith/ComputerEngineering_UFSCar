#include "cube.h"
#include "cubetransformation.h"

#include <QVector3D>
#include <GL/glu.h>

Cube::Cube(QWidget *parent) : QGLWidget(parent)
{
    setFormat(QGLFormat(QGL::DoubleBuffer | QGL::DepthBuffer));

    novoCubo();
}

void Cube::novoCubo()
{
    vertices = {
        QVector3D(+1, -1, +1),
        QVector3D(+1, -1, -1),
        QVector3D(+1, +1, -1),
        QVector3D(+1, +1, +1),
        QVector3D(-1, -1, -1),
        QVector3D(-1, -1, +1),
        QVector3D(-1, +1, +1),
        QVector3D(-1, +1, -1)
    };

    faces = {
        {0, 1, 2, 3},
        {4, 5, 6, 7},
        {1, 4, 7, 2},
        {5, 0, 3, 6},
        {4, 1, 0, 5},
        {6, 3, 2, 7},
    };

    faceColors = {
        Qt::red,
        Qt::green,
        Qt::blue,
        Qt::cyan,
        Qt::yellow,
        Qt::magenta
    };

    QVector<QString> ajusteFinal = {"T","z","-10"};
    vertices = CubeTransformation::Transform(vertices, ajusteFinal);
}

void Cube::initializeGL()
{
    qglClearColor(Qt::white);
    glShadeModel(GL_FLAT);
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE);
}

void Cube::resizeGL(int width, int height)
{
    glViewport(0, 0, width, height);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();

    auto ratio = double(width) / height;

    glFrustum(-ratio, ratio, -1.0, 1.0, 4.0, 15.0);
    glMatrixMode(GL_MODELVIEW);
}

void Cube::paintGL()
{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    draw();
}


#include <iostream>
void Cube::draw()
{
    auto outVerts = getVertices();

    for (size_t i = 0; i < faces.size(); i++) {
        glBegin(GL_QUADS);
        qglColor(faceColors[i]);
        for (auto v : faces[i]) {

            glVertex3f(
                    outVerts[v].x(),
                    outVerts[v].y(),
                    outVerts[v].z()
            );
        }
        glEnd();
    }
}

vector<QVector3D> Cube::getVertices()
{
    return this->vertices;
}

void Cube::transformeCube(QVector<QVector<QString>> transformacoes)
{
    this->vertices = CubeTransformation::Transform(vertices, transformacoes.last());
}
