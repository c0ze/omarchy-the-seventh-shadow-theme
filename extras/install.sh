#!/usr/bin/env bash
# Optional extras for The Seventh Shadow, after `omarchy theme install`:
#   ~/.config/omarchy/themes/the-seventh-shadow/extras/install.sh [--no-rotation]
#
# What it puts where:
#   branding/*                   -> ~/.config/omarchy/branding/families/seventh-shadow/
#   20-seventh-shadow-branding   -> ~/.config/omarchy/hooks/theme-set.d/ (the crest in About, screensaver, fastfetch
#                                   when this theme is chosen; it stays there after you switch to another theme)
#   rotate/seventh-shadow-bg-next -> ~/.local/bin/
#   rotate/seventh-shadow-bg.{service,timer} -> ~/.config/systemd/user/, timer enabled (next background every ten
#                                   minutes, only while this theme is current and nothing is fullscreen)
set -euo pipefail

here=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cfg="$HOME/.config/omarchy"

for f in about.txt screensaver.txt fastfetch.jsonc; do
  install -D -m 644 "$here/branding/$f" "$cfg/branding/families/seventh-shadow/$f"
done
install -D -m 755 "$here/20-seventh-shadow-branding" "$cfg/hooks/theme-set.d/20-seventh-shadow-branding"

install -D -m 755 "$here/rotate/seventh-shadow-bg-next" "$HOME/.local/bin/seventh-shadow-bg-next"
install -D -m 644 "$here/rotate/seventh-shadow-bg.service" "$HOME/.config/systemd/user/seventh-shadow-bg.service"
install -D -m 644 "$here/rotate/seventh-shadow-bg.timer" "$HOME/.config/systemd/user/seventh-shadow-bg.timer"
systemctl --user daemon-reload
if [[ ${1:-} == --no-rotation ]]; then
  systemctl --user disable --now seventh-shadow-bg.timer >/dev/null 2>&1 || true
  echo "rotation: off"
else
  systemctl --user enable --now seventh-shadow-bg.timer >/dev/null
  echo "rotation: every ten minutes while the theme is current"
fi

if [[ $(cat "$HOME/.local/state/omarchy/current/theme.name" 2>/dev/null) == the-seventh-shadow ]]; then
  "$cfg/hooks/theme-set.d/20-seventh-shadow-branding" the-seventh-shadow
  echo "crest: in place"
else
  echo "crest: appears when you choose the theme"
fi
