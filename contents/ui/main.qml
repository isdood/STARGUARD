import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.plasma.plasmoid 2.0

Item {
    id: root

    property var glimmerColors: [
        "#00ffff",  // Quantum Cyan
        "#ffd700",  // GLIMMER Gold
        "#4169e1"   // STARWEAVE Blue
    ]
    property int glimmerIndex: 0
    property bool isProtecting: true

    Plasmoid.fullRepresentation: Item {
        Layout.minimumWidth: 300
        Layout.minimumHeight: 400

        ColumnLayout {
            anchors.fill: parent
            spacing: PlasmaCore.Units.smallSpacing * 2

            // Header with GLIMMER effect
            PlasmaExtras.Header {
                Layout.fillWidth: true
                text: "✨ STARGUARD"

                Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                    border.width: 2
                    border.color: root.glimmerColors[root.glimmerIndex]
                    radius: 4
                    opacity: 0.6

                    NumberAnimation on border.color {
                        from: root.glimmerColors[root.glimmerIndex]
                        to: root.glimmerColors[(root.glimmerIndex + 1) % 3]
                        duration: 3000
                        running: true
                        loops: Animation.Infinite
                        onFinished: root.glimmerIndex = (root.glimmerIndex + 1) % 3
                    }
                }
            }

            // Status Section
            PlasmaComponents.Label {
                Layout.alignment: Qt.AlignCenter
                text: "💫 System Protection Status"
                font.bold: true
            }

            PlasmaComponents.Button {
                Layout.alignment: Qt.AlignCenter
                text: isProtecting ? "🛡️ Protection Active" : "⚠️ Protection Inactive"
                icon.name: isProtecting ? "security-high" : "security-low"

                background: Rectangle {
                    radius: 4
                    gradient: Gradient {
                        GradientStop {
                            position: 0.0
                            color: isProtecting ? "#004400" : "#440000"
                        }
                        GradientStop {
                            position: 1.0
                            color: isProtecting ? "#006600" : "#660000"
                        }
                    }
                }

                onClicked: isProtecting = !isProtecting
            }

            // Stats Section
            GridLayout {
                Layout.fillWidth: true
                columns: 2
                rowSpacing: PlasmaCore.Units.smallSpacing
                columnSpacing: PlasmaCore.Units.smallSpacing

                PlasmaComponents.Label { text: "🔮 Quantum State:" }
                PlasmaComponents.Label { text: "Coherent" }

                PlasmaComponents.Label { text: "✨ GLIMMER Level:" }
                PlasmaComponents.Label { text: "0.99" }

                PlasmaComponents.Label { text: "🌟 Active Patterns:" }
                PlasmaComponents.Label { text: "3/3" }
            }

            // Separator with GLIMMER effect
            Rectangle {
                Layout.fillWidth: true
                height: 2
                color: root.glimmerColors[root.glimmerIndex]

                NumberAnimation on color {
                    from: root.glimmerColors[root.glimmerIndex]
                    to: root.glimmerColors[(root.glimmerIndex + 1) % 3]
                    duration: 3000
                    running: true
                    loops: Animation.Infinite
                }
            }
        }
    }

    Plasmoid.icon: isProtecting ? "security-high" : "security-low"
    Plasmoid.toolTipMainText: "STARGUARD Quantum Protection"
    Plasmoid.toolTipSubText: isProtecting ?
    "✨ System protected with quantum coherence" :
    "⚠️ Protection inactive"
}
