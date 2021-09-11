---
title: "Introducing SwiftLint"
category: "introduction"
description: "Install SwiftLint to make your iOS project code clean and unified. This will be essential to maintain the quality of your code."
published: false
---

Install `SwiftLint` to make your project code clean and unified. This will be essential to maintain the quality of your code.

## About SwiftLint

`SwiftLint` is a static analysis tool for adding Swift styles and conventions. The conventions are based on the [GitHub Swift Style Guide](https://github.com/github/swift-style-guide).

[realm/SwiftLint: A tool to enforce Swift style and conventions.](https://github.com/realm/SwiftLint)

## Install with Mint

In this article, I will show you how to install `SwiftLint` using `Mint`. For other methods, please check [README.md](https://github.com/realm/SwiftLint#installation).

[Mint](https://github.com/yonaskolb/Mint) is package manager that installs and runs Swift command line tool packages.

<details><summary>Installing Mint</summary>

```bash
// Install Mint
$ brew install mint
// Check Version
$ mint version
```
</details>

1. Installing
    Create a `Mintfile` in the root of your project.
    ```bash
    cd ProjectName
    touch Mintfile
    ```

    ```
    .
    ├─ ProjectName.xcodeproj
    ├─ ProjectName
    └─ Mintfile
    ```

    Write the following in your `Mintfile`.

    ```
    realm/SwiftLint@0.44.0
    ```

    Do a `mint bootstrap` where the `Mintfile` is located.

    ```bash
    mint bootstrap
    ```

    Verify that it is installed with `mint list`.
    ```bash
    mint list
    ```

2. Add a Run Script
    Open your project in Xcode, open `TARGETS` > `BuidPhases`, and select `New Run Script Phase` from the + button.（Fregure 1）
    ![Figure 1](/assets/swiftlint/images/figure1.png)
    *Figure 1*

    Add the following Script.(Figure 2）
    ```shell
    if which mint >/dev/null; then
    mint run swiftlint swiftlint autocorrect --format
    mint run swiftlint swiftlint
    else
    echo "warning: Mint not installed, download from https://github.com/yonaskolb/Mint"
    fi
    ```

    ![Figure 2](/assets/swiftlint/images/figure2.png)
    *Figure 2*

3. Add .swiftlint.yml
   Create a `.swiftlint.yml` in the root of your project.
    ```
    .
    ├─ ProjectName.xcodeproj
    ├─ ProjectName
    ├─ Mintfile
    └─ .swiftlint.yml
    ```
    
    In this file, you can change or disable detailed rules.

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

    In `included`, describe the target.
    `excluded` describes the files to be excluded. If you use it with `R.swift`, add `R.generated.swift` here.

    For more rules, see SwiftLint's [README](https://github.com/realm/SwiftLint#configuration).

4. Let's build.
   If the `.swiftlint.yml` is not reflected, do a clean build (⌘+Shift+K) and build it again. If it still doesn't work, make sure that the yaml (Be careful of extra spaces, etc.)

   When checking if SwiftLint is working correctly, write a statement that violates the rule and build it to check it, as shown below. (Figure 3)

    ```swift
    let i = 1
    ```

    ![Figure 3](/assets/swiftlint/images/figure3.png)
    *Figure 3*

## Disable rules in code

SwiftLint allows you to avoid errors by explicitly adding a comment in your code to disable the rule.
For example, the error in Figure 3 can be avoided as Figure 4.

```swift
let i = 1 // swiftlint:disable:this identifier_name
```
![Figure 4](/assets/swiftlint/images/figure4.png)
*Figure 4*

## Conclusion

Of course, SwiftLint can be used on its own, but we recommend that you try building an environment with the following recipe.

1. [Create a project, Application development using XIB.](https://swift-recipes.doshcook.com/recipes/create-project)
2. [Introducing R.swift](https://swift-recipes.doshcook.com/recipes/rswift)

SwiftLint has a lot more to offer. Please see [GitHub](https://github.com/realm/SwiftLint) for more information.