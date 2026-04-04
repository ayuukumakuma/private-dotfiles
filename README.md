# private-dotfiles

macOS 向けの個人用 dotfiles / 開発環境設定リポジトリです。
宣言的な環境管理の中核は `nix/` にあり、詳細な手順は [`nix/README.md`](./nix/README.md) に集約しています。

## 構成

- `nix/`: nix-darwin + home-manager による環境定義と運用スクリプト
- `codex/`: Codex CLI の設定
- `ghostty/`: Ghostty の設定
- `zed/`: Zed の設定
- `locals/`: 端末・アカウント固有のローカル設定テンプレート
- `agents/`: Codex Skills 定義

## セットアップ導線

環境構築・更新・診断の手順は [`nix/README.md`](./nix/README.md) を参照してください。
初回セットアップは `nix/scripts/bootstrap.sh` を利用します。

## ローカル設定

`locals/git/config.local.example` を元に、`name` / `email` / `signingkey` を自分の値に置き換えて利用してください。

## 管理ポリシー

- 個人情報・秘密鍵・トークンなどの機密情報はコミットしない
- 端末固有や個人固有の値は `locals/` 側で管理する
