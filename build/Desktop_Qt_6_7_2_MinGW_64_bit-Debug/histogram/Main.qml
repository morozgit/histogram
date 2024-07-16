import QtQuick
import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id:main_window
    visible: true
    width: 800
    height: 600
    title: qsTr("Histogram")
    header: DialogButtonBox{
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
    StackView {
            id: stack
            initialItem: mainView
            anchors.fill: parent
        }

        Component {
            id: mainView

            Row {
                spacing: 10

                Button {
                    text: "Push"
                    onClicked: stack.push(mainView)
                }
                Button {
                    text: "Pop"
                    enabled: stack.depth > 1
                    onClicked: stack.pop()

                }
                Text {
                    text: stack.depth
                }
            }
        }


    // Rectangle {
    //     id: rectangle_button
    //     color: "red"
    //     width: main_window.width - 20; height: parent.height / 4
    //     anchors.leftMargin: 200
    //     Button {
    //         id: openButton
    //         text: "Открыть"
    //         onClicked: fileDialog.open()
    //     }
    //     Button {
    //         id: startButton
    //         text: "Старт"
    //         onClicked: fileReader.startProcessing()
    //         anchors.left: openButton.right
    //         anchors.leftMargin: 25
    //     }
    //     Button {
    //         id: pauseButton
    //         text: "Пауза"
    //         onClicked: fileReader.pauseProcessing()
    //         anchors.left: startButton.right
    //         anchors.leftMargin: 25
    //     }
    //     Button {
    //         id: cancelButton
    //         text: "Отмена"
    //         onClicked: fileReader.cancelProcessing()
    //         anchors.left: pauseButton.right
    //         anchors.leftMargin: 25
    //     }
    // }
}
