---
title: "R.swiftを導入する"
category: "environment"
description: "R.swift を使ってリソースを扱いやすくする方法を紹介します。iOSアプリ開発をする際には是非導入してみましょう。"
order: 2
published: true
---

`R.swift` は `xib` を使った開発には、とても便利になるので是非導入しておいてください。
本サイトのレシピの多くで用いていきます。

## R.swift とは

`R.swift` はリソース管理をしやすくするライブラリです。リソースに型付けを行うことで、文字列のハードコードをする箇所がなくなり、更にはオートコンプリート機能を用いることができるようになります。

[mac-cain13/R.swift: Strong typed, autocompleted resources like images, fonts and segues in Swift projects](https://github.com/mac-cain13/R.swift)

*R.swiftを用いない場合*
```swift
// セルの登録
collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cell")

// セルの再利用時
let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

// ViewController の生成時
let viewController = ViewController(nibName: "ViewController", bundle: nil)
```

*R.swiftを用いる場合*
```swift
// セルの登録
collectionView.register(R.nib.customCollectionViewCell)

// セルの再利用時
let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.customCollectionViewCell, for: indexPath)!

// ViewController の生成時
let viewController = ViewController(nib: R.nib.viewController)
```

### Mint での導入

今回は `Mint` を使った `R.swift` の導入方法を紹介します。その他の方法については[README.md](https://github.com/mac-cain13/R.swift)をご確認ください。

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
</details>

1. インストール
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

    `Mintfile` に 以下を記述します。

    ```
    mac-cain13/R.swift

    // バージョン指定ありの場合
    mac-cain13/R.swift@v5.3.1
    ```

    `Mintfile` のある場所で `mint bootstrap` を行います。

    ```bash
    mint bootstrap
    ```

2. Run Script を追加する
   
    Xcodeでプロジェクトを開き、`TARGETS` > `BuidPhases` を開き、+ボタンより `New Run Script Phase` を選択します。（図1）
    ![図1](/assets/rswift/images/figure1.png)
    *図1*

    以下の Script を追加します。(図2）
    ```shell
    if mint list | grep -q 'R.swift'; then
    mint run R.swift rswift generate "$SRCROOT/プロジェクト名/Scripts/R.generated.swift"
    else
    echo "error: R.swift not installed; run 'mint bootstrap' to install"
    return -1
    fi
    ```

    `Input Files` 
    ```
    $TEMP_DIR/rswift-lastrun
    ```

    `Output Files` 
    ```
    $SRCROOT/プロジェクト名/Scripts/R.generated.swift
    ```

    をそれぞれ追加します。(図2)

    ![図2](/assets/rswift/images/figure2.png)
    *図2*

    最後に `Compile Sources` の前に持っていき（図3）、ビルドをしましょう。

    ![図3](/assets/rswift/images/figure3.png)
    *図3*

    Compile Sources の後に配置しておくと、エラーが出る可能性があるので必ず移動させましょう。

3. R.generated.swift をプロジェクトに追加する
    
    2の手順でビルドをしたら、 `Output Files` に指定した場所に `R.generated.swift` が生成されるので、それを Xcode 上に追加します。（図4）

    ![図4](/assets/rswift/images/figure4.png)
    *図4*

    追加する際には、`Copy If Needed` のチェックをオフにします。（図5）
    ![図5](/assets/rswift/images/figure5.png)
    *図5*


4. Swift Package Manager で R.swift.Library を導入する
    生成した `R.generated.swift` を実際に利用するために、 `R.swift.Library` を導入します。

    [mac-cain13/R.swift.Library: Library containing types used by the R.swift project](https://github.com/mac-cain13/R.swift.Library)

    Xcode のナビゲーションバーより `File` > `Swift Packages` > `Add Package Dependency` を選択します。(図6)

    ![図6](/assets/rswift/images/figure6.png)
    *図6*

    `Enter package repositry URL` に `https://github.com/mac-cain13/R.swift.Library` を入力します。(図7)

    ![図7](https://res.cloudinary.com/swift-recipes/image/upload/v1622370747/rswift/rswift7_sta3qg.png)
    *図7*

    `Version Rules` は `Update Next Minor` を指定しました。(図8)

    ![図8](/assets/rswift/images/figure8.png)
    *図8*
    
    `R.swift` のみを選択して完了します。(図9)

    ![図9](/assets/rswift/images/figure9.png)
    *図9*


これで R.swift の導入ができました。

## .gitignore で R.generated.swift を無視する

`R.generated.swift` は自動で生成されるファイルです。このファイルは Git での管理対象から外しておきましょう。

`.gitignore` に追記しておきます。
```text
R.generated.swift
```

既に管理対象になってしまっている場合にはキャッシュを削除してリポジトリから削除します。
```bash
git rm --cached `git ls-files --full-name -i --exclude-standard`
```



