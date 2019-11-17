#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QtGui>
#include <QtQuick>

#include <QCommandLineParser>

#include "myio.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<MyIOout>("IO", 1, 0, "MyIOout");

    QCommandLineParser parser;
    QCommandLineOption fullMode("main");
    QCommandLineOption serviceMode("service");

    parser.addOption(fullMode);
    parser.addOption(serviceMode);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);


    return app.exec();
}
