---
title: "SwiftLintを導入する"
category: "environment"
description: "iOSプロジェクトのコードを綺麗に統一されたものにするためのSwiftLintの導入方法を紹介します。"
order: 3
published: true
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
    realm/SwiftLint@0.44.0
    ```

    `Mintfile` のある場所で `mint bootstrap` を行います。
    
    ```bash
    mint bootstrap
    ```

    `mint list` でインストールされたことを確認します。
    ```bash
    mint list
    ```


2. Run Script を追加する
   
   Xcode でプロジェクトを開き、 `TARGETS` > `BuildPhases` を開き、+ボタンより `New Run Script Phase` を選択します。(図１)
    ![図1](/assets/swiftlint/images/figure1.png)
    *図1*

    以下の Script を追加します。（図2）
    ```shell
    if which mint >/dev/null; then
    mint run swiftlint swiftlint autocorrect --format
    mint run swiftlint swiftlint
    else
    echo "warning: Mint not installed, download from https://github.com/yonaskolb/Mint"
    fi
    ```

    ![図2](/assets/swiftlint/images/figure2.png)
    *図2*    


3. .swiftlint.yml を追加する
   
   プロジェクトのルートに `.swiftlint.yml` を追加します。
   ```
    .
    ├─ プロジェクト名.xcodeproj
    ├─ プロジェクト名
    ├─ Mintfile
    └─ .swiftlint.yml
    ```
    
    このファイルでは、詳細なルールを変更したり無効化したりすることができます。

    ```yaml
    included:
     - SwiftRecipesSample

    excluded:
     - SwiftRecipesSample/Scripts/R.generated.swift
     - Carthage

    line_length: 200
    large_tuple: 5

    file_length:
     warning: 500
     error: 1200

    nesting:
     type_level:
      warning: 2

    identifier_name:
     excluded:
      - id
      - URL
      - en
      - ja
    cyclomatic_complexity: 20
    ```

    `included` では ターゲットを記述してください。
    `excluded` では除外するファイルを記述します。`R.swift` と併用する場合には、ここに `R.generated.swift` を追加してください。
    
    その他のルールについては、SwiftLint の[README](https://github.com/realm/SwiftLint#configuration)をご覧ください。


4. ビルドをしましょう

    `.swiftlint.yml` が反映されてない場合には一度クリーンビルド（⌘+Shift+K）をして、ビルドをしましょう。それでも反映されない場合には yaml の記述が正しいかの確認をしましょう。（余分なスペースなどに注意しましょう）

    SwiftLintが正しく動作しているかを確認する際には、以下のようにルールに反する文を書いてビルドをして確認しましょう。（図3）
    ```swift
    let i = 1
    ```
    
    ![図3](/assets/swiftlint/images/figure3.png)
    *図3*


## 部分的にルールを無効化する

SwiftLintではコード上で明示的にルールを無効化するコメントを追加することで、エラーを回避することができます。
例えば図3のエラーは以下のように回避することができます。
```swift
let i = 1 // swiftlint:disable:this identifier_name
```
![図4](/assets/swiftlint/images/figure4.png)
*図4*

これらの無効化の方法の詳細は [README](https://github.com/realm/SwiftLint#disable-rules-in-code)をご覧ください。

## おわりに

SwiftLint 単体でも勿論利用可能ですが、以下のレシピと合わせて、是非環境構築をしてみてください。
1. [iOSアプリのプロジェクト作成 / XIB を使った開発](https://swift-recipes.doshcook.com/recipes/create-project)
2. [R.swiftを導入する](https://swift-recipes.doshcook.com/recipes/rswift)

SwiftLint ではそのほかにも様々な機能があります。[GitHub](https://github.com/realm/SwiftLint)にてご確認ください。
