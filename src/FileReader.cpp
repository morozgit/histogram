#include "FileReader.h"

FileReader::FileReader(QObject *parent)
    : QObject(parent)
{}

void FileReader::openFile(const QString &filePath) {
    file.setFileName(filePath);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Cannot open file:" << filePath;
        return;
    }
    qDebug() << "filePath in openFile" << file.fileName();
    stream.setDevice(&file);
}

void FileReader::startProcessing() {
    isPaused = false;
    isCancelled = false;
    qDebug() << "startProcessing" << file.fileName();
    auto future = QtConcurrent::run([this]() { processFile(); });
}

void FileReader::pauseProcessing() {
    QMutexLocker locker(&mutex);
    isPaused = true;
}

void FileReader::cancelProcessing() {
    QMutexLocker locker(&mutex);
    isCancelled = true;
}

void FileReader::processFile() {
    qDebug() << "processFile" << file.fileName();
    int progress = 0;
    QMap<QString, int> wordCount;

    while (!stream.atEnd()) {
        if (isCancelled) {
            break;
        }
        QMutexLocker locker(&mutex);
        if (isPaused) {
            locker.unlock();
            QThread::msleep(100);
            continue;
        }

        QString line = stream.readLine();
        QStringList words = line.split(QRegularExpression("\\W+"), Qt::SkipEmptyParts);
        for (const QString &word : words) {
            wordCount[word.toLower()]++;
        }

        progress += words.size();
        emit progressChanged(progress);

        // Convert QMap to QList<QPair<QString, int>>
        QList<QPair<QString, int>> topWords;
        for (auto it = wordCount.constBegin(); it != wordCount.constEnd(); ++it) {
            topWords.append(qMakePair(it.key(), it.value()));
        }

        // Sort topWords by count
        std::sort(topWords.begin(), topWords.end(), [](const QPair<QString, int> &a, const QPair<QString, int> &b) {
            return a.second > b.second;
        });

        if (topWords.size() > 15) {
            topWords = topWords.mid(0, 15);
        }

        histogramModel->updateHistogram(topWords);

        locker.unlock();
        QThread::msleep(10); // simulate delay for "real-time" effect
    }

    emit finished();
}

