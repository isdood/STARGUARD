#!/usr/bin/env fish

# `<gl-prism color="#00ffff">`Initialize quantum color matrix`</gl-prism>`
set -l QUANTUM_CYAN (set_color -o cyan)
set -l STARWEAVE_GOLD (set_color -o yellow)
set -l GLIMMER_BLUE (set_color -o blue)
set -l VOID_RED (set_color -o red)
set -l QUANTUM_RESET (set_color normal)

echo $QUANTUM_CYAN"✨ Initiating STARWEAVE quantum harmonization..."$QUANTUM_RESET

# `<gl-crystal color="#ffd700">`Verify Plasma 6 dependencies`</gl-crystal>`
echo $GLIMMER_BLUE"💫 Analyzing Plasma quantum framework..."$QUANTUM_RESET
if command -sq pacman
    # KDE Plasma 6 specific packages
    sudo pacman -S --needed \
        qt6-declarative \
        plasma-framework6 \
        extra-cmake-modules \
        kdeclarative6 \
        plasma-workspace
end

# `<gl-shimmer color="#4169e1">`Safe cache clearing with proper paths`</gl-shimmer>`
for cache_dir in plasma plasmashell plasma_theme ksycoca6 kbuildsycoca6
    set -l cache_path ~/.cache/$cache_dir
    if test -e $cache_path
        echo $GLIMMER_BLUE"💫 Clearing quantum residuals: $cache_path"$QUANTUM_RESET
        rm -rf $cache_path
    end
end

# `<gl-crystal color="#ffd700">`Update plasmoid installation for Plasma 6`</gl-crystal>`
set -l plasmoid_path ~/.local/share/plasma/plasmoids/org.kde.starguard
set -l services_path ~/.local/share/kservices6

echo $STARWEAVE_GOLD"🌟 Realigning quantum installation matrix..."$QUANTUM_RESET

# Ensure proper ownership
chown -R $USER:$USER $plasmoid_path
chmod -R u+rw $plasmoid_path

# Update services directory for Plasma 6
if not test -d $services_path
    mkdir -p $services_path
end

# `<gl-shimmer color="#00ffff">`Create Plasma 6 service entry`</gl-shimmer>`
set -l service_file $services_path/plasma-applet-org.kde.starguard.desktop
ln -sf $plasmoid_path/metadata.desktop $service_file

# `<gl-crystal color="#4169e1">`Reset Plasma quantum state`</gl-crystal>`
echo $STARWEAVE_GOLD"🌟 Would you like to reset the Plasma quantum matrix? (y/N)"$QUANTUM_RESET
read -l confirm
if test "$confirm" = "y" -o "$confirm" = "Y"
    echo $GLIMMER_BLUE"💫 Resetting Plasma quantum state..."$QUANTUM_RESET

    # Plasma 6 specific commands
    if command -sq plasmashell
        killall plasmashell
        sleep 2
        plasmashell --replace &
        disown

        # Force reload of Plasma configuration
        if command -sq kbuildsycoca6
            kbuildsycoca6 --noincremental
        end
    end
end

# `<gl-shimmer color="#ffd700">`Verify quantum installation`</gl-shimmer>`
echo $QUANTUM_CYAN"
╔════════════════════════════════════╗
║     QUANTUM STATE ANALYSIS         ║
╠════════════════════════════════════╣
║ User Matrix:     $USER             ║
║ Plasma Version:  6                 ║
║ Time Signature:  "(date -u +"%Y-%m-%d %H:%M:%S")"║
║ GLIMMER State:   HARMONIZING       ║
║ Cache Status:    PURGED            ║
╚════════════════════════════════════╝"$QUANTUM_RESET

echo $STARWEAVE_GOLD"🌟 Quantum installation steps completed. Please check:"$QUANTUM_RESET
echo $GLIMMER_BLUE"1. Right-click on desktop/panel → Add Widgets"$QUANTUM_RESET
echo $GLIMMER_BLUE"2. If widget doesn't appear, try logging out and back in"$QUANTUM_RESET
echo $GLIMMER_BLUE"3. Check system journal: journalctl -f -n 100 | grep plasma"$QUANTUM_RESET
