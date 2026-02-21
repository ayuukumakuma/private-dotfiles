# nix-darwin + home-manager (ayuu-mac)

このリポジトリは macOS 環境を `flake` で宣言的に管理します。
Nix 本体は Determinate 側で管理し、`nix-darwin` では `nix.enable = false` にしています。

## 構成

- `flake.nix`: エントリポイント（`darwinConfigurations.ayuu-mac`）
- `host.nix`: この端末向けのホスト固有設定
- `modules/darwin/base.nix`: 共通の nix-darwin 設定
- `modules/darwin/homebrew.nix`: Homebrew 管理
- `modules/home-manager/base.nix`: 共通 Home Manager 設定
- `homes/ayuu/default.nix`: ユーザー固有設定
- `scripts/*.sh`: 運用スクリプト

## 初回セットアップ

```bash
cd ~/dev/nix
./scripts/bootstrap.sh
```

## 日常運用

```bash
cd ~/dev/nix
./scripts/switch.sh
```

```bash
cd ~/dev/nix
./scripts/update.sh
```

```bash
cd ~/dev/nix
./scripts/doctor.sh
```

## 直接コマンド

```bash
cd ~/dev/nix
nix flake check

darwin-rebuild build --flake .#ayuu-mac
darwin-rebuild switch --flake .#ayuu-mac
```

## Determinate 利用時の注意

- `nix-darwin` の `nix.*` オプション（`nix.settings` など）は利用しません。
- Nix 本体の挙動変更は Determinate/Nix 側の設定で行ってください。
