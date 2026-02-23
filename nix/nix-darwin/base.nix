{
  lib,
  pkgs,
  username,
  ...
}:

{
  # Nix installation/daemon is managed outside nix-darwin (via nix-installer).
  nix.enable = false;

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
    ];

  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.fish;
  };

  # Required when login shell is fish; nix-darwin asserts this and configures fish paths/shell registration.
  programs.fish.enable = true;

  fonts.packages = with pkgs; [
    hackgen-nf-font
  ];

  security.pam.services.sudo_local.touchIdAuth = true;

  power = {
    sleep = {
      display = 120;
    };
  };

  system = {
    stateVersion = 6;
    primaryUser = username;

    defaults = {
      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        CreateDesktop = false;
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "Nlsv";
        NewWindowTarget = "Home";
        ShowExternalHardDrivesOnDesktop = false;
        ShowPathbar = true;
        ShowRemovableMediaOnDesktop = false;
        ShowStatusBar = true;
        _FXEnableColumnAutoSizing = true;
        _FXShowPosixPathInTitle = true;
      };

      NSGlobalDomain = {
        AppleICUForce24HourTime = true;
        AppleInterfaceStyle = "Dark";
        ApplePressAndHoldEnabled = false;
        AppleScrollerPagingBehavior = true;
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        "com.apple.mouse.tapBehavior" = 1;
      };

      SoftwareUpdate = {
        AutomaticallyInstallMacOSUpdates = true;
      };

      WindowManager = {
        AutoHide = true;
        StandardHideDesktopIcons = true;
        StandardHideWidgets = true;
      };

      controlcenter = {
        AirDrop = true;
        BatteryShowPercentage = true;
        FocusModes = false;
        NowPlaying = false;
        Sound = false;
      };

      dock = {
        autohide = true;
        largesize = 64;
        magnification = true;
        mru-spaces = false;
        orientation = "left";
        persistent-apps = [
          {
            app = "/System/Applications/App Store.app";
          }
          {
            app = "/System/Applications/System Settings.app";
          }
          {
            app = "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app";
          }
          {
            app = "/System/Volumes/Data/Users/ayuu/Applications/Home Manager Apps/Zed.app";
          }
          {
            app = "/System/Volumes/Data/Applications/Ghostty.app";
          }
        ];
        show-recents = false;
        showAppExposeGestureEnabled = true;
        showDesktopGestureEnabled = true;
        showLaunchpadGestureEnabled = true;
        showMissionControlGestureEnabled = true;
        showhidden = true;
        tilesize = 32;
        wvous-bl-corner = 2;
        wvous-br-corner = 3;
        wvous-tl-corner = 4;
        wvous-tr-corner = 2;
      };

      loginwindow = {
        GuestEnabled = false;
      };

      menuExtraClock = {
        ShowDate = 0;
        ShowSeconds = true;
      };

      trackpad = {
        Clicking = true;
        Dragging = true;
        TrackpadFourFingerHorizSwipeGesture = 2;
        TrackpadFourFingerPinchGesture = 2;
        TrackpadFourFingerVertSwipeGesture = 2;
        TrackpadPinch = true;
        TrackpadRightClick = true;
        TrackpadThreeFingerTapGesture = 0;
        TrackpadThreeFingerVertSwipeGesture = 2;
        TrackpadTwoFingerDoubleTapGesture = true;
        TrackpadTwoFingerFromRightEdgeSwipeGesture = 3;
      };

      universalaccess = {
        mouseDriverCursorSize = 2.0;
      };
    };
  };
}
