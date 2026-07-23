import Quickshell
import QtQuick

ShellRoot {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            required property var modelData
            screen: modelData
            anchors { top: true; left: true; right: true }
            implicitHeight: 38
            color: "transparent"

            Rectangle {
                anchors.fill: parent
                anchors.margins: 6
                radius: 12
                color: "#e61e1e2e"
                border.color: "#cba6f7"
                border.width: 1

                Text {
                    anchors.centerIn: parent
                    text: Qt.formatDateTime(new Date(), "ddd, MMM d  •  h:mm AP")
                    color: "#cdd6f4"
                    font.pixelSize: 13
                }
            }
        }
    }
}
