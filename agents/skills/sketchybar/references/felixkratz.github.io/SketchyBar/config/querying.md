---
title: "Querying Information | SketchyBar"
source_url: "https://felixkratz.github.io/SketchyBar/config/querying"
fetched_at: "2026-03-08T06:45:16.308494+00:00"
---



* Configuration
* Querying Information

On this page

## Querying[​](https://felixkratz.github.io/SketchyBar/config/querying.html#querying "Direct link to heading")

*SketchyBar* can be queried for information about a number of things.

### Bar Properties[​](https://felixkratz.github.io/SketchyBar/config/querying.html#bar-properties "Direct link to heading")

Information about the bar can be queried via:

```
sketchybar --query bar
```

The output is a JSON structure containing relevant information about the configuration settings of the bar.

### Item Properties[​](https://felixkratz.github.io/SketchyBar/config/querying.html#item-properties "Direct link to heading")

Information about an item can be queried via:

```
sketchybar --query <name>
```

The output is a JSON structure containing relevant information about the configuration of the item.

### Default Properties[​](https://felixkratz.github.io/SketchyBar/config/querying.html#default-properties "Direct link to heading")

Information about the current defaults.

```
sketchybar --query defaults
```

### Event Properties[​](https://felixkratz.github.io/SketchyBar/config/querying.html#event-properties "Direct link to heading")

Information about the events.

```
sketchybar --query events
```

### macOS Menu Bar Item Names (for use with aliases)[​](https://felixkratz.github.io/SketchyBar/config/querying.html#macos-menu-bar-item-names-for-use-with-aliases "Direct link to heading")

The names of the menu bar items in the default macOS bar:

```
sketchybar --query default_menu_items
```

### Display Configuration Information[​](https://felixkratz.github.io/SketchyBar/config/querying.html#display-configuration-information "Direct link to heading")

Information about the current display configuration:

```
sketchybar --query displays
```

[Previous

Events & Scripting](https://felixkratz.github.io/SketchyBar/config/events.html)[Next

Animations](https://felixkratz.github.io/SketchyBar/config/animations.html)

* [Querying](https://felixkratz.github.io/SketchyBar/config/querying.html#querying)
  + [Bar Properties](https://felixkratz.github.io/SketchyBar/config/querying.html#bar-properties)
  + [Item Properties](https://felixkratz.github.io/SketchyBar/config/querying.html#item-properties)
  + [Default Properties](https://felixkratz.github.io/SketchyBar/config/querying.html#default-properties)
  + [Event Properties](https://felixkratz.github.io/SketchyBar/config/querying.html#event-properties)
  + [macOS Menu Bar Item Names (for use with aliases)](https://felixkratz.github.io/SketchyBar/config/querying.html#macos-menu-bar-item-names-for-use-with-aliases)
  + [Display Configuration Information](https://felixkratz.github.io/SketchyBar/config/querying.html#display-configuration-information)
