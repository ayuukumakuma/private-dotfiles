---
title: "Re-running recipes when files change - Just Programmer's Manual"
source_url: "https://just.systems/man/en/re-running-recipes-when-files-change"
fetched_at: "2026-03-08T07:12:17.743465+00:00"
---



### [Re-running recipes when files change](https://just.systems/man/en/re-running-recipes-when-files-change.html#re-running-recipes-when-files-change)

[`watchexec`](https://github.com/mattgreen/watchexec) can re-run any command
when files change.

To re-run the recipe `foo` when any file changes:

```
watchexec just foo
```

See `watchexec --help` for more info, including how to specify which files
should be watched for changes.
