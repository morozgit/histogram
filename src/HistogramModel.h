#pragma once

#include <QObject>
#include <QAbstractListModel>
#include <QVariantList>
#include <QVariantMap>
#include <QPair>

class HistogramModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit HistogramModel(QObject *parent = nullptr);

    enum {
        WordRole = Qt::UserRole + 1,
        CountRole
    };

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

public slots:
    void updateHistogram(const QVariantList &topWords);

private:
    QList<QPair<QString, int>> m_topWords;
};
