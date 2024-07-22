#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "src/HistogramModel.h"
#include "src/FileReader.h"

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    qmlRegisterType<HistogramModel>("Histogram", 1, 0, "Histogram");
    qmlRegisterType<HistogramModel>("FileReader", 1, 0, "FileReader");
    QQmlApplicationEngine engine;

    HistogramModel histogramModel;
    FileReader fileReader;

    QObject::connect(&fileReader, &FileReader::updateHistogram, &histogramModel, &HistogramModel::updateHistogram);
    engine.rootContext()->setContextProperty("fileReader", &fileReader);
    engine.rootContext()->setContextProperty("histogramModel", &histogramModel);

    const QUrl url(QStringLiteral("histogram/qml/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
