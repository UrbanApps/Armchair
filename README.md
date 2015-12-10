![Armchair: A simple yet powerful App Review Manager for iOS and OSX in Swift](https://raw.githubusercontent.com/UrbanApps/Armchair/assets/armchair.png)

Armchair is a simple yet powerful App Review Manager for iOS and OSX written in Swift. It is based on [UAAppReviewManager](https://github.com/UrbanApps/UAAppReviewManager) and [Appirater](https://github.com/arashpayan/appirater) but completely rewritten for apps that want to benefit from the power of this new language.

## Why Armchair?

The average end-user will only write a review if something is wrong with your App. This leads to an unfairly negative skew in the ratings, when the majority of satisfied customers don’t leave reviews and only the dissatisfied ones do. In order to counter-balance the negatives, Armchair prompts the user to write a review, but only after the developer knows they are satisfied. For example, you may only show the popup if the user has been using it for more than a week, and has done at least 5 significant events (the core functionality of your App). The rules are fully customizable for your App and easy to setup.

Here are just a few of the things that make Armchair better than the other rating frameworks and repos:

<img align="center" src="https://raw.githubusercontent.com/UrbanApps/Armchair/assets/swift.png">

While the tests to prove it seem to be missing, Apple claims that Swift is a lot faster than Objective-C. Enjoy the benefits of using a framework built entirely in Swift, and work with a familiar syntax without having to deal with bridging headers or other Objective-C shenanigans.

##### Both iOS and OS X Support

Many developers publish apps for both iOS and OS X. Out of the box, Armchair supports iOS and OS X apps that are sold through the respective App Stores. The API is the same for both with the exception of a handful of iOS specific functions, described in [Usage](#usage).

##### Fully Configurable at Runtime

Armchair is fully configurable, even at runtime. This means that the prompt you display can be dynamic, based on the end-user's score or status. The rules that govern how and when it should be shown can all be set the same way, allowing you to have the most control over the presentation and timing of your review prompt.

##### Default Localizations for Dozens of Languages

If you choose to use the default Armchair strings for your app, you will get the added benefit of localization in over 32 languages. Otherwise, customization is easy, and overriding the localization strings is a piece of cake, simply by including your own strings files and letting Armchair know.


##### Prevent Rating Prompts on Different Devices

If your users have the same app, same version installed on two different devices, you really shouldn't pop up the same rating prompt on each one. Armchair allows you to optionally keep your user's usage stats in the `NSUbiquitousKeyValueStore`, or any other store you want to keep track of syncing yourself to prevent dual prompts.

##### Uses UIApplication/NSApplication Lifecycle Notifications

Armchair listens for ApplicationDidLaunch and ApplicationWillEnterForeground notifications. This allows you to worry about your app, and not about tracking in your application delegate functions, so there are fewer lines of code for you to write.

##### Easy to Setup

It takes only 1 line of code to get started. Armchair is very powerful when digging under the hood, but also very simple to setup for standard configurations.

##### iTunes Affiliate Codes

If you are an iTunes Affiliate, you can easily setup Armchair to use your code and campaign. Full disclosure: If you aren't an iTunes Affiliate, the default code used in the app is the author's. It is better to have somebody's code rather than nobody's, so please leave it at the default setting if you aren't going to set one yourself. Think of it as a small token of appreciation for creating and open-sourcing Armchair.

##### Ready For Primetime

Armchair is clean code, well documented and well organized. It is easy to understand the logic flow and the purpose of each function. It doesn't mix logic up randomly between Class functions and Instance functions. It's API is clean and predictable.

---

<a name="the-golden-rule">![The Golden Rule](https://raw.githubusercontent.com/UrbanApps/Armchair/assets/golden-rule.png)</a>

1. Don't be a dick.

Seriously. It is easy to piss off your customers by not really considering how the prompting popup interrupts their flow. This was widely discussed in early 2014 by many well-known tech bloggers and caused a big hooplah in the community.

We think that having an app review prompt is fine, but only when presented at the right time, and only when you don't ask too frequently. The criteria for the smart display of a prompt varies for each app, but consider adding one at the end of a positive user workflow, rather than the beginning.

Tweak the variables so that you don't annoy your customers, and you will enjoy the maximum benefit from your app review prompting.

---

## Screenshots

![iOS Example Shots](https://raw.githubusercontent.com/UrbanApps/Armchair/assets/armchair-iOS.png)
![Mac Example Shots](https://raw.githubusercontent.com/UrbanApps/Armchair/assets/armchair-OSX.png)

## Requirements

- Xcode 6.1+
- iOS 8.0+, Mac OS X 10.10+

## Installation

> **Embedded frameworks require a minimum deployment target of iOS 8 or OS X Mavericks (10.9).**
>
> Armchair is no longer supported on iOS 7 due to the lack of support for frameworks. Without frameworks, running Travis-CI against iOS 7 would require a second duplicated test target. The separate test suite would need to import all the Swift files and the tests would need to be duplicated and re-written. This split would be too difficult to maintain to ensure the highest possible quality of the Armchair ecosystem.

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 0.39.0+ is required to build Armchair.

To integrate Armchair into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
platform :osx, '10.10'
use_frameworks!

pod 'Armchair', '~> 0.1.1'
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

Once you [install](https://github.com/Carthage/Carthage#installing-carthage) Carthage, you can integrate Armchair into your Xcode project by specifying it in your `Cartfile`:

```ogdl
github "UrbanApps/Armchair"
```

Run `carthage update` to build the framework and drag the built `Armchair.framework` into your Xcode project.

## Usage

### Simple 1-line Setup

Armchair includes sensible defaults as well as reads data from your localized, or unlocalized `info.plist` to set itself up. While everything is configurable, the only **required** item to configure is your App Store ID. This call is the same for iOS and Mac apps, and should be made as part of your App Delegate's `initialize()` function

    Armchair.appID("12345678")
        
That's it to get started. Setting Armchair up with this line uses some sensible default criterion (detailed below) and will present a rating prompt whenever they are met.

### Custom Configuration

Optionally, if you are using significant events in your app to track when the user does something of significance, add this line to any place where this event happens, such as a `levelDidFinish` function, or `userDidUploadPhoto` function.
 
    Armchair.userDidSignificantEvent(true)

In order for this to mean anything to Armchair, you also have to set the threshold for significant events. Typically, this, and all other logic configuration settings, should be made as part of your App Delegate's `initialize()` function so it can get the notifications on app launch.

    Armchair.significantEventsUntilPrompt(5)
    
As mentioned above, the `appID` is the only required item to configure. It is used to generate the URL that will link to the page. Most often, this is configured to the App that is currently running, but there may be an instance where you want to set it to another app, such as in an App that reviews other Apps.

    GETTER: Armchair.appID() -> String
    SETTER: Armchair.appID(appID: String)
    
##### Display Strings

The `appName` is used in several places on the review prompt popup. It can be configured here to customize your message without losing any of the default localizations. By default, Armchair will read the value from your localized, or unlocalized `info.plist`, but you can set it specifically if you want.

    GETTER: Armchair.appName() -> String
    SETTER: Armchair.appName(appName: String)

The `reviewTitle` is the title to use on the review prompt popup. It's default value is a localized "Rate \<appName\>", but you can set it to anything you want.

    GETTER: Armchair.reviewTitle() -> String
    SETTER: Armchair.reviewTitle(reviewTitle: String)

The `reviewMessage` is the message to use on the review prompt popup. It's default value is a localized "If you enjoy using \<appName\>, would you mind taking a moment to rate it? It won't take more than a minute. Thanks for your support!", but you can change it specifically if you want. However, if you do change it, you will need to provide your own localization strings as shown farther down below.

    GETTER: Armchair.reviewMessage() -> String
    SETTER: Armchair.reviewMessage(reviewMessage: String)

The `cancelButtonTitle` is the button title to use on the review prompt popup for the "Cancel" action. Its default value is a localized "No, Thanks"

    GETTER: Armchair.cancelButtonTitle() -> String
    SETTER: Armchair.cancelButtonTitle(cancelButtonTitle: String)

The `rateButtonTitle` is the button title to use on the review prompt popup for the "Rate" action. Its default value is a localized "Rate \<appName\>"

    GETTER: Armchair.rateButtonTitle() -> String
    SETTER: Armchair.rateButtonTitle(rateButtonTitle: String)

The `remindButtonTitle` is the button title to use on the review prompt popup for the "Remind" action. Its default value is a localized "Remind me later"

    GETTER: Armchair.remindButtonTitle() -> String
    SETTER: Armchair.remindButtonTitle(remindButtonTitle: String)

##### Logic

The `daysUntilPrompt` configuration determines how many days the users will need to have the same version of your App installed before they will be prompted to rate it. It's default is 30 days.

    GETTER: Armchair.daysUntilPrompt() -> UInt
    SETTER: Armchair.daysUntilPrompt(daysUntilPrompt: UInt)

The `usesUntilPrompt` configuration determines how many times the user will need to have 'used' the same version of you App before they will be prompted to rate it. Its default is 20 uses.

	GETTER: Armchair.usesUntilPrompt() -> UInt
	SETTER: Armchair.usesUntilPrompt(usesUntilPrompt: UInt)

An example of a 'use' would be if the user launched the app, or brings it to the foreground. Armchair keeps track of these internally by listening to UIApplication/NSApplication lifecycle notifications. 

As discussed briefly above, the `significantEventsUntilPrompt` configuration determines how many "significant events" the user will need to have before they will be prompted to rate the App. It defaults to 0 significant events.
	
    GETTER: Armchair.significantEventsUntilPrompt() -> UInt
    SETTER: Armchair.significantEventsUntilPrompt(significantEventsUntilPrompt: UInt)

A significant event can be anything you want to be in your app. In a telephone app, a significant event might be placing or receiving a call. In a game, it might be beating a level or a boss. This is just another layer of filtering that can be used to make sure that only the most loyal of your users are being prompted to rate you on the app store. If you leave this at a value of 0 (default), then this won't be a criterion used for rating. To tell Armchair that the user has performed a significant event, call the function:

    Armchair.userDidSignificantEvent(canPromptForRating: Bool)

The `daysBeforeReminding` configuration determines how many days Armchair will wait before reminding the user to rate again, should they select the "Remind Me Later" option on the first alert. It defaults to 1 day. A value of 0 will remove the "Remind Me Later" button and disable this feature.
	
	GETTER: Armchair.daysBeforeReminding() -> UInt
	SETTER: Armchair.daysBeforeReminding(daysBeforeReminding: UInt)

The `tracksNewVersions` configuration determines whether or not Armchair should track a new app version if detected. By default, Armchair tracks **all** new bundle versions. When it detects a new version, it resets the values saved for usage, significant events, popup shown, user action etc... By setting this to `NO` Armchair will **only** track the version it was initialized with, or the one it last knew about. If this setting is set to `true`, Armchair will reset itself after each new version detection. Its default value is `true`.

	GETTER: Armchair.tracksNewVersions() -> Bool
	SETTER: Armchair.tracksNewVersions(tracksNewVersions: Bool)

The `shouldPromptIfRated` configuration determines whether or not to show the review prompt to users who have rated the app once before. This setting is a little like the `tracksNewVersions` setting, but a little less nuclear. Setting this to `false` will cause new users of the app to get the popup, but won't ask users who have already been asked for a popup in the past. This is useful if you release small bug-fix versions and don't want to pester your existing users with popups for every minor version, but want to ensure new users get prompted for a review. For example, you might set this to false for every minor build, then when you push a major version upgrade, leave it as true to ask for a rating again. Its default value is `true`.
	
    GETTER: Armchair.shouldPromptIfRated() -> Bool
	SETTER: Armchair.shouldPromptIfRated(shouldPromptIfRated: Bool)

The `useMainAppBundleForLocalizations` configuration is a way to tell Armchair that you are providing your own translations for the review prompt popup strings. This may be because you are just customizing them, or that you have set your own text for the popup. If set to `true`, the main bundle will always be used to load localized strings. If set to `false` Armchair will look in its own translation bundle for the translating strings. It's default value is `false`.
	
	GETTER: Armchair.useMainAppBundleForLocalizations() -> Bool
	SETTER: Armchair.useMainAppBundleForLocalizations(useMainAppBundleForLocalizations: Bool)
	
##### Affiliate Codes

The `affiliateCode` configuration is optional and is used to configure with the review URL. If you are an Apple Affiliate, enter your code here. If none is set, the author's code will be used as it is better to be set as something rather than nothing. If you want to thank me for making Armchair, feel free to leave this value at it's default.


	GETTER: Armchair.affiliateCode() -> String
    SETTER: Armchair.affiliateCode(affiliateCode: String)

The `affiliateCampaignCode` configuration is optional and is used to configure the review URL. It provides context to the affiliate code and defaults to "Armchair-\<appID\>".
	
    GETTER: Armchair.affiliateCampaignCode() -> String
    SETTER: Armchair.affiliateCampaignCode(affiliateCampaignCode: String)

##### Debug Mode

The `debugEnabled` configuration is useful for testing how your review prompt popup looks and for testing. Setting it to `true` will show the Armchair alert every time by tricking the app into thinking the conditions for a prompt have been met. Calling this function in a production build (determined when `Debug` swift compiler flag is *not* defined) has no effect. In App Store builds, you don't have to worry about accidentally leaving debug on. The default value of `debugEnabled` is `false`.
	
	GETTER: Armchair.debugEnabled() -> Bool
	SETTER: Armchair.debugEnabled(debugEnabled: Bool)

##### iOS Only Configuration

These configuration functions only make sense for iOS builds due to their dependency on iOS-only frameworks and functions.

The `usesAnimation` configuration determines whether or not Armchair uses animation when presenting a modal `SKStoreProductViewController`. Its default value is `true`.

    GETTER: Armchair.usesAnimation() -> Bool
	SETTER: Armchair.usesAnimation(usesAnimation: Bool)

The `usesAlertController` configuration determines whether or not Armchair uses a UIAlertController when presenting an alert on iOS 8. By default, we do not use it because the reordering of buttons is not possible in the alert controller as of iOS 8.0. It's default value is `false`. Changing this value does not affect iOS 7 at all.
    
	GETTER: Armchair.usesAlertController() -> Bool
	SETTER: Armchair.usesAlertController(usesAnimation: Bool)
	
The `opensInStoreKit` configuration determines if Armchair will open the App Store link inside the App using a `SKStoreProductViewController`. By default, this is `false` on iOS 7, and `true` on iOS 8.
	
    GETTER: Armchair.opensInStoreKit() -> Bool
	SETTER: Armchair.opensInStoreKit(opensInStoreKit: Bool)
    
There are 2 reasons why the default is `false` on iOS 7.

- The SKStoreProductViewController __does not allow the user to write a review__ (as of iOS 7)!
- iTunes affiliate codes do not work (as of iOS 7) inside SKStoreProductViewController.

### Armchair Functions

`userDidSignificantEvent(canPromptForRating: Bool)` tells Armchair that the user performed a significant event. A significant event is whatever you want it to be. If your app is used to make VoIP calls, then you might want to call this function whenever the user places a call. If it's a game, you might want to call this whenever the user beats a level boss. If the user has performed enough significant events and used the app enough, you can suppress the rating alert by passing `NO` for `canPromptForRating`. The rating alert will simply be postponed until it is called again with `true` for `canPromptForRating`. The rating alert can also be triggered by `appLaunched:` and `appEnteredForeground:` notifications.

    Armchair.userDidSignificantEvent(canPromptForRating: Bool)

In addition to the above functions that can trigger the presentation of the prompt, there is a closure based variant that allows you to customize whether or not this is an appropriate time to display the prompt.

    Armchair.userDidSignificantEvent(shouldPrompt: ArmchairShouldPromptClosure)

Read more about these functions below in the [Should-Prompt Closure](#should-prompt-closure) section.    


`showPrompt()` tells Armchair to show the review prompt alert. The prompt will be showed if there is an internet connection available, the user hasn't already declined to rate, hasn't rated the current version and you are tracking new versions. You could call to show the prompt regardless of Armchair settings, for instance, in the case of some special event in your app like positive feedback given.

	Armchair.showPrompt()

`showPrompt(ifNecessary: Bool)` tells Armchair to show the review prompt alert if all restrictions have been met. The prompt will be shown if all restrictions are met, there is an internet connection available, the user hasn't declined to rate, hasn't rated current version, and you are tracking new versions. You could call to show the prompt, for instance, in the case of some special event in your app like a user login.

    Armchair.showPrompt(ifNecessary: Bool)

The `reviewURLString()` function is the review URL string, generated by substituting the `appID`, `affiliateCode` and `affiliateCampaignCode` into the template URL for the current platform.

    Armchair.reviewURLString() -> String

`rateApp()` tells Armchair to open the App Store page where the user can specify a rating for the app. It also records the fact that this has happened, so the user won't be prompted again to rate the app for this version. The only case where you should call this directly is if your app has an explicit "Rate this app" command somewhere.  In all other cases, don't worry about calling this — instead, just call the other functions listed above, and let Armchair handle the bookkeeping of deciding when to ask the user whether to rate the app.

    Armchair.rateApp()

##### iOS Only Functions

`closeModalPanel()` tells Armchair to immediately close any open rating modal panels for instance, a `SKStoreProductViewController`.

    Armchair.closeModalPanel()

### Closures

Armchair uses optional closures instead of delegate functions for callbacks. Default is nil for all of them.
	
    Armchair.onDidDisplayAlert(didDisplayAlertClosure: ArmchairClosure?)
    Armchair.onDidDeclineToRate(didDeclineToRateClosure: ArmchairClosure?)
    Armchair.onDidOptToRate(didOptToRateClosure: ArmchairClosure?)
    Armchair.onDidOptToRemindLater(didOptToRemindLaterClosure: ArmchairClosure?)    

##### iOS Only Closures

   	Armchair.onWillPresentModalView(willPresentModalViewClosure: ArmchairAnimateClosure?)
   	Armchair.onDidDismissModalView(didDismissModalViewClosure: ArmchairAnimateClosure?)

##### Should-Increment Closure

    Armchair.shouldIncrementUseCountClosure(shouldIncrementUseCountClosure: ArmchairShouldIncrementClosure?)

By default Armchair increments the use count every time the app enters the foreground.  If you want to suppress  this behavior (i.e. not counting a foreground event caused by switching apps during a Facebook login) you can do so with a ArmchairShouldIncrementClosure that returns `false` to ignore a foreground event or `true` to count it as normal.

##### Should-Prompt Closure

Armchair allows you to set a closure that is called immediately preceding the display of the popup.
	
	public typealias ArmchairShouldPromptClosure = (ArmchairTrackingInfo) -> Bool
    
The `ArmchairShouldPromptClosure` passes you the keys and values Armchair used to determine that the prompt should be called (found in the ArmchairTrackingInfo's `info` dictionary), and expects a `Bool` return value on whether or not the prompt should still be displayed. This allows you to have one last chance to do any of your own custom logic to determine whether or not this is an appropriate time to display the prompt.

    Armchair.shouldPromptClosure(shouldPromptClosure: ArmchairShouldPromptClosure?)
    

In addition to the global `shouldPromptClosure`, the Armchair functions that trigger the presentation of the prompt (`showPrompt(ifNecessary: Bool)` and `userDidSignificantEvent()`) have their own closure based variant that allows you to customize whether or not this is an appropriate time to display the prompt.

    Armchair.showPrompt(shouldPrompt: ArmchairShouldPromptClosure)
    Armchair.userDidSignificantEvent(shouldPrompt: ArmchairShouldPromptClosure)
    
When using these functions instead of their `Bool` sister-functions, none of the internal Armchair logic is used to determine whether or not to display the prompt. **Only** your closure is used to decide whether or not it should be presented, based solely on the return value you pass back in the closure. This also means that even the global `shouldPromptClosure()` (if set) will not be called when using these functions.

**Note:** The `shouldPromptClosure()` is run synchronous and on the main queue, so be sure to handle it appropriately.

### NSUserDefaults and Keys

Armchair has sensible defaults for the `NSUserDefaults` keys it uses, but you can customize that here if you want. Get/Set the `NSUserDefaults` keys that store the usage data for Armchair. Default values are all in the form of "\<appID\>_Armchair\<Setting\>"

    GETTER Armchair.keyForArmchairKeyType(keyType: ArmchairKey) -> String
    SETTER Armchair.setKey(key: NSString, armchairKeyType: ArmchairKey)

You don't have to use NSUserDefaults as your Key/Value store, though Armchair defaults to using it. If you want to sync your ratings and usage stats across all of your User's devices, you may want to use the `NSUbiquitousKeyValueStore` instead. This will ensure that the user won't be prompted to rate the same version of the same app on separate devices.

    GETTER Armchair.userDefaultsObject() -> ArmchairDefaultsObject?
    SETTER Armchair.userDefaultsObject(userDefaultsObject: ArmchairDefaultsObject?)

The `userDefaultsObject` can be any object that responds to the `ArmchairDefaultsObject` protocol — essentially a stripped-down version of the NSUserDefaults api:

    @objc public protocol ArmchairDefaultsObject {
    	func objectForKey(defaultName: String) -> AnyObject?
    	func setObject(value: AnyObject?, forKey defaultName: String)
    	func removeObjectForKey(defaultName: String)

    	func stringForKey(defaultName: String) -> String?
    	func integerForKey(defaultName: String) -> Int
    	func doubleForKey(defaultName: String) -> Double
    	func boolForKey(defaultName: String) -> Bool

    	func setInteger(value: Int, forKey defaultName: String)
    	func setDouble(value: Double, forKey defaultName: String)
    	func setBool(value: Bool, forKey defaultName: String)
    
    	func synchronize() -> Bool
	}

So, to use it with iCloud and the `NSUbiquitousKeyValueStore`, set up like so:

    Armchair.userDefaultsObject(NSUbiquitousKeyValueStoreSubclass.defaultStore())
    
...where you have a subclass that conforms to the protocol.
    
You can get/set the `keyPrefix` to the keys above that store the usage data for Armchair. The default value  is the `appID`, and it is prepended to the keys for key type. Setting a `keyPrefix` prevents different apps using a shared Key/Value store from overwriting each other.

    GETTER Armchair.keyPrefix() -> String
    SETTER Armchair.keyPrefix(keyPrefix: String)

### Configuration/Usage Examples

For more information on how to use and setup Armchair, please see the Example Project for both iOS and OS X Apps.

##  Armchair vs. Appirater

[Appirater](https://github.com/arashpayan/appirater) is great and has been used by many, many developers since its introduction in 2009. It has been updated throughout the years and suits the need of many people, yet leaves a ton left to be desired for the experienced developer. Appirater is:

- [ ] Not available in Swift
- [ ] Only available for iOS
- [ ] Mixes a bunch of class methods and instance methods unnecessarily
- [ ] Relies on a confusing mixture of MACROS and runtime configs for setup when either way would be better on its own
- [ ] Utilizes the ancient Delegate pattern for callbacks in the age of Blocks and Closures
- [ ] Is not able to be disabled on minor patch updates
- [ ] No iTunes affiliate support
- [ ] No way to prevent dual prompts for the same app and version on two separate devices
- [ ] Makes the implementer write more code for lifecycle events

I started addressing these issues in a fork of Appirater, but quickly realized that the entire project could be re-written in a better way to address the above points. Armchair is:

- [x] Using a full Swift implemention
- [x] Available for iOS and Mac
- [x] Runs as a Singleton, with Class level, pass-through convenience methods.
- [x] Every aspect is configurable at runtime through an established API.
- [x] Uses Closures for all event callbacks and notifications.
- [x] Allows developers to disable the prompt easily on minor updates
- [x] Allows iTunes affiliate codes to be used.
- [x] Allows you to prevent prompts for the same app and version on two separate devices
- [x] Makes the implementer write less code by listening to notifications of lifecycle events

Once all these additions, alteration and features were added, it was too much to push back up to Appirater, so Armchair was born. That being said, some of the existing code logic, methods, and language translations (over 32 of them!) are used from [Appirater](https://github.com/arashpayan/appirater) and due credit needs to be given. Armchair could not have existed without it. Thank you!

##  Armchair vs. UAAppReviewManager

[UAAppReviewManager](https://github.com/UrbanApps/UAAppreviewManager) is like the ugly twin sister of Armchair. They are written by the same person, and have a very similar API, logic and feel. The main difference is that Armchair is rewritten from scratch in Swift and is meant for newer projects that are also using Swift.

##  Upgrading From Appirater or UAAppReviewManager

Armchair will automatically convert the NSUserDefault keys stored under Appirater/UAAppReviewManager apps into the default keys used by Armchair. The values will transfer over, and the old, unused Appirater/UAAppReviewManager keys will be deleted from the settings automatically.

## What's Planned?

There are some ideas we have for future versions of Armchair. Feel free to fork/implement if you would like to expedite the process.

- Get 100% Unit Test coverage
- Add the ability to present the prompt using a custom class other than a `UIAlertView`, `UIAlertController` or `NSAlert`
- Add additional localizations: ongoing
-  [Your idea](https://github.com/UrbanApps/Armchair/issues)

## Bugs / Pull Requests
Let us know if you see ways to improve Armchair or see something wrong with it. We are happy to pull in pull requests that have clean code, and have features that are useful for most people. While the Swift community is still deciding on proper code structure and style, please refrain from simple style complaints (space > tabs, etc...)

## What Does Armchair stand for?
The "Arm" is for App Review Manager. The chair is so we could have a cool picture on the page.

## Who makes Armchair?
[Matt Coneybeare](http://matt.coneybeare.me) of [Urban Apps](http://urbanapps.com). We make neat stuff. Check us out.

## Other Open-Source Urban Apps Projects

- [UAAppReviewManager](https://github.com/UrbanApps/UAAppReviewManager) - A review prompting tool for iOS and Mac App Store apps (Obj-C)
- [UAModalPanel](https://github.com/UrbanApps/UAModalPanel) - An animated modal panel alternative for iOS
- [UALogger](https://github.com/UrbanApps/UALogger) - A logging utility for Mac/iOS apps
- [UAObfuscatedString](https://github.com/UrbanApps/UAObfuscatedString) - A simple NSString category to hide sensitive strings
- [UAProgressView](https://github.com/UrbanApps/UAProgressView) - A simple and lightweight, yet powerful animated circular progress view
- [Urban](https://github.com/UrbanApps/Urban) - An Xcode color scheme that uses a soft dark background, with subtle blue, orange and yellow colors

## License

Armchair is released under an MIT license. See [LICENSE](https://github.com/UrbanApps/Armchair/blob/master/LICENSE) for more information.
