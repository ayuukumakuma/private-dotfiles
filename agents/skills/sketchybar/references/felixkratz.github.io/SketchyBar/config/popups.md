---
title: "Popup Menus | SketchyBar"
source_url: "https://felixkratz.github.io/SketchyBar/config/popups"
fetched_at: "2026-03-08T06:45:16.308494+00:00"
---



* Configuration
* Popup Menus

On this page

## Popup Menus[​](https://felixkratz.github.io/SketchyBar/config/popups.html#popup-menus "Direct link to heading")

![Simple Popup](https://user-images.githubusercontent.com/22680421/146688291-b8bc5e77-e6a2-42ee-bd9f-b3709c63d936.png)

Popup menus are a powerful way to make further `items` accessible in a small popup window below any bar item.
Every item has a popup available with the properties:

```
sketchybar --set <name> popup.<popup_property>=<value>
```

| <popup\_property> | <value> | default | description |
| --- | --- | --- | --- |
| `drawing` | `<boolean>` | `off` | If the `popup` should be rendered |
| `horizontal` | `<boolean>` | `off` | If the `popup` should render horizontally |
| `topmost` | `<boolean>` | `on` | If the `popup` should always be on top of all other windows |
| `height` | `<positive_integer>` | bar height | The vertical spacing between items in a popup |
| `blur_radius` | `<positive_integer>` | `0` | The blur applied to the popup background |
| `y_offset` | `<integer>` | `0` | Vertical offset applied to the `popup` |
| `align` | `left`, `right`, `center` | `left` | Alignment of the popup with its parent item in the bar |
| `background.<background_property>` |  |  | Popups have a background and support all properties |

Items can be added to a popup menu by setting the `position` of those items to `popup.<name>` where `<name>` is the name of the item containing the popup.
You can find a demo implementation of this [here](https://github.com/FelixKratz/SketchyBar/discussions/12?sort=new#discussioncomment-1843975).

[Previous

Special Components](https://felixkratz.github.io/SketchyBar/config/components.html)[Next

Events & Scripting](https://felixkratz.github.io/SketchyBar/config/events.html)

* [Popup Menus](https://felixkratz.github.io/SketchyBar/config/popups.html#popup-menus)
