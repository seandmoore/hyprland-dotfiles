import Quickshell
import QtQuick

PanelWindow {
    id: launcher

    readonly property string query: searchInput.text.trim().toLowerCase()

    function showLauncher(): void {
        visible = true
        Qt.callLater(function() {
            searchInput.text = ""
            appList.currentIndex = appList.count > 0 ? 0 : -1
            searchInput.forceActiveFocus()
        })
    }

    function hideLauncher(): void {
        visible = false
        searchInput.text = ""
    }

    function toggleLauncher(): void {
        if (visible)
            hideLauncher()
        else
            showLauncher()
    }

    function launch(entry): void {
        if (!entry)
            return

        hideLauncher()
        entry.execute()
    }

    visible: false
    anchors {
        top: true
        right: true
        bottom: true
        left: true
    }
    exclusiveZone: 0
    focusable: true
    color: "#66000000"

    MouseArea {
        anchors.fill: parent
        onClicked: launcher.hideLauncher()
    }

    Rectangle {
        anchors.centerIn: parent
        width: Math.min(parent.width - 32, 620)
        height: Math.min(parent.height - 120, 680)
        radius: 22
        color: "#f21e1e2e"
        border.color: "#cba6f7"
        border.width: 1

        MouseArea {
            anchors.fill: parent
            onClicked: function(mouse) { mouse.accepted = true }
        }

        Column {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 14

            Text {
                text: "Applications"
                color: "#cdd6f4"
                font.pixelSize: 24
                font.weight: Font.DemiBold
            }

            Rectangle {
                width: parent.width
                height: 48
                radius: 14
                color: "#313244"
                border.color: searchInput.activeFocus ? "#89b4fa" : "#585b70"
                border.width: 1

                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 16
                    anchors.verticalCenter: parent.verticalCenter
                    visible: searchInput.text.length === 0
                    text: "Search applications"
                    color: "#a6adc8"
                    font.pixelSize: 15
                }

                TextInput {
                    id: searchInput
                    anchors.fill: parent
                    anchors.leftMargin: 16
                    anchors.rightMargin: 16
                    verticalAlignment: TextInput.AlignVCenter
                    color: "#cdd6f4"
                    selectionColor: "#89b4fa"
                    selectedTextColor: "#1e1e2e"
                    font.pixelSize: 15
                    clip: true

                    onTextChanged: appList.currentIndex = appList.count > 0 ? 0 : -1

                    Keys.onPressed: function(event) {
                        if (event.key === Qt.Key_Escape) {
                            launcher.hideLauncher()
                            event.accepted = true
                        } else if (event.key === Qt.Key_Down && appList.count > 0) {
                            appList.currentIndex = Math.min(appList.currentIndex + 1, appList.count - 1)
                            appList.positionViewAtIndex(appList.currentIndex, ListView.Contain)
                            event.accepted = true
                        } else if (event.key === Qt.Key_Up && appList.count > 0) {
                            appList.currentIndex = Math.max(appList.currentIndex - 1, 0)
                            appList.positionViewAtIndex(appList.currentIndex, ListView.Contain)
                            event.accepted = true
                        } else if ((event.key === Qt.Key_Return || event.key === Qt.Key_Enter)
                                   && appList.currentIndex >= 0) {
                            launcher.launch(filteredApps.values[appList.currentIndex])
                            event.accepted = true
                        }
                    }
                }
            }

            Text {
                text: appList.count === 1 ? "1 result" : appList.count + " results"
                color: "#a6adc8"
                font.pixelSize: 12
            }

            ListView {
                id: appList
                width: parent.width
                height: parent.height - y
                clip: true
                spacing: 4
                currentIndex: count > 0 ? 0 : -1
                model: ScriptModel {
                    id: filteredApps
                    values: {
                        const apps = [...DesktopEntries.applications.values].sort(function(left, right) {
                            return left.name.localeCompare(right.name)
                        })

                        if (launcher.query.length === 0)
                            return apps

                        return apps.filter(function(entry) {
                            const keywords = entry.keywords && entry.keywords.join
                                ? entry.keywords.join(" ")
                                : ""
                            const searchable = [entry.name, entry.genericName, entry.comment, keywords]
                                .join(" ")
                                .toLowerCase()
                            return searchable.indexOf(launcher.query) !== -1
                        })
                    }
                }

                onCountChanged: currentIndex = count > 0 ? 0 : -1

                delegate: Rectangle {
                    required property var modelData
                    required property int index

                    width: ListView.view.width
                    height: 58
                    radius: 12
                    color: ListView.isCurrentItem ? "#45475a" : appMouse.containsMouse ? "#313244" : "transparent"

                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: 12
                        anchors.rightMargin: 12
                        spacing: 12

                        Image {
                            anchors.verticalCenter: parent.verticalCenter
                            width: 34
                            height: 34
                            source: Quickshell.iconPath(modelData.icon, "application-x-executable")
                            sourceSize.width: 34
                            sourceSize.height: 34
                            fillMode: Image.PreserveAspectFit
                        }

                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width - 58
                            spacing: 2

                            Text {
                                width: parent.width
                                text: modelData.name
                                color: "#cdd6f4"
                                font.pixelSize: 15
                                font.weight: Font.Medium
                                elide: Text.ElideRight
                            }

                            Text {
                                width: parent.width
                                visible: text.length > 0
                                text: modelData.genericName || modelData.comment
                                color: "#a6adc8"
                                font.pixelSize: 12
                                elide: Text.ElideRight
                            }
                        }
                    }

                    MouseArea {
                        id: appMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: appList.currentIndex = index
                        onClicked: launcher.launch(modelData)
                    }
                }

                Text {
                    anchors.centerIn: parent
                    visible: appList.count === 0
                    text: "No applications found"
                    color: "#a6adc8"
                    font.pixelSize: 15
                }
            }
        }
    }
}
