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
        // console.log("updateHistogram wordCounts", wordCounts)
        dataModel.clear();
        for (var i = 0; i < newWordCounts.length; i++) {
            console.log("updateHistogram", i)
            dataModel.append({"value": newWordCounts[i]});
        }
    }

    ListModel {
        id: dataModel
        ListElement { value: 5 }
        ListElement { value: 10 }
        ListElement { value: 15 }
        ListElement { value: 20 }
        ListElement { value: 25 }
        ListElement { value: 30 }
        ListElement { value: 35 }
        ListElement { value: 40 }
        ListElement { value: 45 }
        ListElement { value: 50 }
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
                    width: 20
                    height: model.value * 4
                    color: "steelblue"
                    border.color: "black"
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
