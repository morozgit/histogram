import QtQuick 2.15

Rectangle {
    id: histogram
    width: 800
    height: 400
    color: "white"
    border.color: "black"
    radius: 5

    property var wordCounts: []

    function updateHistogram(newWordCounts) {
        wordCounts = newWordCounts;
        dataModel.clear();
        for (var i = 0; i < newWordCounts.length; i++) {
            var item = newWordCounts[i];
            if (item && item.key !== undefined && item.value !== undefined) {
                dataModel.append({ "key": item.key, "value": item.value });
            } else {
                console.error("Invalid item format:", item);
            }
        }
    }

    ListModel {
        id: dataModel
    }

    Column {
        anchors.centerIn: parent
        spacing: 10

        Rectangle {
            width: parent.width
            height: 2
            color: "black"
        }

        Row {
            spacing: 5
            Repeater {
                model: dataModel
                Rectangle {
                    width: 80
                    height: model.value * 15
                    color: "steelblue"
                    border.color: "black"
                    Text {
                        id: itemtext
                        text: qsTr(model.key + "\n " + model.value.toString())
                        font.pixelSize: 10
                        font.bold: true
                        font.family: "Arial"
                        color: "black"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.WordWrap
                    }
                }
            }
        }

        Rectangle {
            width: parent.width
            height: 2
            color: "black"
        }
    }
}
