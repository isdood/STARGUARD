#!/usr/bin/env fish

# `<gl-prism color="#00ffff,#50c878">`Initialize STARWEAVE quantum matrix`</gl-prism>`
set -l QUANTUM_CYAN (set_color -o cyan)
set -l STARWEAVE_GOLD (set_color -o yellow)
set -l GLIMMER_BLUE (set_color -o blue)
set -l VOID_RED (set_color -o red)
set -l QUANTUM_RESET (set_color normal)
set -l TIMESTAMP (date "+%Y-%m-%d %H:%M:%S")

# `<gl-shimmer color="#ffd700,#4169e1">`Define quantum constants`</gl-shimmer>`
set -l USER_HOME $HOME
set -l PLASMOID_NAME "org.kde.starguard"
set -l PLASMOID_BASE "$USER_HOME/.local/share/plasma/plasmoids"
set -l PLASMOID_PATH "$PLASMOID_BASE/$PLASMOID_NAME"

function handle_error
    echo "$VOID_RED❌ Quantum disruption: $argv[1]$QUANTUM_RESET"
    return 1
end

echo "$QUANTUM_CYAN✨ STARWEAVE quantum matrix initialization...$QUANTUM_RESET"

# `<gl-crystal color="#4169e1,#50c878">`Clean up existing installation`</gl-crystal>`
echo "$GLIMMER_BLUE💫 Purging quantum residuals...$QUANTUM_RESET"

if test -d $PLASMOID_PATH
    echo "$STARWEAVE_GOLD🌟 Existing plasmoid directory detected: $PLASMOID_PATH$QUANTUM_RESET"
    echo "$STARWEAVE_GOLD🌟 Would you like to remove the existing plasmoid directory? (y/N)$QUANTUM_RESET"
    read -l confirm
    if test "$confirm" = "y" -o "$confirm" = "Y"
        rm -rf $PLASMOID_PATH
        or begin
            handle_error "Failed to remove existing installation"
            exit 1
        end
    else
        echo "$VOID_RED❌ Quantum disruption: Installation aborted by user$QUANTUM_RESET"
        exit 1
    end
end

# Check if the directory still exists after attempting to remove it
if test -d $PLASMOID_PATH
    handle_error "Plasmoid directory still exists after removal attempt"
    exit 1
end

# `<gl-shimmer color="#50c878,#ffd700">`Create fresh installation directory`</gl-shimmer>`
echo "$GLIMMER_BLUE💫 Initiating clean quantum installation...$QUANTUM_RESET"

mkdir -p $PLASMOID_PATH/{contents/{ui,config},data}
or begin
    handle_error "Failed to create installation directories"
    exit 1
end

# Verify that the directory was created successfully
if not test -d $PLASMOID_PATH
    handle_error "Failed to verify creation of installation directory"
    exit 1
end

# `<gl-crystal color="#4169e1">`Generate metadata`</gl-crystal>`
set -l metadata_file $PLASMOID_PATH/metadata.desktop
echo "$GLIMMER_BLUE💫 Generating Plasma 6 quantum metadata...$QUANTUM_RESET"

printf '%s\n' \
'[Desktop Entry]
Name=STARGUARD Quantum Protection
Comment=✨ A cutting-edge, quantum-powered sentinel for your PC
Type=Service
ServiceTypes=Plasma/Applet
Icon=security-high

X-KDE-PluginInfo-Name=org.kde.starguard
X-KDE-PluginInfo-Category=System Services
X-KDE-PluginInfo-Author=@isdood
X-KDE-PluginInfo-Email=isdood@quantum.guard
X-KDE-PluginInfo-Version=0.13.0
X-KDE-PluginInfo-Website=https://github.com/isdood/STARGUARD
X-KDE-PluginInfo-License=MIT
X-KDE-PluginInfo-EnabledByDefault=true

X-Plasma-API=declarativeappletscript
X-Plasma-MainScript=ui/main.qml
X-Plasma-Provides=org.kde.plasma.systemmonitor

X-Plasma-Framework-Version=6
X-KDE-FormFactors=desktop,tablet,handset
X-Plasma-NotificationAreaCategory=SystemServices
X-KDE-ParentApp=org.kde.plasmashell

X-Plasma-RequiredKF6Dependencies=declarative,plasma-framework
X-Plasma-RequiredQtVersion=6.0' > $metadata_file

# `<gl-crystal color="#4169e1,#50c878">`Generate QML interface`</gl-crystal>`
set -l main_qml $PLASMOID_PATH/contents/ui/main.qml
echo "$GLIMMER_BLUE💫 Generating quantum interface matrix...$QUANTUM_RESET"

printf '%s\n' \
'import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0
import org.kde.kirigami 2.20 as Kirigami

PlasmoidItem {
    id: root

    property var glimmerColors: ["#00ffff", "#ffd700", "#4169e1", "#50c878"]
    property int glimmerIndex: 0
    property bool quantumProtection: true

    Layout.minimumWidth: Kirigami.Units.gridUnit * 12
    Layout.minimumHeight: Kirigami.Units.gridUnit * 12
    Layout.preferredWidth: Kirigami.Units.gridUnit * 14
    Layout.preferredHeight: Kirigami.Units.gridUnit * 14

    Plasmoid.compactRepresentation: PlasmaCore.IconItem {
        source: "security-high"
        active: compactMouse.containsMouse

        MouseArea {
            id: compactMouse
            anchors.fill: parent
            hoverEnabled: true
            onClicked: plasmoid.expanded = !plasmoid.expanded
        }
    }

    Plasmoid.fullRepresentation: Item {
        Layout.minimumWidth: Kirigami.Units.gridUnit * 12
        Layout.minimumHeight: Kirigami.Units.gridUnit * 12

        ColumnLayout {
            anchors.fill: parent
            spacing: Kirigami.Units.smallSpacing

            PlasmaComponents.Label {
                Layout.alignment: Qt.AlignHCenter
                text: "✨ STARGUARD"
                font.pixelSize: theme.defaultFont.pixelSize * 1.5
                font.bold: true
                color: root.glimmerColors[root.glimmerIndex]

                NumberAnimation on color {
                    from: root.glimmerColors[root.glimmerIndex]
                    to: root.glimmerColors[(root.glimmerIndex + 1) % 4]
                    duration: 2000
                    running: true
                    loops: Animation.Infinite
                    onFinished: root.glimmerIndex = (root.glimmerIndex + 1) % 4
                }
            }

            PlasmaComponents.Button {
                Layout.alignment: Qt.AlignHCenter
                text: root.quantumProtection ? "🛡️ Protection Active" : "⚠️ Protection Inactive"
                icon.name: root.quantumProtection ? "security-high" : "security-low"
                onClicked: root.quantumProtection = !root.quantumProtection
            }
        }
    }
}' > $main_qml

# `<gl-shimmer color="#ffd700,#4169e1">`Clear cache and register`</gl-shimmer>`
echo "$GLIMMER_BLUE💫 Registering quantum plasmoid...$QUANTUM_RESET"

# Safe cache clearing
for cache_dir in $USER_HOME/.cache/{plasma,kbuildsycoca6,plasmashell}*
    if test -e $cache_dir
        rm -rf $cache_dir
    end
end

# Force cache rebuild
kbuildsycoca6 --noincremental
sleep 2

# `<gl-crystal color="#4169e1,#50c878">`Ensure clean installation`</gl-crystal>`
if kpackagetool6 -l | grep -q $PLASMOID_NAME
    echo "$GLIMMER_BLUE💫 Updating existing quantum matrix...$QUANTUM_RESET"
    kpackagetool6 -t Plasma/Applet --remove $PLASMOID_NAME
    sleep 1
end

echo "$GLIMMER_BLUE💫 Installing quantum matrix...$QUANTUM_RESET"
if not kpackagetool6 -t Plasma/Applet --install $PLASMOID_PATH
    handle_error "Failed to install quantum plasmoid"
    exit 1
end

# `<gl-shimmer color="#50c878,#00ffff">`Enhanced debug output`</gl-shimmer>`
echo "$QUANTUM_CYAN
╔════════════════════════════════════╗
║     QUANTUM MATRIX STABILIZED      ║
╠════════════════════════════════════╣
║ 🌟 Files: VERIFIED               ║
║ 💫 Cache: PURGED                 ║
║ ✨ Package: REGISTERED           ║
╚════════════════════════════════════╝

💫 Debug Information [$TIMESTAMP]:$QUANTUM_RESET"

printf "%s\n" \
"1. Installation Path: $PLASMOID_PATH" \
"2. Metadata Status: $(test -f $metadata_file && echo "✅" || echo "❌")" \
"3. QML Status: $(test -f $PLASMOID_PATH/contents/ui/main.qml && echo "✅" || echo "❌")" \
"4. Registration: $(kpackagetool6 -l | grep -q $PLASMOID_NAME && echo "✅" || echo "❌")" \
"5. Cache Status: $(test -d "$USER_HOME/.cache/plasma" && echo "🔄 New" || echo "✨ Clean")"

printf "\n%s\n" "$STARWEAVE_GOLD
Would you like to:
1. Restart Plasma
2. View debug logs
3. Exit$QUANTUM_RESET"

read -P "Enter choice (1-3): " choice

switch $choice
    case 1
        echo "$GLIMMER_BLUE💫 Restarting Plasma quantum matrix...$QUANTUM_RESET"
        if pgrep -x "plasmashell" >/dev/null
            killall plasmashell
            sleep 2
        end
        nohup plasmashell --no-respawn >/dev/null 2>&1 &
        disown
        echo "$QUANTUM_CYAN✨ Plasma quantum matrix restarted$QUANTUM_RESET"
    case 2
        echo "$GLIMMER_BLUE💫 Analyzing quantum resonance patterns...$QUANTUM_RESET"
        echo "🔍 Plasmoid Structure:"
        if type -q tree
            tree $PLASMOID_PATH
        else
            ls -R $PLASMOID_PATH
        end
        printf "\n%s\n" "🔍 Installation Status:"
        kpackagetool6 -l | grep -i "starguard" || echo "Package not found in registry"
        printf "\n%s\n" "🔍 Plasma Shell Log:"
        journalctl --user -n 50 -o cat _COMM=plasmashell | grep -i "starguard\|plasmoid" || echo "No relevant logs found"
    case 3
        printf "%s\n" "$QUANTUM_CYAN✨ Quantum matrix harmonized$QUANTUM_RESET"
end
