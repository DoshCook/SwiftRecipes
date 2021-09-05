---
title: "SwiftLintを導入する"
category: "introduction"
description: ""
published: false
---

`SwiftLint` を導入して、プロジェクトのコードを綺麗に統一されたものにしましょう。コードの品質を保つためには必須になります。

## SwiftLint とは

`SwiftLint` は Swift のスタイルと規則をつけるための静的解析ツールです。規約は[GitHub Swift Style Guide](https://github.com/github/swift-style-guide)をベースとしています。

[realm/SwiftLint: A tool to enforce Swift style and conventions.](https://github.com/realm/SwiftLint)

## Mint での導入

今回は `Mint` を使った `SwiftLint` の導入方法を紹介します。その他の方法については[README.md](https://github.com/realm/SwiftLint#installation)をご確認ください。

[Mint](https://github.com/yonaskolb/Mint)は Swift製のコマンドラインツールのインストールや実行を管理するツールです。

<details><summary>Mint の導入</summary>

Mint の導入は
```bash
// Mint のインストール
$ brew install mint
// バージョン確認
$ mint version
```
で行うことができます。

プロジェクトのルートに `Mintfile` を作成します。
```bash
cd プロジェクト名
touch Mintfile
```

```
.
├─ プロジェクト名.xcodeproj
├─ プロジェクト名
└─ Mintfile
```
</details>

1. インストール
    `Mintfile` に以下を追記します。
    ```
    realm/SwiftLint@0.43.1
    ```

    `Mintfile` のある場所で `mint bootstrap` を行います。
    
    ```bash
    mint bootstrap
    ```
2. 