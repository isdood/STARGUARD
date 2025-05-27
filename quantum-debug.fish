#!/usr/bin/env fish

# `<gl-prism color="#00ffff">`Initialize STARWEAVE quantum colors`</gl-prism>`
set -l QUANTUM_CYAN (set_color -o cyan)
set -l STARWEAVE_GOLD (set_color -o yellow)
set -l GLIMMER_BLUE (set_color -o blue)
set -l VOID_RED (set_color -o red)
set -l QUANTUM_RESET (set_color normal)

# `<gl-crystal color="#4169e1">`Create debug log directory`</gl-crystal>`
set -l debug_dir ~/.config/starguard/debug
set -l debug_file $debug_dir/quantum-debug-(date +%Y%m%d_%H%M%S).log
mkdir -p $debug_dir

echo $QUANTUM_CYAN"✨ Initializing STARWEAVE quantum diagnostics..."$QUANTUM_RESET | tee $debug_file

# `<gl-shimmer color="#ffd700">`System Information`</gl-shimmer>`
echo "
╔════════════════════════════════════╗
║     QUANTUM SYSTEM ANALYSIS        ║
╠════════════════════════════════════╣" | tee -a $debug_file

# Check KDE Plasma version and packages
echo "💫 KDE Plasma Environment:" | tee -a $debug_file
plasmashell --version 2>&1 | tee -a $debug_file
pacman -Qi plasma-workspace plasma-framework qt6-declarative 2>&1 | tee -a $debug_file

# `<gl-crystal color="#4169e1">`Verify plasmoid installation`</gl-crystal>`
echo "
🌟 Plasmoid Quantum State:" | tee -a $debug_file
set -l plasmoid_path ~/.local/share/plasma/plasmoids/org.kde.starguard

# Check plasmoid files
for file in metadata.desktop contents/ui/main.qml contents/config/config.qml
    set -l full_path $plasmoid_path/$file
    if test -f $full_path
        echo "✨ $file: PRESENT" | tee -a $debug_file
        echo "   SHA256: "(sha256sum $full_path | cut -d' ' -f1) | tee -a $debug_file
        echo "   Permissions: "(stat -c "%A %U:%G" $full_path) | tee -a $debug_file
    else
        echo $VOID_RED"❌ $file: MISSING"$QUANTUM_RESET | tee -a $debug_file
    end
end

# `<gl-shimmer color="#00ffff">`Check service registration`</gl-shimmer>`
echo "
💫 Service Registration:" | tee -a $debug_file
for service_dir in ~/.local/share/kservices{5,6}
    if test -d $service_dir
        echo "✨ Checking $service_dir:" | tee -a $debug_file
        find $service_dir -type f -name "*starguard*.desktop" -exec cat {} \; 2>&1 | tee -a $debug_file
    end
end

# `<gl-prism color="#ffd700">`Check Plasma logs`</gl-prism>`
echo "
🌟 Recent Plasma Events:" | tee -a $debug_file
journalctl -b -n 100 | grep -i "plasma\|plasmoid\|starguard" 2>&1 | tee -a $debug_file

# `<gl-crystal color="#4169e1">`Generate quantum recovery suggestions`</gl-crystal>`
echo "
╔════════════════════════════════════╗
║     QUANTUM RECOVERY MATRIX        ║
╠════════════════════════════════════╣
║ 1. Missing Framework Files:        ║
║    → Install plasma-framework6     ║
║    → Install kdeclarative6        ║
║                                   ║
║ 2. Service Registration:          ║
║    → Update desktop database      ║
║    → Rebuild Plasma cache         ║
║                                   ║
║ 3. Permission Matrix:             ║
║    → Reset plasmoid ownership     ║
║    → Verify service paths         ║
╚════════════════════════════════════╝" | tee -a $debug_file

echo $STARWEAVE_GOLD"
✨ Debug log generated: $debug_file
💫 Would you like to attempt quantum recovery? (y/N)"$QUANTUM_RESET

read -l confirm
if test "$confirm" = "y" -o "$confirm" = "Y"
    echo $GLIMMER_BLUE"🌟 Initiating quantum recovery sequence..."$QUANTUM_RESET

    # Install missing packages from AUR if needed
    if command -sq yay
        echo "💫 Attempting to install Plasma 6 frameworks from AUR..."
        yay -S plasma-framework6-git kdeclarative6-git
    end

    # Force reload desktop database
    echo "✨ Updating desktop database..."
    update-desktop-database ~/.local/share/applications

    # Rebuild Plasma cache
    echo "🌟 Rebuilding Plasma quantum cache..."
    kbuildsycoca6 --noincremental

    # Reset plasmoid permissions
    echo "💫 Realigning quantum permissions..."
    chown -R $USER:$USER $plasmoid_path
    chmod -R u+rw $plasmoid_path
end
