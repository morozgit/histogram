import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs
import FileReader 1.0

ApplicationWindow {
    id: main_window
    visible: true
    width: 800
    height: 600
    title: qsTr("Histogram")

    header: DialogButtonBox {
        Button {
            id: openButton
            text: "Открыть"
            onClicked: fileDialog.open()
        }
        Button {
            id: startButton
            text: "Старт"
            onClicked: fileReader.startProcessing()
        }
        Button {
            id: pauseButton
            text: "Пауза"
            onClicked: fileReader.pauseProcessing()
        }
        Button {
            id: cancelButton
            text: "Отмена"
            onClicked: fileReader.cancelProcessing()
        }
    }

    FileDialog {
        id: fileDialog
        onAccepted: {
            var filePath = fileDialog.selectedFile.toLocaleString();
            if (filePath.startsWith("file://")) {
                filePath = filePath.substring(8);
            }
            fileReader.openFile(filePath);
        }
    }

    StackView {
        id: stack
        anchors.fill: parent

        Histogram {
            id: histogram
            anchors.fill: parent
        }
    }

        Connections {
            target: fileReader
            function onUpdateHistogram(topWords) {
                histogram.updateHistogram(topWords)
            }
    }
}
