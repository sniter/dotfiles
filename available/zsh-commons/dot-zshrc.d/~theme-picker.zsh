# FZF THEMES
export FZF_CATPPUCCIN_LATTE=" \
    --color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
    --color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
    --color=marker:#7287fd,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39 \
    --color=selected-bg:#bcc0cc \
    --color=border:#ccd0da,label:#4c4f69"

export FZF_CATPPUCCIN_MOCHA=" \
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
    --color=selected-bg:#45475a \
    --color=border:#313244,label:#cdd6f4"

# Weather cache setup
WEATHER_CACHE_FILE="/tmp/weather_cache.txt"
WEATHER_CACHE_EXPIRY=10800  # 3 hours in seconds

# Function to get weather with caching
get_weather() {
    # Check if cache exists and is not expired
    if [ -f "$WEATHER_CACHE_FILE" ]; then
        cache_age=$(($(date +%s) - $(stat -f %m "$WEATHER_CACHE_FILE")))
        if [ $cache_age -lt $WEATHER_CACHE_EXPIRY ]; then
            cat "$WEATHER_CACHE_FILE"
            return
        fi
    fi
    
    # If no cache or expired, fetch new weather
    weather=$(curl -s "wttr.in/?format=%c" | tr -d '[:space:]')
    echo "$weather" > "$WEATHER_CACHE_FILE"
    echo "$weather"
}

detect_theme_by_weather_and_time() {
    # Set theme based on weather and time
    current_hour=$(date +%H)
    weather=$(get_weather)

    if [ "$weather" = "☀️" ]; then
        # Only check time if it's sunny
        if [ $current_hour -ge 9 ] && [ $current_hour -lt 18 ]; then
            export DOTTHEME="catppuccinlatte"
        else
            export DOTTHEME="catppuccinmocha"
        fi
    else
        # If not sunny, always use dark theme
        export DOTTHEME="catppuccinmocha"
    fi
}

detect_by_lmu_censor() {
    # Get ambient light sensor value and normalize it (0-1 range)
    local sensor_value=$(ioreg -r -c AppleCLCD2 | grep AmbientBrightness | grep -v 65536 | awk '{print $4/1000/65536}')
    
    # If sensor value is high (bright environment), use light theme
    # Using 0.5 as threshold (half of max brightness)
    if (( $(echo "$sensor_value > 0.9" | bc -l) )); then
        export DOTTHEME="catppuccinlatte"
    else
        export DOTTHEME="catppuccinmocha"
    fi
}

# Choose which detection method to use
# detect_theme_by_weather_and_time
# Uncomment the line below to use ambient light sensor instead
detect_by_lmu_censor

#
# THEME
#
function catppuccinlatte(){
  export BAT_THEME="Catppuccin Latte"
  export FZF_DEFAULT_OPTS="$FZF_CATPPUCCIN_LATTE --multi"
  alias lgit=lazygit --use-config-file="~/.config/lazygit/config.yml,~/.config/lazygit/themes/catppuccin-latte.yml"
  # TMUX
  # echo "set -g @catppuccin_flavor 'latte'"                             >  ~/.tmux.theme.conf
  # echo "refresh-client -S"                                             >> ~/.tmux.theme.conf
  # tmux source-file ~/.tmux.conf
  # Ghostty
  # echo 'theme = "catppuccin-latte"'                                    >  ~/.config/ghostty/theme.config
  # Alacritty
  # echo "[general]"                                                     >  ~/.config/alacritty/theme.toml
  # echo 'import = ["~/.config/alacritty/themes/catppuccin-latte.toml"]' >> ~/.config/alacritty/theme.toml
}

function catppuccinmocha(){
  export BAT_THEME="Catppuccin Mocha"
  export FZF_DEFAULT_OPTS="$FZF_CATPPUCCIN_MOCHA --multi"
  alias lgit=lazygit --use-config-file="~/.config/lazygit/config.yml,~/.config/lazygit/themes/catppuccin-mocha.yml"
  # TMUX
  # echo "set -g @catppuccin_flavor 'mocha'"                             >  ~/.tmux.theme.conf
  # echo "refresh-client -S"                                             >> ~/.tmux.theme.conf
  # tmux source-file ~/.tmux.conf
  # Ghostty
  # echo 'theme = "catppuccin-mocha"'                                    >  ~/.config/ghostty/theme.config
  # Alacritty
  # echo "[general]"                                                     >  ~/.config/alacritty/theme.toml
  # echo 'import = ["~/.config/alacritty/themes/catppuccin-mocha.toml"]' >> ~/.config/alacritty/theme.toml
}

case "$DOTTHEME" in 
  catppuccinlatte)  catppuccinlatte ;;
  *)                catppuccinmocha ;;
esac
