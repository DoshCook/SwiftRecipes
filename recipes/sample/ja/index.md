---
title: "サンプル記事です"
published: true
date: 2021-04-29
---
## 実行環境

執筆時の環境です。

⛏ Xcode 12.4
🕊 Swift 5.3.2
🍎 macOS BigSur 11.1
📱 iOS 13.0 ~ 14.5

-----

## プロジェクトを作成しよう

まずは、プロジェクトを作成しましょう。

`iOS` `App` を選択して `next` を押します。（図1-1）
![図1-1](https://storage.googleapis.com/zenn-user-upload/yr97csa27pfo0vpb5gf063053hls)
*図1-1*

`Product Name` をつけて、以下のように設定をします。

<!-- 表難しい いる? -->
| 項目 | 選択項目 |
| :-: | :-: |
| Interface | Storyboard |
| Life Cycle | UIKit App Delegate |
| Language | Swift |

![図1-2](https://storage.googleapis.com/zenn-user-upload/ta2vaqi808zbz1rsa35fwwn8jw9k)


## ディレクトリ整理をしよう

一般の書籍ではあまり触れられることはなく、職場やプロジェクトによっては整理されないまま開発が行われる場合もあります。ですが、ディレクトリを整理しておくことはとても大切です。まずは、初めからあるファイルの整理をしておきましょう。

プロジェクト作成時の構成は以下のようになっています。
```bash
.
├─ プロジェクト名.xcodeproj
└─ プロジェクト名
    ├── AppDelegate.swift # アプリ全体のライフサイクルを管理する（必須）
    ├── Assets.xcassets # 画像や色を管理する
    ├── Base.lproj # LaunchScreen.storyboard と Main.storyboard がはいっている
    ├── Info.plist # アプリ実行時に必要な情報を設定するファイル（必須）
    ├── SceneDelegate.swift # Scene を管理する
    └── ViewController.swift # デフォルトで用意されたViewController
```

`Resources` と `Scripts` と `Storyboard` で分割します。

```
.
├─ プロジェクト名.xcodeproj
└─ プロジェクト名
    ├── Scripts
    |    ├── AppDelegate.swift
    |    ├── SceneDelegate.swift
    |    └── ViewController.swift
    ├── Resources
    |    ├── Info.plist
    |    └── Assets.xcassets
    └──  Sotryboard
        └── Base.lproj
```

Xcode内のプロジェクトツリーと、実際のディレクトリ内の構成が図1-3, 図1-4のように一致するようにしてください。

![図1-3](https://storage.googleapis.com/zenn-user-upload/bv8lrp8kjf0n4a2htr68nyib2878)
*図1-3*

![図1-4](https://storage.googleapis.com/zenn-user-upload/ra6qeu3sk4ejwrds53i7n5hb4oky)
*図1-4*


`Info.plist` の場所を変更すると、以下のようなエラーが出てビルドができなくなります。

> error: Build input file cannot be found: '/Users/User/XcodeProjects/UICollectionViewPracticeBook/UICollectionViewPracticeBook/Info.plist' (in target 'UICollectionViewPracticeBook' from project 'UICollectionViewPracticeBook')

`Build Settings` で `Info.plist` を `Resources` 下になるように修正します。（図1-5, 図1-6）

![図1-5](https://storage.googleapis.com/zenn-user-upload/p5b5r3mvp5u6dpa7phe2hmny0e4t)
*図1-5*

![図1-6](https://storage.googleapis.com/zenn-user-upload/ga0rjwd2a5z2ed2w1ni5qlea8dy0)
*図1-6*

最初のディレクトリ整理ができました。その他のファイルについては、本書内で新規にファイルを追加する際に都度示していきます。

## SceneDelegate について

iOS13から `SceneDelegate.swift` というファイルが、テンプレートとしてプロジェクトに生成されるようになりました。以下の図1-7のように、同じアプリを分割して同時に開く場合に利用されます。

> ![図1-7](https://storage.googleapis.com/zenn-user-upload/iyjhst9ly0agrq6d561xfq6ymfwn)
> *図1-7*
> 引用: [Scenes | Apple Developer Documentation](https://developer.apple.com/documentation/uikit/app_and_environment/scenes)

<details><summary>SceneDelegate を使わない場合</summary>

iOS13以下への対応をしたい場合や、複数画面を起動して欲しくない場合には以下の手順でファイルを削除しましょう。

1. Info.plist より `Application Scene Manifest` を削除する
    ![図1-8](https://storage.googleapis.com/zenn-user-upload/2pluo7j135po6odb759gyuguhvpl)
    *図1-8*

2. `AppDelegate.swift` より `UISceneSession Lifecycle` 以下を削除する

    AppDelegate.swift から取り除きます。
    ```swift
    // 以下を削除する
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    ```
3. `AppDelegate.swift` に `var window: UIWindow?` を追加する
    
    ```swift
    import UIKit

    @main
    class AppDelegate: UIResponder, UIApplicationDelegate {
        // 追加する
        var window: UIWindow?

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // Override point for customization after application launch.
            return true
        }
    }
    ```
4. SceneDelegate.swift を削除する
    最後に `SceneDelegate.swift` を削除することで `SceneDelegate.swift` を削除することができます。
</details>

## xib を使った開発

iOSアプリを開発する方法は、Swift言語を用いたものだけでも多岐にわたります。UserInterface(UI)の実装方法についても同様で、`Storyboard` / `xib` / `SwiftUI` といったInterface Builder (IB) を用いた方法とコードだけで書く方法があります。

1. Storyboard
2. xib
3. SwiftUI

### xib を使う理由
SwiftUIについては、UIKitでできることの全てがSwiftUIでできるわけではないというデメリットがあります。次に、IBを全く使わずにコードだけ書く方法は、ビルドをするまで見た目がわからなかったり、コードの記述が多く煩雑になってしまったりするために避けます。

`Storyboard` と `xib` はどちらもIBを使った方法です。Storyboardは画面遷移が明確になるメリットがありますが、チーム開発時のコンフリクトや、イニシャライザでの依存性注入 (DI)が難しいなどのデメリットにより、 `xib`を用いた開発を選択します。
 
|| チーム開発 | イニシャライザでのDI |
| :-: | :-: | :-: |
| xib | ○ | ○ |
| Storyboard | △ | △ |

<details><summary>イニシャライザでのDIとは</summary>
依存性の注入 （Dependency Injection）をイニシャライザで行うことです。

 `xib` を用いる場合には、以下のようにイニシャライザで値を渡すことができます。
```swift
import UIKit

final class ViewController: UIViewController {
    
    private let initialText: String

    // イニシャライザで値を渡す
    init(initialText: String) {
        self.initialText = initialText
        super.init(nibName: "ViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// 生成時
let viewController(text: "イニシャライザで渡したい値")
```

Storyboard の場合は、iOS13からイニシャライザでのDIができるようになりました。
```swift
class ViewController: UIViewController {

    private let initialText: String

    init?(coder: NSCoder, initialText: String) {
        self.initialText = initialText
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// 生成時
let storyboard = UIStoryboard(name: "ViewController", bundle: nil)
let viewController = storyboard.instantiateInitialViewController { coder in
    ViewController(coder: coder, initialText: "イニシャライザで渡したい値")
}
```
[iOS13ではStoryboardでもDIができる件について - Qiita](https://qiita.com/shtnkgm/items/cad6f52c489612628fd4) より引用

</details>

これらは組み合わせて使うこともできます。参画するプロジェクトによってやり方は様々です。一概に良し悪しは決められませんが、本書では `xib` を用いた方法で実装していきます。

### 最初の画面の表示

`Storyboard` を使う場合は、Storyboard 上の矢印（→）が指す画面が、アプリ起動後に開かれます。 `xib` を使った開発では、起動時に開く画面をコードで示してあげる必要があります。

1. `Main.storyboard` は用いないので削除します。
2. `Info.plist` の `Main storyboard file base name` を削除します。
    ![図1-9](https://storage.googleapis.com/zenn-user-upload/92ujfbz2r9x8v5t5spacsc46k3qj)
    *図1-9*
3. アプリ起動時に開く画面の設定をコード上で行う
    起動画面の指定をする場所は、先述の `SceneDelegate.swift` を用いるかどうかによって異なります。
    今後のチャプターでは1の方法を用います。

    1. SceneDelegate.swiftを用いる場合
        `SceneDelegate` を用いる場合には、`Info.plist` > `Application Scene Manifest` > `Scene Configuration` > `Application Session Role` > `Item 0(Default Configuration)` 内の `Storyboard Name` を削除します。
        ![図1-10](https://storage.googleapis.com/zenn-user-upload/zau4u5yqz2k7j6lxl3lrveywxofp)
        *図1-10*

        次に `SceneDelegate.swift` の `scene(_:willConnectTo:options:)` 内に以下を書きます。
        ```swift
        import UIKit

        class SceneDelegate: UIResponder, UIWindowSceneDelegate {

            var window: UIWindow?

            func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
                guard let windowScene = (scene as? UIWindowScene) else { return }
                // 起動後に表示画面を指定する
                // windowの生成
                let window = UIWindow(windowScene: windowScene)
                // 初回起動時に開きたい ViewController を指定
                let viewController = ViewController()
                // windowのルートに設定
                window.rootViewController = viewController
                // window を表示する
                window.makeKeyAndVisible()
                // self.window を生成した window にする
                self.window = window
            }
        }
        ```

    2. SceneDelegate.swiftを用いない場合
        `SceneDelegate` を用いない場合には、 `AppDelegate.swift` の `application(_:didFinishLaunchingWithOptions)` 内に以下を書きます。
        ```swift
        @main
        class AppDelegate: UIResponder, UIApplicationDelegate {

            var window: UIWindow?

            func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

                // 起動後に表示画面を指定する
                // windowの生成
                let window = UIWindow(frame: UIScreen.main.bounds)
                // 初回起動時に開きたい ViewController を指定
                let viewController = ViewController()
                // windowのルートに設定
                window.rootViewController = viewController
                // window を表示する
                window.makeKeyAndVisible()
                // self.window を生成した window にする
                self.window = window

                return true
            }

        }
        ```

これで `xib` を使った開発をする準備ができました。

## R.swift の導入

最後に `R.swift` を導入します。これは必須ではありませんが、 `UICollectionView` や `UITableView` を扱う場合や、`xib` を用いる場合には、とても便利になるので是非導入しておいてください。

### R.swift とは

`R.swift` はリソース管理をしやすくするライブラリです。リソースに型付けを行うことで、文字列のハードコードをする箇所がなくなり、更にはオートコンプリート機能を用いることができるようになります。

[mac-cain13/R.swift: Strong typed, autocompleted resources like images, fonts and segues in Swift projects](https://github.com/mac-cain13/R.swift)

### 本書での活用

本書では、`R.swift` を `UICollectionView` のセル名やxibの名前の取得に用います。

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

<details><summary>Mintの導入</summary>

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
   
    Xcodeでプロジェクトを開き、`TARGETS` > `BuidPhases` を開き、+ボタンより `New Run Script Phase` を選択します。（図1-11）
    ![図1-11](https://storage.googleapis.com/zenn-user-upload/n3cs59e2odm5bzgtm37cozhpphg7)
    *図1-11*

    以下の Script を追加します。(図1-12）
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

    をそれぞれ追加します。(図1-12)

    ![図1-12](https://storage.googleapis.com/zenn-user-upload/b0dz1ywzlfgbs4mq6afyx6v18tp0)
    *図1-12*

    最後に `Compile Sources` の前に持っていき（図1-13）、ビルドをしましょう。

    ![図1-13](https://storage.googleapis.com/zenn-user-upload/kalb7sz1m3myufiepwlxao6lmidr)
    *図1-13*

    :::messages
    Compile Sources の後に配置しておくと、エラーが出る可能性があるので必ず移動させましょう
    :::

3. R.generated.swift をプロジェクトに追加する
    
    2の手順でビルドをしたら、 `Output Files` に指定した場所に `R.generated.swift` が生成されるので、それを Xcode 上に追加します。（図1-14）

    ![図1-14](https://storage.googleapis.com/zenn-user-upload/ugzi5tx6m51hoj82779h5mudetzz)
    *図1-14*

    追加する際には、`Copy If Needed` のチェックをオフにします。（図1-15）
    ![図1-15](https://storage.googleapis.com/zenn-user-upload/4lnle9sikz8ssohxe15zao0humzo)
    *図1-15*


4. Swift Package Manager で R.swift.Library を導入する
    生成した `R.generated.swift` を実際に利用するために、 `R.swift.Library` を導入します。

    [mac-cain13/R.swift.Library: Library containing types used by the R.swift project](https://github.com/mac-cain13/R.swift.Library)

    Xcode のナビゲーションバーより `File` > `Swift Packages` > `Add Package Dependency` を選択します。(図1-16)

    ![図1-16](https://storage.googleapis.com/zenn-user-upload/8ekgk9rnkcrufmbwg723yva6qghe)
    *図1-16*

    `Enter package repositry URL` に `https://github.com/mac-cain13/R.swift.Library` を入力します。(図1-17)

    ![図1-17](https://storage.googleapis.com/zenn-user-upload/9kh3h27z2k18s49q4saeitk24pcj)
    *図1-17*

    `Version Rules` は `Update Next Minor` を指定しました。(図1-18)

    ![図1-18](https://storage.googleapis.com/zenn-user-upload/w473pqzvc11vklx2exk1y723hn9g)
    *図1-18*
    
    `R.swift` のみを選択して完了します。(図1-19)

    ![図1-19](https://storage.googleapis.com/zenn-user-upload/uplmg6tle6t0q61byqgc32lne5bj)
    *図1-19*


これで R.swift の導入ができました。

## 環境構築をおえて

今回の環境構築の手順は、`UICollectionView` を使うだけであれば、どれも必須ではありません。しかし、ディレクトリ整理をして全体の見通しをしやすくしたり、リソースを扱いやすくしたりすることは、実際のプロジェクトでは必須事項と言えるでしょう。

本書で扱うことは、どれも絶対的なものではありません。ディレクトリ整理の方法１つとっても、プロジェクトや人それぞれです。同じ実装パターンを用いていたとしても、少しの違いは発生します。本書の内容は一つの方法として、参考にして頂ければ幸いです。

次のチャプターは、 `UICollectionView` についての基礎を紹介します。
