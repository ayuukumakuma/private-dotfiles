---
title: "Snippets Extensions | Snippets"
source_url: "https://zed.dev/docs/extensions/snippets"
fetched_at: "2026-03-14T02:10:38.629258+00:00"
---



# [Snippets](https://zed.dev/docs/extensions/snippets.html#snippets)

Extensions may provide snippets for one or more languages.

Each file containing snippets can be specified in the `snippets` field of the `extensions.toml` file.

The referenced path must be relative to the `extension.toml`.

## [Defining Snippets](https://zed.dev/docs/extensions/snippets.html#defining-snippets)

A given extension may provide one or more snippets. Each snippet must be registered in the `extension.toml`.

Zed matches snippet files based on the lowercase name of the language (e.g. `rust.json` for Rust).
You can use `snippets.json` as a file name to define snippets that will be available regardless of the current buffer language.

For example, here is an extension that provides snippets for Rust and TypeScript:

```
snippets = ["./snippets/rust.json", "./snippets/typescript.json"]
```

For more information on how to create snippets, see the [Snippets documentation](https://zed.dev/docs/snippets.html).

[Icon Theme Extensions](https://zed.dev/docs/extensions/icon-themes.html "Icon Theme Extensions")
[Slash Command Extensions](https://zed.dev/docs/extensions/slash-commands.html "Slash Command Extensions")
