import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Dialogs
import Histogram 1.0

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
            onClicked: {
                fileDialog.open()
                console.log("Open")
            }
        }
        Button {
            id: startButton
            text: "Старт"
            onClicked: {
                fileReader.startProcessing()
                console.log("Start")
            }
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
    FileDialog {
           id: fileDialog
           onAccepted: {
               // fileReader.loadFile(fileDialog.fileUrl)
               var filePath
               if (fileDialog.selectedFile.toLocaleString().startsWith("file://")) {
                           filePath = fileDialog.selectedFile.toLocaleString().substring(8);
                       }
               else{
                   console.log("else", filePath)
               }

               var path = fileDialog.selectedFile.toLocaleString().substring(7);
               console.log("filePath", filePath)
               fileReader.openFile(filePath)
           }
       }
    }

    StackView {
        id: stack
        initialItem: mainView
        anchors.fill: parent

        Item {
            id: mainView
            Column {
                anchors.fill: parent
                spacing: 20

                ProgressBar {
                    id: progressBar
                    width: parent.width
                    // value: fileReader.progress
                }

                Histogram {
                    id: histogram
                }
            }
        }
    }
}
