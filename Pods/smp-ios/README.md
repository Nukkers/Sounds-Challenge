# SMP-iOS
For extended documentation pertaining to the objectives and advanced usage of this library, please see the [wiki](https://github.com/bbc/smp-ios/wiki). 
Release notes from version 36.4.0 onwards are available [on Confluence](https://confluence.dev.bbc.co.uk/display/PLAYBACKSMP/iOS). Notes from before this are still available only via [GitHub](https://github.com/bbc/smp-ios/wiki/Release-Notes).

## Building 

Please consult the [building guidelines](.github/BUILDING.md) for instructions regarding building MAP components.

## Supported OS versions
Supports iOS 8.0 and later.
Experimental support for tvOS 9.0 and later
**Note:** we only support SMP as a framework when installed through Cocoapods

## Example App
To use the test harness, open the `BBCSMPTestHarness.xcworkspace` file under the `BBCSMPTestHarness/` directory. There is a scheme for running the test harness `AVTestHarness`, which builds SMP using Cocoapods

For tvOS, use the `BBCSMPTestHarness-tvOS` scheme.

# Quickstart
Follow the steps below to quickly intergrate SMP into your project. For advanced usage of the library, make sure to read through the [wiki](https://github.com/bbc/smp-ios/wiki).

## Cocoapods
Add `smp-ios` as a pod in your Podfile:

    pod 'smp-ios'
    
You'll need to specify the source repository for the podspec at the top of your podfile:

    source 'git@github.com:bbc/map-ios-podspecs.git'
    
## Initialize a Player Item Provider
You'll need to instantiate a new `BBCSMPItemProvider` for providing playable content to the player:

#### Swift:
```swift
let playerItemProvider = BBCSMPMediaSelectorPlayerItemProvider(mediaSet: "apple-iphone4-hls", vpid: "b05x8k76")
```

#### Objective C:
```objc
BBCSMPMediaSelectorPlayerItemProvider *playerItemProvider = [[BBCSMPMediaSelectorPlayerItemProvider alloc] initWithMediaSet:@"apple-iphone4-hls" vpid:@"b05x8k76"];
```

## Present The Player
You can either instantiate an appropriate `UIView` for embedding SMP within an existing view in your application, or present a  `UIViewController` for presenting the player in full-screen.

### Embedded

#### Swift:
```swift
let playerItemProvider: BBCSMPMediaSelectorPlayerItemProvider = ...
let playerFrame: CGRect = ...
let brand: BBCSMPBrand = ...
let fullscreenPresenter: BBCSMPPlayerViewFullscreenPresenter = ...
let player: BBCSMP = BBCSMPPlayerBuilder.init().withPlayerItemProvider(playerItemProvider).build()
let playerView = player.buildUserInterface().withFrame(playerFrame).withBrand(brand).withFullscreenPresenter(fullscreenPresenter).buildView()

self.view.addSubview(playerView)
```

#### Objective C:
```objc
id<BBCSMPItemProvider> itemProvider = ...;
CGRect playerFrame = ...;
BBCSMPBrand *brand = ...;
id<BBCSMPPlayerViewFullscreenPresenter> fullscreenPresenter = ...;
id<BBCSMP> player = [[[BBCSMPPlayerBuilder new] withPlayerItemProvider:itemProvider] build];
UIView *playerView = [[[[[player buildUserInterface] withFrame:playerFrame] withBrand:brand] withFullscreenPresenter:fullscreenPresenter] buildView];

[self addSubview:playerView];
```

### Full Screen

#### Objective C:
```objc
id<BBCSMPItemProvider> itemProvider = ...;
CGRect playerFrame = ...;
BBCSMPBrand *brand = ...;
id<BBCSMP> player = [[[BBCSMPPlayerBuilder new] withPlayerItemProvider:itemProvider] build];
UIViewController *playerViewController = [[[[player buildUserInterface] withFrame:playerFrame] withBrand:brand] buildViewController];

UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:playerViewController];
[self presentViewController:navigationController animated:YES completion:nil];
```
#### Swift:
```swift
let playerItemProvider: BBCSMPMediaSelectorPlayerItemProvider = ...
let playerFrame: CGRect = ...
let brand: BBCSMPBrand = ...
let player: BBCSMP = BBCSMPPlayerBuilder.init().withPlayerItemProvider(playerItemProvider).build()
let playerViewController: UIViewController = player.buildUserInterface().withFrame(playerFrame).withBrand(brand).buildViewController()

let navigationController: UINavigationController = UINavigationController.init(rootViewController: playerViewController)
self.presentViewController(navigationController, animated: true, completion: nil)
```

### Headless
You can also create instances of `BBCSMPPlayer` without any UI, in the event either embedded or full screen presentations do not fit your use case. See the [wiki](https://github.com/bbc/smp-ios/wiki/Headless-Player) for further details.


## Customisation
You can customise the asthetics and behaviour of your player by using [brandings](https://github.com/bbc/smp-ios/wiki/Branding) and [configurations](https://github.com/bbc/smp-ios/wiki/Configuration). Please see the relevant wiki pages for more information.


### Supporting fullscreen mode
The player-view can support automatic transitioning between the view and a fullscreen view-controller - in order to do this, you must implement the BBCSMPPlayerViewFullscreenPresenter protocol:

```objc
@protocol BBCSMPPlayerViewFullscreenPresenter <NSObject>

- (void)enterFullscreenByPresentingViewController:(UIViewController *)viewController completion:(void (^)(void))completion;
- (void)leaveFullscreenByDismissingViewController:(UIViewController *)viewController completion:(void (^)(void))completion;

@end
```

Your implementation of `enterFullscreenByPresentingViewController:completion:` should present the view-controller that's passed (generally modally) and then call the completion block, whilst your implementation of `leaveFullscreenByDismissingViewController:completion:` should dismiss the presented view-controller and then call the completion block. You don't need to do more than that - the player-view will handle detaching the player from itself and attaching it to the fullscreen view-controller.

**NOTE:** If you don't supply a fullscreen presenter, the fullscreen button on the player just switches the player-layer's gravity between filling its bounds and respecting the aspect ratio of the video.

### Plugins
SMP can be extended further through plugins. See the [wiki](https://github.com/bbc/smp-ios/wiki/Plugins) page for an overview about creating your own!


### Contributions
Please read the [contributions guidelines](https://github.com/bbc/smp-ios/blob/master/CONTRIBUTING.md).

### App Store Rejections for `UIBackgroundModes audio`
Apple has been known to reject apps (including iPlayer Kids) for using the `UIBackgroundModes audio` key and then not doing anything in the background with Audio. SMP does precisely this to allow videos to continue playing when the app is backgrounded (such as the device screen being locked). Indeed, Apple themselves even recommend doing this in their [technical Q&A](https://developer.apple.com/library/ios/qa/qa1668/_index.html) for video playback. According to a number of StackOverflow posts, many people have successfully appealed their rejection by citing this Q&A document, so until Apple fix the underlying issue and specify a `UIBackgroundMode airplay` key, you may need to cite this document when undergoing an App Store review.

## Known Issues
 
We'd like to keep track of general issues we've experienced and are aware of here. A JIRA ticket will be provided where approriate.
 
Date added: 26th June 2017 
 
**Found on iPhone 6 (9.2.1)**
* Finding that Live Rewind is pinging back to live when I have scrubbed back within the 2hr window. Seems to happen when you pause, scrub back and resume playback.

**Likely to affect all iOS devices** 
* The AirPlay icon seems to appear/disappear fairly regularly. Seen this disappear when in embedded and full-screen mode.


