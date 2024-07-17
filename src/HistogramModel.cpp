#include "HistogramModel.h"

HistogramModel::HistogramModel(QObject *parent)
    : QAbstractListModel(parent)
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

void HistogramModel::updateHistogram(const QList<QPair<QString, int>> &topWords) {
    beginResetModel();
    m_topWords = topWords;
    endResetModel();
}
