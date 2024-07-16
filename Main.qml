import QtQuick
import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: qsTr("Hello World")
    Column {
            spacing: 10
            padding: 10

            Row {
                spacing: 10
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
    }
}
