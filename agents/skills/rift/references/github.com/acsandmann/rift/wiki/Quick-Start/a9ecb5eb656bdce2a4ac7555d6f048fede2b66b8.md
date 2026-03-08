---
title: "Quick Start · acsandmann/rift Wiki · GitHub"
source_url: "https://github.com/acsandmann/rift/wiki/Quick-Start/a9ecb5eb656bdce2a4ac7555d6f048fede2b66b8"
fetched_at: "2026-03-08T06:38:58.794516+00:00"
---



[acsandmann](https://github.com/acsandmann)
/
**[rift](https://github.com/acsandmann/rift)**
Public

* ### Uh oh!

  There was an error while loading. [Please reload this page](https://github.com/acsandmann/rift/wiki/Quick-Start/a9ecb5eb656bdce2a4ac7555d6f048fede2b66b8.html).
* [Notifications](https://github.com/login?return_to=%2Facsandmann%2Frift) You must be signed in to change notification settings
* [Fork
  47](https://github.com/login?return_to=%2Facsandmann%2Frift)
* [Star
   1.6k](https://github.com/login?return_to=%2Facsandmann%2Frift)

* [Code](https://github.com/acsandmann/rift)
* [Issues
  44](https://github.com/acsandmann/rift/issues)
* [Pull requests
  8](https://github.com/acsandmann/rift/pulls)
* [Discussions](https://github.com/acsandmann/rift/discussions)
* [Actions](https://github.com/acsandmann/rift/actions)
* [Projects](https://github.com/acsandmann/rift/projects)
* [Wiki](https://github.com/acsandmann/rift/wiki.html)
* [Security
  0](https://github.com/acsandmann/rift/security)
* [Insights](https://github.com/acsandmann/rift/pulse)

Additional navigation options

* [Code](https://github.com/acsandmann/rift)
* [Issues](https://github.com/acsandmann/rift/issues)
* [Pull requests](https://github.com/acsandmann/rift/pulls)
* [Discussions](https://github.com/acsandmann/rift/discussions)
* [Actions](https://github.com/acsandmann/rift/actions)
* [Projects](https://github.com/acsandmann/rift/projects)
* [Wiki](https://github.com/acsandmann/rift/wiki.html)
* [Security](https://github.com/acsandmann/rift/security)
* [Insights](https://github.com/acsandmann/rift/pulse)

# Quick Start

[Jump to bottom](https://github.com/acsandmann/rift/wiki/Quick-Start/a9ecb5eb656bdce2a4ac7555d6f048fede2b66b8.html#wiki-pages-box)

acsandmann edited this page Oct 15, 2025
·
[11 revisions](https://github.com/acsandmann/rift/wiki/Quick-Start/_history.html)

# Quick Start Guide

Tip

in order for rift to begin managing windows it must first be *activated* by pressing `Alt + Z` which is the default key combination for the `toggle_space_activated`

## installation

### build from source

```
git clone https://github.com/acsandmann/rift.git
```

once rift is installed you must build it (and the cli if you want to run it as a service)

```
cargo build --bins --release
```

now you can run it with `./target/release/rift` *or* you can install it as a service

---

To install it as a service you must do

```
cargo run --bin rift-cli --release service install
cargo run --bin rift-cli --release service start
```

it will prompt you to give it accessibility permissions if you have not done so already and after it will stop itself. once you have given it permission start it again using

```
cargo run --bin rift-cli --release service restart
```

---

now to customize you must create your own config, this is thoroughly documented [here](https://github.com/acsandmann/rift/wiki/Config.html)

## Toggle table of contents Pages 4

* Loading
  [Home](https://github.com/acsandmann/rift/wiki.html)

  ### Uh oh!

  There was an error while loading. [Please reload this page](https://github.com/acsandmann/rift/wiki/Quick-Start/a9ecb5eb656bdce2a4ac7555d6f048fede2b66b8.html).
* Loading
  [Config](https://github.com/acsandmann/rift/wiki/Config.html)

  ### Uh oh!

  There was an error while loading. [Please reload this page](https://github.com/acsandmann/rift/wiki/Quick-Start/a9ecb5eb656bdce2a4ac7555d6f048fede2b66b8.html).
* Loading
  [Integrations](https://github.com/acsandmann/rift/wiki/Integrations.html)

  ### Uh oh!

  There was an error while loading. [Please reload this page](https://github.com/acsandmann/rift/wiki/Quick-Start/a9ecb5eb656bdce2a4ac7555d6f048fede2b66b8.html).
* Loading
  [Quick Start](https://github.com/acsandmann/rift/wiki/Quick-Start.html)

  ### Uh oh!

  There was an error while loading. [Please reload this page](https://github.com/acsandmann/rift/wiki/Quick-Start/a9ecb5eb656bdce2a4ac7555d6f048fede2b66b8.html).

### Clone this wiki locally
