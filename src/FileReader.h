#pragma once
#include <QObject>
#include <QFile>
#include <QTextStream>
#include <QMap>
#include <QMutex>
#include <QtConcurrent/QtConcurrent>
#include <QDebug>
#include <QRegularExpression>
#include "HistogramModel.h"


class FileReader : public QObject
{
    Q_OBJECT
public:
    explicit FileReader(QObject *parent = nullptr);
public slots:
    void openFile(const QString &filePath);
    void startProcessing();
    void pauseProcessing();
    void cancelProcessing();

signals:
    void updateHistogram(const QList<QPair<QString, int>> &topWords);
    void progressChanged(int progress);
    void finished();

private:
    void processFile();
    QMutex mutex;
    QFile file;
    QTextStream stream;
    bool isPaused;
    bool isCancelled;
    HistogramModel* histogramModel;
};
