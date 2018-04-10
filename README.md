# SwiftyGestureRecognizer

![Platforms](https://img.shields.io/badge/platforms-ios-lightgrey.svg)
![Swift version](https://img.shields.io/badge/language-swift-ff69b.svg)
![CocoaPods](https://img.shields.io/cocoapods/l/AFNetworking.svg)

__This project is already available but needs a lot of functionalities__<br>


## WT# is SwiftyGestureRecognizer ?

#### Modern Swift API for `UIGestureRecognizer`
###### SwiftyGestureRecognizer makes Gesture Recognizer API easy to use in the simplest way.

:construction::construction: _Project is not completely set. CocoaPods is not available for now._ :construction::construction:

## Usage

#### Initialization

```swift
import SwiftyGestureRecognizer
```

#### Install

You will need to attach the gesture on the `UIView` you want by calling the class function `install(_:UIView)`

```swift
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    GestureRecognizer.install(contactLabel).pressed { (label, recognizer) in
        label.textColor = .red
    }
}
```

#### Uninstall

Do no miss to uninstall before the view will disappear by calling the class function `uninstallAll()`

```swift
override func viewWillDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    GestureRecognizer.uninstallAll() // uninstall all recognizers
}
```

## And after ?

#### Remaining work

SwiftyGestureRecognizer is made to ensure the complete UIGestureRecognizer API, we need to take care about all methods.

Expected work:

- `UIPinchGestureRecognizer`
- `UIRotationGestureRecognizer`
- `UISwipeGestureRecognizer`
- `UIPanGestureRecognizer`
- `UIScreenEdgePanGestureRecognizer`
- `UILongPressGestureRecognizer`

# Communications

* If you'd like to __ask a general question__, use Stack Overflow.
* If you __found a bug__, and can provide steps to reliably reproduce it, open an issue.
* If you want to __contribute__, submit a pull request.

# Licence

SwiftyGestureRecognizer is available under the MIT license. See the LICENSE file for more info.
