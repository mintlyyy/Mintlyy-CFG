#!/usr/bin/env bash
# ============================================================================
#  mintlyy-cfg v3 — instalador (Linux / macOS)
#  Uso:  ./install.sh               (descobre o TF2 sozinho)
#        ./install.sh "/caminho/Team Fortress 2"
#  Copia cfg/overrides/* para  <TF2>/tf/cfg/overrides/
# ============================================================================
set -u

SRC="$(cd "$(dirname "$0")" && pwd)/cfg/overrides"

candidatos=(
  "$HOME/.steam/steam/steamapps/common/Team Fortress 2"
  "$HOME/.steam/debian-installation/steamapps/common/Team Fortress 2"
  "$HOME/.local/share/Steam/steamapps/common/Team Fortress 2"
  "$HOME/.var/app/com.valvesoftware.Steam/.local/share/Steam/steamapps/common/Team Fortress 2"
  "$HOME/Library/Application Support/Steam/steamapps/common/Team Fortress 2"
  "/usr/local/games/Team Fortress 2"
)

TF2="${1:-}"
if [ -z "$TF2" ]; then
  for c in "${candidatos[@]}"; do
    if [ -d "$c/tf/cfg" ]; then TF2="$c"; break; fi
  done
fi

if [ -z "$TF2" ]; then
  echo "Não achei o Team Fortress 2 automaticamente."
  printf 'Cole o caminho da pasta "Team Fortress 2": '
  read -r TF2
fi

if [ ! -d "$TF2/tf/cfg" ]; then
  echo "ERRO: não existe '$TF2/tf/cfg'. Confira o caminho." >&2
  exit 1
fi

echo "TF2: $TF2"

if ! ls "$TF2/tf/custom/"mastercomfig*.vpk >/dev/null 2>&1; then
  echo
  echo "AVISO: não achei mastercomfig*.vpk em tf/custom."
  echo "       Esta config depende do mastercomfig — baixe em https://comfig.app/app"
  echo "       (preset LOW, ideal pro i5-3470/GT 630) e extraia em tf/custom."
  echo
fi

DEST="$TF2/tf/cfg/overrides"

# Backup do que já existe
if ls "$DEST"/*.cfg >/dev/null 2>&1; then
  BAK="$TF2/tf/cfg/overrides_backup_$(date +%Y%m%d_%H%M)"
  echo "Backup do overrides atual em: $BAK"
  mkdir -p "$BAK" && cp -a "$DEST"/. "$BAK"/
fi

mkdir -p "$DEST"
cp -a "$SRC"/. "$DEST"/

echo
echo "============================================================"
echo "  PRONTO! Arquivos copiados para:"
echo "  $DEST"
echo "============================================================"
echo '  No jogo, abra o console (~) e confira:'
echo '    - "mintlyy-cfg v3" na inicialização'
echo '    - preset_level   (deve dizer preset=low/medium, NÃO custom)'
echo '    - module_levels  (confere os módulos da v3)'
echo '  Alterou algo? Rode:  apply_overrides'
echo "============================================================"
