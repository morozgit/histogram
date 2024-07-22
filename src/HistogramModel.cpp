#include "HistogramModel.h"

HistogramModel::HistogramModel(QObject *parent)
    : QAbstractListModel(parent), m_topWords()
{}

int HistogramModel::rowCount(const QModelIndex &parent) const {
    Q_UNUSED(parent);
    return m_topWords.size();
}

QVariant HistogramModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid() || index.row() >= m_topWords.size())
        return QVariant();

    const QPair<QString, int> &item = m_topWords.at(index.row());

    switch (role) {
    case WordRole:
        return item.first;
    case CountRole:
        return item.second;
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> HistogramModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[WordRole] = "word";
    roles[CountRole] = "count";
    return roles;
}

void HistogramModel::updateHistogram(const QVariantList &topWords) {
    QList<QPair<QString, int>> convertedList;
    for (const QVariant &item : topWords) {
        QVariantMap map = item.toMap();
        QString key = map["key"].toString();
        int value = map["value"].toInt();
        convertedList.append(qMakePair(key, value));
    }

    beginResetModel();
    m_topWords = convertedList;
    endResetModel();
}
