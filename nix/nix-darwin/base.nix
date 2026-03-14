{
  lib,
  pkgs,
  username,
  ...
}:

{
  # Nix のインストール/デーモン管理は nix-darwin 外部（nix-installer）で行う。
  nix.enable = false;

  # ホストプラットフォームを Apple Silicon 向け macOS に固定する。
  nixpkgs.hostPlatform = "aarch64-darwin";
  # 許可する unfree パッケージを明示的に制限する。
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      # チャットアプリ Discord を unfree 許可リストに含める。
      "discord"
    ];

  # 対象ユーザーの macOS アカウント設定を宣言する。
  users.users.${username} = {
    # ユーザーのホームディレクトリを指定する。
    home = "/Users/${username}";
    # ログインシェルとして fish を利用する。
    shell = pkgs.fish;
  };

  # fish を有効化し、パス設定やシェル登録を nix-darwin に任せる。
  programs.fish.enable = true;

  # インストールするフォント群を指定する。
  fonts.packages = with pkgs; [
    # HackGen Nerd Font を導入する。
    hackgen-nf-font
    # SketchyBar のアプリアイコンフォントを導入する。
    sketchybar-app-font
  ];

  # sudo 実行時の Touch ID 認証を有効にする。
  security.pam.services.sudo_local.touchIdAuth = true;

  # 電源管理の基本設定。
  power = {
    sleep = {
      # ディスプレイを 120 分でスリープさせる（`"never"` または正の整数）。
      display = 120;
    };
  };

  # システム全体の設定。
  system = {
    # nix-darwin の状態バージョン（移行互換の基準）。
    stateVersion = 6;
    # プライマリユーザーを引数のユーザー名に設定する。
    primaryUser = username;

    # macOS の defaults（`defaults write` 相当）を管理する。
    defaults = {
      finder = {
        # すべてのファイル拡張子を表示する。
        AppleShowAllExtensions = true;
        # 隠しファイルを表示する。
        AppleShowAllFiles = true;
        # デスクトップアイコンを表示しない。
        CreateDesktop = false;
        # 拡張子変更時の警告を表示しない。
        FXEnableExtensionChangeWarning = false;
        # Finder の初期表示をリスト表示にする（`"icnv" | "Nlsv" | "clmv" | "Flwv"`）。
        FXPreferredViewStyle = "Nlsv";
        # 新規ウィンドウの表示先をホームにする（`"Computer" | "OS volume" | "Home" | ...`）。
        NewWindowTarget = "Home";
        # 外付け HDD をデスクトップに表示しない。
        ShowExternalHardDrivesOnDesktop = false;
        # パスバーを表示する。
        ShowPathbar = true;
        # リムーバブルメディアをデスクトップに表示しない。
        ShowRemovableMediaOnDesktop = false;
        # ステータスバーを表示する。
        ShowStatusBar = true;
        # カラム表示時の列幅自動調整を有効にする。
        _FXEnableColumnAutoSizing = true;
        # Finder タイトルに POSIX パスを表示する。
        _FXShowPosixPathInTitle = true;
      };

      NSGlobalDomain = {
        # 時刻表示を 24 時間制にする。
        AppleICUForce24HourTime = true;
        # 外観モードをライトにする（`null` でライト、`"Dark"` でダーク）。
        AppleInterfaceStyle = null;
        # キー長押し時のアクセントメニューを無効化する。
        ApplePressAndHoldEnabled = false;
        # スクロールで 1 ページ単位移動を有効にする。
        AppleScrollerPagingBehavior = true;
        # 拡張子を常に表示する。
        AppleShowAllExtensions = true;
        # 隠しファイルを表示する。
        AppleShowAllFiles = true;
        # メニューバーを自動的に隠す。
        _HIHideMenuBar = true;
        # キーリピート開始までの遅延を設定する。
        InitialKeyRepeat = 15;
        # キーリピート速度を設定する。
        KeyRepeat = 2;
        # 自動大文字化を無効にする。
        NSAutomaticCapitalizationEnabled = false;
        # 自動スペル修正を無効にする。
        NSAutomaticSpellingCorrectionEnabled = false;
        # タップでクリック（マウス設定）を有効にする。
        "com.apple.mouse.tapBehavior" = 1;
      };

      SoftwareUpdate = {
        # macOS アップデートの自動インストールを有効にする。
        AutomaticallyInstallMacOSUpdates = true;
      };

      WindowManager = {
        # ステージマネージャの最近使用アプリ表示（ステージストリップ）を自動で隠す（true/false）。
        AutoHide = true;
        # ステージマネージャ利用時にデスクトップアイコンを隠す。
        StandardHideDesktopIcons = true;
        # ステージマネージャ利用時にウィジェットを隠す。
        StandardHideWidgets = true;
      };

      controlcenter = {
        # メニューバーに AirDrop コントロールを表示する（true/false）。
        AirDrop = true;
        # バッテリー残量のパーセント表示を無効にする（true/false）。
        BatteryShowPercentage = false;
        # メニューバーの集中モードコントロールを表示しない。
        FocusModes = false;
        # メニューバーの再生中メディアコントロールを表示しない。
        NowPlaying = false;
        # メニューバーのサウンドコントロールを表示しない。
        Sound = false;
      };

      dock = {
        # Dock を自動的に隠す。
        autohide = true;
        # Mission Control の Expose でウィンドウをアプリケーションごとにグループ化する。
        expose-group-apps = true;
        # 拡大時の最大アイコンサイズを設定する。
        largesize = 64;
        # Dock アイコンの拡大表示を有効にする。
        magnification = true;
        # 使用頻度順 Spaces の自動並べ替えを無効にする。
        mru-spaces = false;
        # Dock の表示位置を左にする（`"bottom" | "left" | "right"`）。
        orientation = "bottom";
        # Dock に固定表示するアプリ一覧。
        persistent-apps = [
          {
            # App Store を Dock に固定する。
            app = "/System/Applications/App Store.app";
          }
          {
            # システム設定を Dock に固定する。
            app = "/System/Applications/System Settings.app";
          }
          {
            # Safari を Dock に固定する。
            app = "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app";
          }
          {
            # Home Manager 経由の Zed を Dock に固定する。
            app = "/System/Volumes/Data/Users/ayuu/Applications/Home Manager Apps/Zed.app";
          }
          {
            # Ghostty を Dock に固定する。
            app = "/System/Volumes/Data/Applications/Ghostty.app";
          }
        ];
        # 最近使ったアプリ表示を無効にする。
        show-recents = false;
        # App Expose ジェスチャを有効にする。
        showAppExposeGestureEnabled = true;
        # デスクトップ表示ジェスチャを有効にする。
        showDesktopGestureEnabled = true;
        # Launchpad 表示ジェスチャを有効にする。
        showLaunchpadGestureEnabled = true;
        # Mission Control ジェスチャを有効にする。
        showMissionControlGestureEnabled = true;
        # 非表示アプリのアイコンを半透明で表示する。
        showhidden = true;
        # 通常時の Dock アイコンサイズを設定する。
        tilesize = 32;
        # 左下ホットコーナーを Mission Control に設定する（例: `1`無効, `2`Mission Control, `4`Desktop）。
        wvous-bl-corner = 2;
        # 右下ホットコーナーをアプリケーションウィンドウ表示に設定する（例: `3`Application Windows）。
        wvous-br-corner = 3;
        # 左上ホットコーナーをデスクトップ表示に設定する（例: `4`Desktop）。
        wvous-tl-corner = 4;
        # 右上ホットコーナーを Mission Control に設定する（例: `2`Mission Control）。
        wvous-tr-corner = 2;
      };

      loginwindow = {
        # ゲストユーザーを無効にする。
        GuestEnabled = false;
      };

      menuExtraClock = {
        # メニューバー時計の日付表示（`0`余裕時, `1`常時, `2`非表示）。
        ShowDate = 0;
        # メニューバー時計で秒を表示する。
        ShowSeconds = true;
      };

      trackpad = {
        # タップでクリックを有効にする。
        Clicking = true;
        # ドラッグ操作を有効にする。
        Dragging = true;
        # 4 本指の左右スワイプを有効にする（`0`無効, `2`フルスクリーン間移動）。
        TrackpadFourFingerHorizSwipeGesture = 0;
        # 4 本指ピンチジェスチャを有効にする（`0`無効, `2`有効）。
        TrackpadFourFingerPinchGesture = 0;
        # 4 本指の上下スワイプを有効にする（`0`無効, `2`有効）。
        TrackpadFourFingerVertSwipeGesture = 0;
        # ピンチでズームを有効にする。
        TrackpadPinch = true;
        # 2 本指クリック（右クリック）を有効にする。
        TrackpadRightClick = true;
        # 3 本指タップジェスチャを無効にする（`0`無効, `2`Look up）。
        TrackpadThreeFingerTapGesture = 0;
        # 3 本指の上下スワイプを有効にする（`0`無効, `2`有効）。
        TrackpadThreeFingerVertSwipeGesture = 2;
        # 2 本指ダブルタップジェスチャを有効にする。
        TrackpadTwoFingerDoubleTapGesture = true;
        # 右端からの 2 本指スワイプ（通知センター）を有効にする（`0`無効, `3`通知センター）。
        TrackpadTwoFingerFromRightEdgeSwipeGesture = 3;
      };

      # `com.apple.universalaccess` への defaults 書き込みが失敗して
      # switch 全体が中断されることがあるため、カーソルサイズは GUI 側で管理する。
    };
  };
}
