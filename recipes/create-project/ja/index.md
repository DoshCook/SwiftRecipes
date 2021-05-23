---
title: "iOSアプリのプロジェクト作成 / XIB を使った開発"
category: "introduction"
description: ""
published: true
---

## はじめに

カレーのレシピが1つではないように、iOSアプリ開発の方法も1つではありません。
今回紹介する方法は、私が行っている標準的な方法ですが、ベストとは限りません。プロジェクトや人それぞれにベストがあります。
ここで紹介する私のレシピが、あなたにあった味であれば幸いです。

## 実行環境

⛏ Xcode 12.5
🕊 Swift 5.3.2
🍎 macOS BigSur 11.1
📱 iOS 13.0 ~ 14.5

## サンプルについて

サンプルは[DoshCook/SwiftRecipesSample](https://github.com/DoshCook/SwiftRecipesSample/tree/uruly/create-project)にあります。

## プロジェクトを作成しよう

プロジェクトを作成しましょう。

`iOS` `App` を選択して `next` を押します。（図1）
![図1](https://res.cloudinary.com/swift-recipes/image/upload/v1621774706/create-project/create-project-1-1_kw8546.png)
*図1*

`Product Name` をつけて、以下のように設定をします。（図2）

| 項目 | 選択項目 |
| :-: | :-: |
| Interface | Storyboard |
| Life Cycle | UIKit App Delegate |
| Language | Swift |

![図2](https://res.cloudinary.com/swift-recipes/image/upload/v1621774706/create-project/create-project-1-2_ixfekp.png)
*図2*


## ディレクトリ整理をしよう

初めからあるファイルの整理をしておきましょう。

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

Xcode内のプロジェクトツリーと、実際のディレクトリ内の構成が図3, 図4のように一致するようにしてください。

![図3](https://res.cloudinary.com/swift-recipes/image/upload/v1621775144/create-project/create-project-1-3_lcg3mi.png)
*図3*

![図4](https://res.cloudinary.com/swift-recipes/image/upload/v1621775222/create-project/create-project-1-4_gsbkyx.png)
*図4*


`Info.plist` の場所を変更したため、以下のようなエラーが出てビルドができなくなります。

> Build input file cannot be found: '/Users/uruly/DoshCook/XcodeProjects/SwiftRecipesSample/SwiftRecipesSample/Info.plist'

`Build Settings` で `Info.plist` を `Resources` 下になるように修正します。（図5)

![図5](https://res.cloudinary.com/swift-recipes/image/upload/v1621775659/create-project/create-project-1-5_z4tpz6.png)
*図5*

本サイトでは基本的にこの構成でフォルダ分けを行っています。

## SceneDelegate について

iOS13から `SceneDelegate.swift` というファイルが、テンプレートとしてプロジェクトに生成されるようになりました。以下の図6のように、同じアプリを分割して同時に開く場合に利用されます。

> ![図6](https://res.cloudinary.com/swift-recipes/image/upload/v1621775862/create-project/create-project-1-6_jm2h4r.png)
> *図6*
> 引用: [Scenes | Apple Developer Documentation](https://developer.apple.com/documentation/uikit/app_and_environment/scenes)

### SceneDelegate を使わない場合

iOS13以下への対応をしたい場合や、複数画面を起動して欲しくない場合には以下の手順でファイルを削除しましょう。

1. Info.plist より `Application Scene Manifest` を削除する
    ![図7](https://res.cloudinary.com/swift-recipes/image/upload/v1621776025/create-project/create-project-1-7_eqdcw2.png)
    *図7*

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


## xib を使った開発

iOSアプリを開発する方法は、Swift言語を用いたものだけでも多岐にわたります。UserInterface(UI)の実装方法についても同様で、`Storyboard` / `xib` / `SwiftUI` といったInterface Builder (IB) を用いた方法とコードだけで書く方法があります。

1. Storyboard
2. xib
3. SwiftUI

### xib を使う理由
SwiftUIについては、UIKitでできることの全てが未だSwiftUIでできるわけではないというデメリットがあります。次に、IBを全く使わずにコードだけ書く方法は、ビルドをするまで見た目がわからなかったり、コードの記述が多く煩雑になってしまいます。

`Storyboard` と `xib` はどちらもIBを使った方法です。Storyboardは画面遷移が明確になるメリットがありますが、チーム開発時のコンフリクトや、イニシャライザでの依存性注入 (DI)が難しいなどのデメリットにより、 `xib`を用いた開発を選択します。
 
|| チーム開発 | イニシャライザでのDI |
|:-:|:-:|:-:|
| xib | ○ | ○ |
| Storyboard | △ | △ |

### イニシャライザでのDIとは
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

これらは組み合わせて使うこともできます。参画するプロジェクトによってやり方は様々です。一概に良し悪しは決められませんが、本サイトでは基本的に `xib` を用いた方法で実装していきます。

### 画面を作成する

新規に `Scripts` 以下に `Views` フォルダを作成します。
ViewController の名前は `CreateProjectSampleViewController` という名前にする予定なので、`CreateProjectSmaple` というフォルダを作成しました。

現在の構成は次の通りです。

```
.
├─ プロジェクト名.xcodeproj
└─ プロジェクト名
    ├── Scripts
    |    ├── AppDelegate.swift
    |    ├── SceneDelegate.swift
    |    └── Views
    |         └── CreateProjectSample
    |               ├── CreateProjectSampleViewController.swift
    |               └── CreateProjectSampleViewController.xib
    ├── Resources
    |    ├── Info.plist
    |    └── Assets.xcassets
    └──  Sotryboard
        └── Base.lproj
```

`New` > `File` より `Cocoa Touch Class` を選択して `Next` を選択します。（図8）
![図8](https://res.cloudinary.com/swift-recipes/image/upload/v1621777654/create-project/create-project-1-8_q6ih8g.png)
*図8*

`CreateProjectSampleViewController` という名前で、`Also create XIB file` にチェックを入れて作成します。（図9）

| 項目 | 入力項目 |
| :-: | :-: |
| Class | CreateProjectSampleViewController |
| Subclass of | UIViewController |
| Also create XIB file | チェックを入れる |
| Language | Swift |


![図9](https://res.cloudinary.com/swift-recipes/image/upload/v1621777739/create-project/create-project-1-9_mpkocr.png)
*図9*

### 最初の画面の表示

`Storyboard` を使う場合は、Storyboard 上の矢印（→）が指す画面が、アプリ起動後に開かれます。 `xib` を使った開発では、起動時に開く画面をコードで示してあげる必要があります。

1. `Main.storyboard` は用いないので削除します。
2. `Info.plist` の `Main storyboard file base name` を削除します。
    ![図10](https://res.cloudinary.com/swift-recipes/image/upload/v1621777954/create-project/create-project-1-10_xilb4b.png)
    *図10*
3. アプリ起動時に開く画面の設定をコード上で行う
    起動画面の指定をする場所は、先述の `SceneDelegate.swift` を用いるかどうかによって異なります。

    1. SceneDelegate.swiftを用いる場合
        `SceneDelegate` を用いる場合には、`Info.plist` > `Application Scene Manifest` > `Scene Configuration` > `Application Session Role` > `Item 0(Default Configuration)` 内の `Storyboard Name` を削除します。
        ![図11](https://res.cloudinary.com/swift-recipes/image/upload/v1621777955/create-project/create-project-1-11_lrt410.png)
        *図11*

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
                let viewController = CreateProjectSampleViewController(nibName: "CreateProjectSampleViewController", bundle: nil)
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
                let viewController = CreateProjectSampleViewController(nibName: "CreateProjectSampleViewController", bundle: nil)
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
あとは、`Views` 配下に `ViewController` を配置していく形で開発を進めていきます。

## おわりに

このサイトで紹介するレシピの多くはこのプロジェクト作成方法をベースとしていく予定です。
