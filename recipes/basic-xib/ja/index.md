---
title: "XIBを使ったコンポーネント配置の基本"
category: "uikit-basic"
description: "XIBの使い方を紹介します。まずはUILabelを設置してHelloWorldを表示させましょう。Interface Builderの基本とコードへの紐付け方法を学ぶことができます。"
order: 1
published: false
---

XIB上に UILabel を配置して、Hello Wolrd! を表示させましょう。

## はじめに

プロジェクトの作成は以下を基準としています。
[iOSアプリのプロジェクト作成 / XIB を使った開発](https://swift-recipes.doshcook.com/recipes/create-project)

## XIBへの配置

まずはラベルを XIB上に配置してみましょう。

1. 配置したい画面の .xib ファイルを開き、+ボタンを選択します(図1)

   ![図1](/assets/basic-xib/images/figure1.png)
   *図1*

2. UILabelを選択して画面上にドラッグ&ドロップします。（図2 -> 図3）
   
    ![図2](/assets/basic-xib/images/figure2.png)
    *図2*
    ![図3](/assets/basic-xib/images/figure3.png)
    *図3*

3. AutoLayoutの設定します。
   
   AutoLayout を用いてラベルの場所を指定します。今回は画面の中心に配置します。
   レイアウトを決めたいラベルを選択した状態で、画面下部の `Align` アイコンを選択します。

   `Horizontally in Container` と `Vertically in Container` にチェックを入れて `Add Constraints` を選択します。（図4）

    ![図4](/assets/basic-xib/images/figure4.png)
    *図4*

    <details><summary>現在ついているAutoLayoutの確認方法</summary>
    つけたAutoLayoutを確認する時は、画面上に出ているラインを選択するか、階層の `Constraints` 以下より確認することができます。
    ![Tips1](/assets/basic-xib/images/tips1.png)
    </details>

4. ラベルのテキストを Hello World!に変更しましょう。
    画面右の `Show the Attributes inspector` アイコンを選択し、ラベルのテキストを変更しましょう。
    ![図5](/assets/basic-xib/images/figure5.png)
    *図5*

これで ラベルの配置ができました。
実行して確認してみましょう。

![図6](/assets/basic-xib/images/figure6.png)
*図6*

## コードと紐づける

次に xib に配置したUILabelをコードと紐付けしましょう。今回は `titleLabel` という名前にします。

1.  `Add Editor on Right` を選択します。(図7)

    ![図7](/assets/basic-xib/images/figure7.png)
    *図7*

    画面が分割されるので分割されるので片方はコードを表示しましょう（図8）

    ![図8](/assets/basic-xib/images/figure8.png)
    *図8*

    <details><summary>画面分割時のファイルを開く方法について</summary>
    画面分割時には、フォーカスされている画面でファイルを開きます。
    画面右側に配置したい場合は、右側をクリックしてから開きたいファイルを選択しましょう。

    また、 `option` を押しながら選択した場合は、フォーカスされている画面の反対側の画面でファイルを開くことができます。
    </details>

2. 紐付けをするラベルを `control` を押しながらコードへドラッグします。（図9）
   
    ![図9](/assets/basic-xib/images/figure9.png)
    *図9*

3. 名前をつけて `connect` を選択します。（図10）
   
    ![図10](/assets/basic-xib/images/figure10.png)
    *図10*

これで、コードとの紐付けが完了しました。

<details><summary>名前を間違えた！再設定する場合</summary>
ラベルの名前を間違えてしまった場合には、再設定が必要です。
直接コードの名前のみを変えてしまうと、以下のようなエラーが発生して、クラッシュしてしまいます。

> *** Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[<SwiftRecipesSample.BasicLabelViewController 0x7fe755a09160> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key titleLabel.'
terminating with uncaught exception of type NSException

このような場合には、XIB上の紐付けを解除が必要になります。
.xibファイルを開き、`File's Owner` を選択し、右側の　`Show the Connections inspector` アイコンを押し、Outletsの⚠️がついている部分を×ボタンから削除しましょう。
![Tips2](/assets/basic-xib/images/tips2.png)

それから、再度上記の手順で紐付けを行ってください。

また、コード側から引っ張って紐づけることも可能です。（下図より）
![Tips3](/assets/basic-xib/images/tips3.png)
</details>


## 複数のラベルを設置しよう

2つ目のラベルを配置しましょう。次のラベルは `descriptionLabel` とします。これは、 `titleLabel` の8px下に設置します。

1. 配置
    1つ目と同様の手順により、XIB上に配置します。大体おきたいところを目安にドラッグ&ドロップしましょう。（図11）
    ![図11](/assets/basic-xib/images/figure11.png)
    *図11*

2. 縦の制約をつける
    続いて、画面下部の `Add New Constraints` アイコンを押し、AutoLayoutの設定を行います。 `titleLabel` より8px下に設置したいので、図12のように上の制約をつけます。
    ![図12](/assets/basic-xib/images/figure12.png)
    *図12*

    制約をつけるときには、ターゲットとなるビューの選択を確認しましょう。（図13）
    ![図13](/assets/basic-xib/images/figure13.png)
    *図13*

3. 横の制約をつける
    最後に横の制約をつけましょう。
    図12の画面で左右に余白を設定しても良いですが、今回は画面中央に指定します。
    `Align` アイコンより `Horizontally in Continer` にチェックを入れましょう。（図14）
    ![図14](/assets/basic-xib/images/figure14.png)
    *図14*

これで2つ目のラベルの配置が完了しました。
コード上での設定が不要な場合は、接続はしなくても大丈夫です。

## レイアウトを調整する

まずは `titleLabel` のフォントサイズを大きくしましょう。
XIB上で Hello World を選択し、 `Show the Attributes inspector` アイコンより、Fontを変更します。（図15）

![図15](/assets/basic-xib/images/figure15.png)
*図15*

また、`descriptionLabel` のテキストも変更しました。

最後に画面の中心から少し上の方にずらしてみましょう。 `titleLabel` の水平方向のラインを選択し、右側の `Show the Attributes inspector` アイコンより、 `Constant` を変更します。（図16）

![図16](/assets/basic-xib/images/figure16.png)
*図16*

## 複数のラベルを配列で接続する

コードへ接続するときには、複数のラベルをまとめて配列に入れることもできます。
1. 先にコードに以下のように `IBOutlet` をつけた配列を用意します。

   ```swift
    @IBOutlet private var labels: [UILabel] = []
   ```

2. 配列に入れたいラベルに接続させます。（図17）
   
    ![図17](/assets/basic-xib/images/figure17.png)
    *図17*

3. XIBの `Outlet Collections` に追加されていることを確認します。（図18）

    ![図18](/assets/basic-xib/images/figure18.png)
    *図18*

4. コード上でラベルの色をまとめて変更してみましょう。

    forEachを使い、ラベルの色をまとめて変更します。
    ```swift
    @IBOutlet private var labels: [UILabel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ラベルの色をまとめて変更する
        labels.forEach {
            $0.textColor = .systemBlue
        }
    }
    ```

これで、本レシピのUIを実装することができました。

## おわりに

XIBを用いたコンポーネントの配置方法の基本は以上になります。
Storyboardを用いる場合も同様に Interface Builder 上での設置を行い、コードへの紐付けを行います。

それぞれのコンポーネントごとの使い方は、今後追加していく予定です。

