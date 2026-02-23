# nix-darwin + home-manager (ayuu-mac)

このリポジトリは macOS 環境を `flake` で宣言的に管理します。
Nix 本体は `NixOS/nix-installer` で導入し、`nix-darwin` では `nix.enable = false` にしています。

## 構成

- `flake.nix`: エントリポイント（`darwinConfigurations.ayuu-mac`）
- `host.nix`: この端末向けのホスト固有設定
- `nix-darwin/base.nix`: 共通の nix-darwin 設定
- `nix-darwin/homebrew.nix`: Homebrew 管理
- `home-manager/base.nix`: 共通 Home Manager 設定
- `homes/ayuu/default.nix`: ユーザー固有設定
- `scripts/*.sh`: 運用スクリプト

## 運用スクリプトの役割

- `scripts/bootstrap.sh`: Nix 未導入なら `nix-installer` で導入し、`darwin-rebuild switch` を実行
- `scripts/switch.sh`: 現在の `flake` 構成を `switch` で反映
- `scripts/update.sh`: `flake` 更新、`flake check`、`darwin build`、`switch` を順に実行
- `scripts/doctor.sh`: `nix doctor`、`flake metadata`、`flake check`、`darwin build` で診断
- `scripts/set-login-shell-fish.sh`: ログインシェルを fish に設定（`/etc/shells` 登録 + `chsh`）

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

```bash
cd ~/dev/nix
./scripts/set-login-shell-fish.sh --dry-run
./scripts/set-login-shell-fish.sh
```

## 直接コマンド

```bash
cd ~/dev/nix
nix flake check

darwin-rebuild build --flake .#ayuu-mac
darwin-rebuild switch --flake .#ayuu-mac
```

## nix-installer 利用時の注意

- `nix-darwin` の `nix.*` オプション（`nix.settings` など）はこのリポジトリでは利用しません。
- Nix 本体の導入や再導入の方針は `nix-installer` 側の手順で管理してください。
- `bootstrap.sh` は公式ワンライナー `curl -sSfL https://artifacts.nixos.org/nix-installer | sh -s -- install` を内部で利用します。
