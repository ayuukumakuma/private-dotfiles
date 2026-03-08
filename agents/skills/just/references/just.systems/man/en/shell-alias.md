---
title: "Shell Alias - Just Programmer's Manual"
source_url: "https://just.systems/man/en/shell-alias"
fetched_at: "2026-03-08T07:12:17.743465+00:00"
---



### [Shell Alias](https://just.systems/man/en/shell-alias.html#shell-alias)

For lightning-fast command running, put `alias j=just` in your shell’s
configuration file.

In `bash`, the aliased command may not keep the shell completion functionality
described in the next section. Add the following line to your `.bashrc` to use
the same completion function as `just` for your aliased command:

```
complete -F _just -o bashdefault -o default j
```
