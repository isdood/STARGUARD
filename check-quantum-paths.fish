#!/usr/bin/env fish

set -l QUANTUM_CYAN (set_color -o cyan)
set -l STARWEAVE_GOLD (set_color -o yellow)
set -l GLIMMER_BLUE (set_color -o blue)
set -l VOID_RED (set_color -o red)
set -l QUANTUM_RESET (set_color normal)

echo $QUANTUM_CYAN"✨ Initiating quantum path verification..."$QUANTUM_RESET

# Check ownership
echo $GLIMMER_BLUE"💫 Verifying quantum permissions..."$QUANTUM_RESET
set -l plasmoid_path ~/.local/share/plasma/plasmoids/org.kde.starguard
ls -la $plasmoid_path

# Verify QML installation
echo $STARWEAVE_GOLD"🌟 Analyzing GLIMMER interface matrix..."$QUANTUM_RESET
if test -f $plasmoid_path/contents/ui/main.qml
    echo $QUANTUM_CYAN"✨ QML interface detected"$QUANTUM_RESET
else
    echo $VOID_RED"❌ QML interface missing"$QUANTUM_RESET
end
