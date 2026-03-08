---
title: "Setup | SketchyBar"
source_url: "https://felixkratz.github.io/SketchyBar/setup"
fetched_at: "2026-03-08T06:45:16.308494+00:00"
---



* Setup

On this page

## Installation[​](https://felixkratz.github.io/SketchyBar/setup.html#installation "Direct link to heading")

### Prerequisite[​](https://felixkratz.github.io/SketchyBar/setup.html#prerequisite "Direct link to heading")

SketchyBar will only work properly with the system setting "Displays have
separate Spaces" turned on (the default setting). The option is located
in *System Settings* -> *Desktop & Dock* -> *Displays have separate Spaces*.

### Brew Install[​](https://felixkratz.github.io/SketchyBar/setup.html#brew-install "Direct link to heading")

```
brew tap FelixKratz/formulae
brew install sketchybar
```

Copy the example configuration and make it executable:

```
mkdir -p ~/.config/sketchybar/plugins
cp $(brew --prefix)/share/sketchybar/examples/sketchybarrc ~/.config/sketchybar/sketchybarrc
cp -r $(brew --prefix)/share/sketchybar/examples/plugins/ ~/.config/sketchybar/plugins/
```

The default configuration is intentionally sparse, so if you are looking for something more sophisticated as a starting point, you might want to look at
[this discussion](https://github.com/FelixKratz/SketchyBar/discussions/47).

Run the bar automatically at startup:

```
brew services start sketchybar
```

or in the command line with verbose output:

```
sketchybar
```

It is possible to run sketchybar with a custom config file path (i.e. something
else than `$HOME/.config/sketchybar/sketchybarrc`) via:

```
sketchybar --config <path>
```

### Fonts[​](https://felixkratz.github.io/SketchyBar/setup.html#fonts "Direct link to heading")

The default sketchybar font is the Hack Nerd Font:

```
brew install --cask font-hack-nerd-font
```

if you experience missing icons you might need to install it. Any font
of your liking can be used in sketchybar.

If you want to load fonts from a non standard directory, you can use

```
sketchybar --load-font <path>
```

to load a font file from any `<path>`.

### Plugins[​](https://felixkratz.github.io/SketchyBar/setup.html#plugins "Direct link to heading")

When you use/create additional plugins, make sure that they are made executable via

```
chmod +x name/of/plugin.sh
```

If you run sketchybar from the command line directly with the command `sketchybar` you will see
all outputs and error messages from your scripts.

The default plugin folder is located in `~/.config/sketchybar/plugins`.
Plugins need to be referenced with absolute paths because relative paths will not be resolved correctly.
Have a look at the [discussion](https://github.com/FelixKratz/SketchyBar/discussions/12) for plugins and share your own if you want to.
You should of course vet the code from all plugins before executing them to make sure they are not harming your computer.

### Hiding the original macOS bar[​](https://felixkratz.github.io/SketchyBar/setup.html#hiding-the-original-macos-bar "Direct link to heading")

* (Pre macOS Ventura) Hide the default macOS menu bar in *System Preferences* -> *Dock & Menu Bar*:
  ![hide_macOS_bar](https://felixkratz.github.io/SketchyBar/assets/images/hide_menubar-dda81922d34dda138a2e5f03cfcdc645.png)
* (macOS Ventura) Hide the default macOS menu bar in *System Settings* -> *Desktop & Dock* -> *Automatically hide and show the menu bar* -> *Always*:
  ![hide_macOS_bar_ventura](https://felixkratz.github.io/SketchyBar/assets/images/hide_macos_bar_ventura-882e31573dbddc4e65e1c6f47451b693.png)
* (macOS Sonoma) Hide the default macOS menu bar in *System Settings* -> *Control Center* -> *Automatically hide and show the menu bar* -> *Always*:
  ![hide_macOS_bar_sonoma](https://felixkratz.github.io/SketchyBar/assets/images/hide_macos_bar_sonoma-a73b1b7a89a77840c2203cbd2993f4a0.png)

### Compile from source[​](https://felixkratz.github.io/SketchyBar/setup.html#compile-from-source "Direct link to heading")

It is easy to compile the project from source:

* Install Xcode commandline tools:

```
xcode-select --install
```

* Clone the repository:

```
git clone https://github.com/FelixKratz/SketchyBar.git
```

* In the sketchybar folder run:

```
make
```

This will generate a universal binary with arm64 and x86 instructions. It is
possible to generate an arm64/x86 only binary via `make arm64` or `make x86`.
Compiling on older macOS (pre Big Sur) versions should always be done via `make x86`.

## Uninstall[​](https://felixkratz.github.io/SketchyBar/setup.html#uninstall "Direct link to heading")

Uninstall via `brew`:

```
brew uninstall sketchybar
brew untap FelixKratz/formulae
```

[Previous

Features](https://felixkratz.github.io/SketchyBar/features.html)[Next

Bar Properties](https://felixkratz.github.io/SketchyBar/config/bar.html)

* [Installation](https://felixkratz.github.io/SketchyBar/setup.html#installation)
  + [Prerequisite](https://felixkratz.github.io/SketchyBar/setup.html#prerequisite)
  + [Brew Install](https://felixkratz.github.io/SketchyBar/setup.html#brew-install)
  + [Fonts](https://felixkratz.github.io/SketchyBar/setup.html#fonts)
  + [Plugins](https://felixkratz.github.io/SketchyBar/setup.html#plugins)
  + [Hiding the original macOS bar](https://felixkratz.github.io/SketchyBar/setup.html#hiding-the-original-macos-bar)
  + [Compile from source](https://felixkratz.github.io/SketchyBar/setup.html#compile-from-source)
* [Uninstall](https://felixkratz.github.io/SketchyBar/setup.html#uninstall)
