import QtQuick
import QtQuick.Controls 2.15

Rectangle {
    id: histogram
    color: "white"
    border.color: "black"
    radius: 5
    anchors.horizontalCenter: parent.horizontalCenter

    property var wordCounts: []

    function updateHistogram() {
        update();
    }

    Canvas {
        id: canvas
        anchors.fill: parent
        onPaint: {
            const ctx = canvas.getContext('2d');
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            const maxCount = Math.max(...wordCounts.map(w => w.count));
            const barWidth = canvas.width / wordCounts.length;

            wordCounts.forEach((word, index) => {
                const barHeight = (word.count / maxCount) * canvas.height;
                ctx.fillStyle = "blue";
                ctx.fillRect(index * barWidth, canvas.height - barHeight, barWidth - 2, barHeight);
                ctx.fillStyle = "black";
                ctx.fillText(word.word, index * barWidth + 2, canvas.height - barHeight - 5);
            });
        }
    }

    Component.onCompleted: {
        canvas.requestPaint();
    }

    onWordCountsChanged: {
        updateHistogram();
    }
}
