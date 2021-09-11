---
title: "Introducing R.swift"
category: "environment"
description: ""
order: 2
published: true
---

`R.swift` is very useful for development with `xib`, so please install it.
It will be used in many of the recipes on this site.

## About R.swift

`R.swift` is a library that makes resource management easier. By typing resources, there is no need to hardcode strings, and autocomplete functions can be used.

[mac-cain13/R.swift: Strong typed, autocompleted resources like images, fonts and segues in Swift projects](https://github.com/mac-cain13/R.swift)

*Without R.swift*
```swift
// Register Cell
collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cell")

// Reuse Cell
let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

// Create ViewController
let viewController = ViewController(nibName: "ViewController", bundle: nil)
```

*Using R.swift*
```swift
// Register Cell
collectionView.register(R.nib.customCollectionViewCell)

// Reuse Cell
let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.customCollectionViewCell, for: indexPath)!

// Create ViewController
let viewController = ViewController(nib: R.nib.viewController)
```

### Install with Mint

In this article, I will show you how to install `R.swift` using `Mint`. For other methods, please check [README.md](https://github.com/mac-cain13/R.swift).

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
    mac-cain13/R.swift

    // With version specified
    mac-cain13/R.swift@v5.3.1
    ```

    Do a `mint bootstrap` where the `Mintfile` is located.

    ```bash
    mint bootstrap
    ```

2. Add a Run Script
   
    Open your project in Xcode, open `TARGETS` > `BuidPhases`, and select `New Run Script Phase` from the + button.（Fregure 1）
    ![Figure 1](/assets/rswift/images/figure1.png)
    *Figure 1*

    Add the following Script.(Figure 2）
    ```shell
    if mint list | grep -q 'R.swift'; then
    mint run R.swift rswift generate "$SRCROOT/ProjectName/Scripts/R.generated.swift"
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
    $SRCROOT/ProjectName/Scripts/R.generated.swift
    ```

    Add `Input Files` and `Output Files` respectively. (Figure 2)

    ![Figure 2](/assets/rswift/images/figure2.png)
    *Figure 2*

    Finally, bring it in front of `Compile Sources` (Figure 3) and build it.

    ![Figure 3](/assets/rswift/images/figure3.png)
    *Figure 3*

    Be sure to move the scripts after Compile Sources, as placing them there may cause errors.

3. Add R.generated.swift to the project
    
    After building the file as described in step 2, `R.generated.swift` will be generated in the location specified in `Output Files`, so add it to Xcode. (Figure 4)

    ![Figure 4](/assets/rswift/images/figure4.png)
    *Figure 4*

    When adding, uncheck `Copy If Needed`. (Figure 5)
    ![Figure 5](/assets/rswift/images/figure5.png
    *Figure 5*


4. Installing R.swift.Library with Swift Package Manager
    To actually use the generated `R.generated.swift`, we will install `R.swift`.

    [mac-cain13/R.swift.Library: Library containing types used by the R.swift project](https://github.com/mac-cain13/R.swift.Library)

    Select `File` > `Swift Packages` > `Add Package Dependency` from the Xcode navigation bar. (Figure 6)

    ![Figure 6](/assets/rswift/images/figure6.png)
    *Figure 6*

    Enter `https://github.com/mac-cain13/R.swift.Library` in the `Enter package repositry URL` field. (Figure 7)

    ![Figure 7](/assets/rswift/images/figure7.png)
    *Figure 7*

    For `Version Rules`, I specified `Update Next Minor`. (Figure 8)

    ![Figure 8](/assets/rswift/images/figure8.png)
    *Figure 8*
    
    Select only `R.swift` to complete. (Figure 9)

    ![Figure 9](/assets/rswift/images/figure9.png)
    *Figure 9*


Now you can install R.swift.

## Ignore R.generated.swift in .gitignore

The file `R.generated.swift` is generated automatically. This file should be removed from Git's control.

Add this to `.gitignore`.
```text
R.generated.swift
```

If it has already been managed, delete the cache and remove it from the repository.
```bash
git rm --cached `git ls-files --full-name -i --exclude-standard`
```



