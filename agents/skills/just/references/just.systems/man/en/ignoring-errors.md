---
title: "Ignoring Errors - Just Programmer's Manual"
source_url: "https://just.systems/man/en/ignoring-errors"
fetched_at: "2026-03-08T07:12:17.743465+00:00"
---



### [Ignoring Errors](https://just.systems/man/en/ignoring-errors.html#ignoring-errors)

Normally, if a command returns a non-zero exit status, execution will stop. To
continue execution after a command, even if it fails, prefix the command with
`-`:

```
foo:
  -cat foo
  echo 'Done!'
```

```
$ just foo
cat foo
cat: foo: No such file or directory
echo 'Done!'
Done!
```
