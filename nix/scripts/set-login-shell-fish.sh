#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: ./scripts/set-login-shell-fish.sh [--dry-run]

fish をログインシェルに設定します。
- fish の実行パスを検出
- /etc/shells に fish パスを登録（必要時）
- chsh でログインシェルを fish に変更

Options:
  --dry-run   実際の変更を行わず、実行予定のコマンドだけ表示します
EOF
}

dry_run=false
if [[ "${1:-}" == "--dry-run" ]]; then
  dry_run=true
  shift
fi

if [[ $# -gt 0 ]]; then
  usage
  exit 1
fi

if [[ -x /run/current-system/sw/bin/fish ]]; then
  fish_shell="/run/current-system/sw/bin/fish"
elif command -v fish >/dev/null 2>&1; then
  fish_shell="$(command -v fish)"
else
  echo "fish が見つかりません。先に fish をインストールしてください。"
  exit 1
fi

if [[ ! -x "${fish_shell}" ]]; then
  echo "fish 実行ファイルが存在しません: ${fish_shell}"
  exit 1
fi

echo "使用する fish: ${fish_shell}"

if grep -Fqx "${fish_shell}" /etc/shells; then
  echo "/etc/shells への登録: 済み"
else
  echo "/etc/shells への登録: 未登録 -> 追加します"
  if [[ "${dry_run}" == true ]]; then
    echo "[dry-run] printf '%s\\n' '${fish_shell}' | sudo tee -a /etc/shells >/dev/null"
  else
    printf '%s\n' "${fish_shell}" | sudo tee -a /etc/shells >/dev/null
  fi
fi

current_login_shell=""

if [[ "${OSTYPE:-}" == darwin* ]] && command -v dscl >/dev/null 2>&1; then
  if dscl_output="$(dscl . -read "/Users/${USER}" UserShell 2>/dev/null)"; then
    current_login_shell="${dscl_output#UserShell: }"
  fi
fi

if [[ -z "${current_login_shell}" ]]; then
  if command -v getent >/dev/null 2>&1; then
    current_login_shell="$(getent passwd "${USER}" | cut -d: -f7)"
  else
    current_login_shell="${SHELL:-}"
  fi
fi

echo "現在のログインシェル: ${current_login_shell:-unknown}"

if [[ "${current_login_shell}" == "${fish_shell}" ]]; then
  echo "ログインシェルはすでに fish です。"
else
  if [[ "${dry_run}" == true ]]; then
    echo "[dry-run] chsh -s '${fish_shell}' '${USER}'"
  else
    chsh -s "${fish_shell}" "${USER}"
  fi
fi

echo "完了。新しいターミナルを開いて 'echo \$SHELL' で確認してください。"
