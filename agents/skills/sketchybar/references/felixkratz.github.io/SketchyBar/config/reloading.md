---
title: "Reloading the configuration | SketchyBar"
source_url: "https://felixkratz.github.io/SketchyBar/config/reloading"
fetched_at: "2026-03-08T06:45:16.308494+00:00"
---



* Configuration
* Reloading the configuration

# Reloading the configuration file of the bar

If you wish to reload the configuration file of the bar without resorting to
manually restarting the process you can use the following command:

```
sketchybar --reload [Optional: <path>]
```

which, has the same effect as restarting the process, but is a bit more
convenient. Additionally, an optional `<path>` argument to a new `sketchybarrc`
file can be given to load a different configuration. If the optional argument
is left out, the current configuration is reloaded.

# Hotloading the configuration of the bar

If you wish that the bar automatically reloads the configuration file once you
edit it, you can use the hotload functionality included in SketchyBar. It will
monitor the directory of the current configuration for changes and reload the
configuration should it detect file changes. To control the hotload feature you
can use:

```
sketchybar --hotload <boolean>
```

[Previous

Type Nomenclature](https://felixkratz.github.io/SketchyBar/config/types.html)[Next

Tips & Tricks](https://felixkratz.github.io/SketchyBar/config/tricks.html)
