// Armchair.swift
//
// Copyright (c) 2014 Armchair (http://github.com/UrbanApps/Armchair)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import StoreKit
import SystemConfiguration

#if os(iOS)
import UIKit
#elseif os(OSX)
import AppKit
#else
    // Not yet supported
#endif

// MARK: -
// MARK: PUBLIC Interface
// MARK: -
// MARK: Properties
/*
* Get/Set your Apple generated software id.
* This is the only required setup value.
* This call needs to be first. No default.
*/
public var appID: String = ""
public func appID(appID: String) {
    Armchair.appID = appID
    Manager.defaultManager.appID = appID
}

/*
* Get/Set the App Name to use in the prompt
* Default value is your localized display name from the info.plist
*/
public func appName() -> String {
    return Manager.defaultManager.appName
}
public func appName(appName: String) {
    Manager.defaultManager.appName = appName
}

/*
* Get/Set the title to use on the review prompt.
* Default value is a localized "Rate <appName>"
*/
public func reviewTitle() -> String {
    return Manager.defaultManager.reviewTitle
}
public func reviewTitle(reviewTitle: String) {
    Manager.defaultManager.reviewTitle = reviewTitle
}

/*
* Get/Set the message to use on the review prompt.
* Default value is a localized
*  "If you enjoy using <appName>, would you mind taking a moment to rate it? It won't take more than a minute. Thanks for your support!"
*/
public func reviewMessage() -> String {
    return Manager.defaultManager.reviewMessage
}
public func reviewMessage(reviewMessage: String) {
    Manager.defaultManager.reviewMessage = reviewMessage
}

/*
* Get/Set the cancel button title to use on the review prompt.
* Default value is a localized "No, Thanks"
*/
public func cancelButtonTitle() -> String {
    return Manager.defaultManager.cancelButtonTitle
}
public func cancelButtonTitle(cancelButtonTitle: String) {
    Manager.defaultManager.cancelButtonTitle = cancelButtonTitle
}

/*
* Get/Set the rate button title to use on the review prompt.
* Default value is a localized "Rate <appName>"
*/
public func rateButtonTitle() -> String {
    return Manager.defaultManager.rateButtonTitle
}
public func rateButtonTitle(rateButtonTitle: String) {
    Manager.defaultManager.rateButtonTitle = rateButtonTitle
}

/*
* Get/Set the remind me later button title to use on the review prompt.
* It is optional, so you can set it to nil to hide the remind button from displaying
* Default value is a localized "Remind me later"
*/
public func remindButtonTitle() -> String? {
    return Manager.defaultManager.remindButtonTitle
}
public func remindButtonTitle(remindButtonTitle: String?) {
    Manager.defaultManager.remindButtonTitle = remindButtonTitle
}

/*
* Get/Set the NSUserDefault keys that store the usage data for Armchair
* Default values are in the form of "<appID>_Armchair<Setting>"
*/
public func keyForArmchairKeyType(keyType: ArmchairKey) -> String {
    return Manager.defaultManager.keyForArmchairKeyType(keyType)
}
public func setKey(key: NSString, armchairKeyType: ArmchairKey) {
    Manager.defaultManager.setKey(key, armchairKeyType: armchairKeyType)
}

/*
* Get/Set the prefix to the NSUserDefault keys that store the usage data for Armchair
* Default value is the App ID, and it is prepended to the keys for key type, above
* This prevents different apps using a shared Key/Value store from overwriting each other.
*/
public func keyPrefix() -> String {
    return Manager.defaultManager.keyPrefix
}
public func keyPrefix(keyPrefix: String) {
    Manager.defaultManager.keyPrefix = keyPrefix
}

/*
* Get/Set the object that stores the usage data for Armchair
* it is optional but if you pass nil, Armchair can not run.
* Default value is NSUserDefaults.standardUserDefaults()
*/
public func userDefaultsObject() -> ArmchairDefaultsObject? {
    return Manager.defaultManager.userDefaultsObject
}
public func userDefaultsObject(userDefaultsObject: ArmchairDefaultsObject?) {
    Manager.defaultManager.userDefaultsObject = userDefaultsObject
}

/*
* Users will need to have the same version of your app installed for this many
* days before they will be prompted to rate it.
* Default => 30
*/
public func daysUntilPrompt() -> UInt {
    return Manager.defaultManager.daysUntilPrompt
}
public func daysUntilPrompt(daysUntilPrompt: UInt) {
    Manager.defaultManager.daysUntilPrompt = daysUntilPrompt
}

/*
* An example of a 'use' would be if the user launched the app. Bringing the app
* into the foreground (on devices that support it) would also be considered
* a 'use'.
*
* Users need to 'use' the same version of the app this many times before
* before they will be prompted to rate it.
* Default => 20
*/
public func usesUntilPrompt() -> UInt {
    return Manager.defaultManager.usesUntilPrompt
}
public func usesUntilPrompt(usesUntilPrompt: UInt) {
    Manager.defaultManager.usesUntilPrompt = usesUntilPrompt
}

/*
* A significant event can be anything you want to be in your app. In a
* telephone app, a significant event might be placing or receiving a call.
* In a game, it might be beating a level or a boss. This is just another
* layer of filtering that can be used to make sure that only the most
* loyal of your users are being prompted to rate you on the app store.
* If you leave this at a value of 0 (default), then this won't be a criterion
* used for rating.
*
* To tell Armchair that the user has performed
* a significant event, call the method Armchair.userDidSignificantEvent()
* Default => 0
*/
public func significantEventsUntilPrompt() -> UInt {
    return Manager.defaultManager.significantEventsUntilPrompt
}
public func significantEventsUntilPrompt(significantEventsUntilPrompt: UInt) {
    Manager.defaultManager.significantEventsUntilPrompt = significantEventsUntilPrompt
}

/*
* Once the rating alert is presented to the user, they might select
* 'Remind me later'. This value specifies how many days Armchair
* will wait before reminding them. A value of 0 disables reminders and
* removes the 'Remind me later' button.
* Default => 1
*/
public func daysBeforeReminding() -> UInt {
    return Manager.defaultManager.daysBeforeReminding
}
public func daysBeforeReminding(daysBeforeReminding: UInt) {
    Manager.defaultManager.daysBeforeReminding = daysBeforeReminding
}

/*
* By default, Armchair tracks all new bundle versions.
* When it detects a new version, it resets the values saved for usage,
* significant events, popup shown, user action etc...
* By setting this to false, Armchair will ONLY track the version it
* was initialized with. If this setting is set to true, Armchair
* will reset after each new version detection.
* Default => true
*/
public func tracksNewVersions() -> Bool {
    return Manager.defaultManager.tracksNewVersions
}
public func tracksNewVersions(tracksNewVersions: Bool) {
    Manager.defaultManager.tracksNewVersions = tracksNewVersions
}

/*
* If the user has rated the app once before, and you don't want it to show on
* a new version, set this to false. This is useful if you release small bugfix
* versions and don't want to pester your users with popups for every minor
* version. For example, you might set this to false for every minor build, then
* when you push a major version upgrade, leave it as true to ask for a rating again.
* Default => true
*/
public func shouldPromptIfRated() -> Bool {
    return Manager.defaultManager.shouldPromptIfRated
}
public func shouldPromptIfRated(shouldPromptIfRated: Bool) {
    Manager.defaultManager.shouldPromptIfRated = shouldPromptIfRated
}

/*
* If set to true, the main bundle will always be used to load localized strings.
* Set this to true if you have provided your own custom localizations in
* ArmchairLocalizable.strings in your main bundle
* Default => false.
*/
public func useMainAppBundleForLocalizations() -> Bool {
    return Manager.defaultManager.useMainAppBundleForLocalizations
}
public func useMainAppBundleForLocalizations(useMainAppBundleForLocalizations: Bool) {
    Manager.defaultManager.useMainAppBundleForLocalizations = useMainAppBundleForLocalizations
}

/*
* If you are an Apple Affiliate, enter your code here.
* If none is set, the author's code will be used as it is better to be set as something
* rather than nothing. If you want to thank me for making Armchair, feel free
* to leave this value at it's default.
*/
public func affiliateCode() -> String {
    return Manager.defaultManager.affiliateCode
}
public func affiliateCode(affiliateCode: String) {
    Manager.defaultManager.affiliateCode = affiliateCode
}

/*
* If you are an Apple Affiliate, enter your campaign code here.
* Default => "Armchair-<appID>"
*/
public func affiliateCampaignCode() -> String {
    return Manager.defaultManager.affiliateCampaignCode
}
public func affiliateCampaignCode(affiliateCampaignCode: String) {
    Manager.defaultManager.affiliateCampaignCode = affiliateCampaignCode
}

/*
* 'true' will show the Armchair alert everytime. Useful for testing
* how your message looks and making sure the link to your app's review page works.
* Calling this method in a production build (DEBUG preprocessor macro is not defined)
* has no effect. In app store builds, you don't have to worry about accidentally
* leaving debugEnabled to true
* Default => false
*/
public func debugEnabled() -> Bool {
    return Manager.defaultManager.debugEnabled
}
public func debugEnabled(debugEnabled: Bool) {
#if Debug
    Manager.defaultManager.debugEnabled = debugEnabled
#else
    print("[Armchair] Debug is disabled on release builds.")
    print("[Armchair]   If you really want to enable debug mode,")
    print("[Armchair]   add \"-DDebug\" to your  Swift Compiler - Custom Flags")
    print("[Armchair]   section in the target's build settings for release")
#endif
}

/*
*
*
*/
public func resetDefaults() {
    Manager.defaultManager.debugEnabled = false
    Manager.defaultManager.appName                          = Manager.defaultManager.defaultAppName()
    Manager.defaultManager.reviewTitle                      = Manager.defaultManager.defaultReviewTitle()
    Manager.defaultManager.reviewMessage                    = Manager.defaultManager.defaultReviewMessage()
    Manager.defaultManager.cancelButtonTitle                = Manager.defaultManager.defaultCancelButtonTitle()
    Manager.defaultManager.rateButtonTitle                  = Manager.defaultManager.defaultRateButtonTitle()
    Manager.defaultManager.remindButtonTitle                = Manager.defaultManager.defaultRemindButtonTitle()
    Manager.defaultManager.daysUntilPrompt                  = 30
    Manager.defaultManager.daysBeforeReminding              = 1
    Manager.defaultManager.shouldPromptIfRated              = true
    Manager.defaultManager.significantEventsUntilPrompt     = 20
    Manager.defaultManager.tracksNewVersions                = true
    Manager.defaultManager.useMainAppBundleForLocalizations = false
    Manager.defaultManager.affiliateCode                    = Manager.defaultManager.defaultAffiliateCode()
    Manager.defaultManager.affiliateCampaignCode            = Manager.defaultManager.defaultAffiliateCampaignCode()
    Manager.defaultManager.didDeclineToRateClosure          = nil
    Manager.defaultManager.didDisplayAlertClosure           = nil
    Manager.defaultManager.didOptToRateClosure              = nil
    Manager.defaultManager.didOptToRemindLaterClosure       = nil

#if os(iOS)
    Manager.defaultManager.usesAnimation                    = true
    Manager.defaultManager.usesAlertController              = false
    Manager.defaultManager.opensInStoreKit                  = Manager.defaultManager.defaultOpensInStoreKit()
    Manager.defaultManager.willPresentModalViewClosure      = nil
    Manager.defaultManager.didDismissModalViewClosure       = nil
#endif

    Manager.defaultManager.armchairKeyFirstUseDate                           = Manager.defaultManager.defaultArmchairKeyFirstUseDate()
    Manager.defaultManager.armchairKeyUseCount                               = Manager.defaultManager.defaultArmchairKeyUseCount()
    Manager.defaultManager.armchairKeySignificantEventCount                  = Manager.defaultManager.defaultArmchairKeySignificantEventCount()
    Manager.defaultManager.armchairKeyCurrentVersion                         = Manager.defaultManager.defaultArmchairKeyCurrentVersion()
    Manager.defaultManager.armchairKeyRatedCurrentVersion                    = Manager.defaultManager.defaultArmchairKeyRatedCurrentVersion()
    Manager.defaultManager.armchairKeyDeclinedToRate                         = Manager.defaultManager.defaultArmchairKeyDeclinedToRate()
    Manager.defaultManager.armchairKeyReminderRequestDate                    = Manager.defaultManager.defaultArmchairKeyReminderRequestDate()
    Manager.defaultManager.armchairKeyPreviousVersion                        = Manager.defaultManager.defaultArmchairKeyPreviousVersion()
    Manager.defaultManager.armchairKeyPreviousVersionRated                   = Manager.defaultManager.defaultArmchairKeyPreviousVersionRated()
    Manager.defaultManager.armchairKeyPreviousVersionDeclinedToRate          = Manager.defaultManager.defaultArmchairKeyDeclinedToRate()
    Manager.defaultManager.armchairKeyRatedAnyVersion                        = Manager.defaultManager.defaultArmchairKeyRatedAnyVersion()
    Manager.defaultManager.armchairKeyAppiraterMigrationCompleted            = Manager.defaultManager.defaultArmchairKeyAppiraterMigrationCompleted()
    Manager.defaultManager.armchairKeyUAAppReviewManagerMigrationCompleted   = Manager.defaultManager.defaultArmchairKeyUAAppReviewManagerMigrationCompleted()

    Manager.defaultManager.keyPrefix = Manager.defaultManager.defaultKeyPrefix()
}

#if os(iOS)
    /*
    * Set whether or not Armchair uses animation when pushing modal StoreKit
    * view controllers for the app.
    * Default => true
    */
    public func usesAnimation() -> Bool {
        return Manager.defaultManager.usesAnimation
    }
    public func usesAnimation(usesAnimation: Bool) {
        Manager.defaultManager.usesAnimation = usesAnimation
    }

    /*
    * Set whether or not Armchair uses a UIAlertController when presenting on iOS 8
    * We prefer not to use it so that the Rate button can be on the bottom and the cancel button on the top,
    * Something not possible as of iOS 8.0
    * Default => false
    */
    public func usesAlertController() -> Bool {
        return Manager.defaultManager.usesAlertController
    }
    public func usesAlertController(usesAlertController: Bool) {
        Manager.defaultManager.usesAlertController = usesAlertController
    }

    /*
    * If set to true, Armchair will open App Store link inside the app using
    * SKStoreProductViewController.
    *  - itunes affiliate codes DO NOT work on iOS 7 inside StoreKit,
    *  - itunes affiliate codes DO work on iOS 8 inside StoreKit,
    * Default => false on iOS 7, true on iOS 8+
    */
    public func opensInStoreKit() -> Bool {
        return Manager.defaultManager.opensInStoreKit
    }
    public func opensInStoreKit(opensInStoreKit: Bool) {
        Manager.defaultManager.opensInStoreKit = opensInStoreKit
    }
#endif

// MARK: Events

/*
* Tells Armchair that the user performed a significant event.
* A significant event is whatever you want it to be. If you're app is used
* to make VoIP calls, then you might want to call this method whenever the
* user places a call. If it's a game, you might want to call this whenever
* the user beats a level boss.
*
* If the user has performed enough significant events and used the app enough,
* you can suppress the rating alert by passing false for canPromptForRating. The
* rating alert will simply be postponed until it is called again with true for
* canPromptForRating.
*/
public func userDidSignificantEvent(canPromptForRating: Bool) {
    Manager.defaultManager.userDidSignificantEvent(canPromptForRating)
}

/*
* Tells Armchair that the user performed a significant event.
* A significant event is whatever you want it to be. If you're app is used
* to make VoIP calls, then you might want to call this method whenever the
* user places a call. If it's a game, you might want to call this whenever
* the user beats a level boss.
*
* This is similar to the userDidSignificantEvent method, but allows the passing of a
* ArmchairShouldPromptClosure that will be executed before prompting.
* The closure passes all the keys and values that Armchair uses to
* determine if it the prompt conditions have been met, and it is up to you
* to use this info and return a Bool on whether or not the prompt should be shown.
* The closure is run synchronous and on the main queue, so be sure to handle it appropriately.
* Return true to proceed and show the prompt, return false to kill the pending presentation.
*/
public func userDidSignificantEvent(shouldPrompt: ArmchairShouldPromptClosure) {
    Manager.defaultManager.userDidSignificantEvent(shouldPrompt)
}

// MARK: Prompts

/*
* Tells Armchair to show the prompt (a rating alert). The prompt
* will be showed if there is an internet connection available, the user hasn't
* declined to rate, hasn't rated current version and you are tracking new versions.
*
* You could call to show the prompt regardless of Armchair settings,
* for instance, in the case of some special event in your app.
*/

public func showPrompt() {
    Manager.defaultManager.showPrompt()
}

/*
* Tells Armchair to show the review prompt alert if all restrictions have been met.
* The prompt will be shown if all restrictions are met, there is an internet connection available,
* the user hasn't declined to rate, hasn't rated current version, and you are tracking new versions.
*
* You could call to show the prompt, for instance, in the case of some special event in your app,
* like a user login.
*/
public func showPromptIfNecessary() {
    Manager.defaultManager.showPrompt(ifNecessary: true)
}

/*
* Tells Armchair to show the review prompt alert.
*
* This is similar to the showPromptIfNecessary method, but allows the passing of a
* ArmchairShouldPromptClosure that will be executed before prompting.
* The closure passes all the keys and values that Armchair uses to
* determine if it the prompt conditions have been met, and it is up to you
* to use this info and return a Bool on whether or not the prompt should be shown.
* The closure is run synchronous and on the main queue, so be sure to handle it appropriately.
* Return true to proceed and show the prompt, return false to kill the pending presentation.
*/
public func showPrompt(shouldPrompt: ArmchairShouldPromptClosure) {
    Manager.defaultManager.showPrompt(shouldPrompt)
}

// MARK: Misc
/*
* This is the review URL string, generated by substituting the appID, affiliate code
* and affilitate campaign code into the template URL.
*/
public func reviewURLString() -> String {
    return Manager.defaultManager.reviewURLString()
}

/*
* Tells Armchair to open the App Store page where the user can specify a
* rating for the app. Also records the fact that this has happened, so the
* user won't be prompted again to rate the app.
*
* The only case where you should call this directly is if your app has an
* explicit "Rate this app" command somewhere.  In all other cases, don't worry
* about calling this -- instead, just call the other functions listed above,
* and let Armchair handle the bookkeeping of deciding when to ask the user
* whether to rate the app.
*/
public func rateApp() {
    Manager.defaultManager.rateApp()
}

#if os(iOS)
    /*
    * Tells Armchair to immediately close any open rating modals
    * for instance, a StoreKit rating View Controller.
    */
    public func closeModalPanel() {
        Manager.defaultManager.closeModalPanel()
    }
#endif

// MARK: Closures
/*
* Armchair uses closures instead of delegate methods for callbacks.
* Default is nil for all of them.
*/

public typealias ArmchairClosure = () -> ()
public typealias ArmchairAnimateClosure = (Bool) -> ()
public typealias ArmchairShouldPromptClosure = (ArmchairTrackingInfo) -> Bool
public typealias ArmchairShouldIncrementClosure = () -> Bool

public func onDidDisplayAlert(didDisplayAlertClosure: ArmchairClosure?) {
    Manager.defaultManager.didDisplayAlertClosure = didDisplayAlertClosure
}
public func onDidDeclineToRate(didDeclineToRateClosure: ArmchairClosure?) {
    Manager.defaultManager.didDeclineToRateClosure = didDeclineToRateClosure
}
public func onDidOptToRate(didOptToRateClosure: ArmchairClosure?) {
    Manager.defaultManager.didOptToRateClosure = didOptToRateClosure
}
public func onDidOptToRemindLater(didOptToRemindLaterClosure: ArmchairClosure?) {
    Manager.defaultManager.didOptToRemindLaterClosure = didOptToRemindLaterClosure
}

#if os(iOS)
    public func onWillPresentModalView(willPresentModalViewClosure: ArmchairAnimateClosure?) {
        Manager.defaultManager.willPresentModalViewClosure = willPresentModalViewClosure
    }
    public func onDidDismissModalView(didDismissModalViewClosure: ArmchairAnimateClosure?) {
        Manager.defaultManager.didDismissModalViewClosure = didDismissModalViewClosure
    }
#endif

/*
* The setShouldPromptClosure is called just after all the rating coditions
* have been met and Armchair has decided it should display a prompt,
* but just before the prompt actually displays.
*
* The closure passes all the keys and values that Armchair used to
* determine that the prompt conditions had been met, but it is up to you
* to use this info and return a Bool on whether or not the prompt should be shown.
* Return true to proceed and show the prompt, return false to kill the pending presentation.
*/
public func shouldPromptClosure(shouldPromptClosure: ArmchairShouldPromptClosure?) {
    Manager.defaultManager.shouldPromptClosure = shouldPromptClosure
}

/*
* The setShouldIncrementUseClosure, if valid, is called before incrementing the use count.
* Returning false allows you to ignore a use.  This may be usefull in cases such as Facebook login
* where the app is backgrounded momentarily and the resultant enter foreground event should
* not be considered another use.
*/
public func shouldIncrementUseCountClosure(shouldIncrementUseCountClosure: ArmchairShouldIncrementClosure?) {
    Manager.defaultManager.shouldIncrementUseCountClosure = shouldIncrementUseCountClosure
}

// MARK: -
// MARK: Armchair Defaults Protocol

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

public class StandardUserDefaults: ArmchairDefaultsObject {
    let defaults = NSUserDefaults.standardUserDefaults()

    @objc public func objectForKey(defaultName: String) -> AnyObject?             { return defaults.objectForKey(defaultName) }
    @objc public func setObject(value: AnyObject?, forKey defaultName: String)    { defaults.setObject(value, forKey: defaultName) }
    @objc public func removeObjectForKey(defaultName: String)                     { defaults.removeObjectForKey(defaultName) }

    @objc public func stringForKey(defaultName: String) -> String?                { return defaults.stringForKey(defaultName) }
    @objc public func integerForKey(defaultName: String) -> Int                   { return defaults.integerForKey(defaultName) }
    @objc public func doubleForKey(defaultName: String) -> Double                 { return defaults.doubleForKey(defaultName) }
    @objc public func boolForKey(defaultName: String) -> Bool                     { return defaults.boolForKey(defaultName) }

    @objc public func setInteger(value: Int, forKey defaultName: String)          { defaults.setInteger(value, forKey: defaultName) }
    @objc public func setDouble(value: Double, forKey defaultName: String)        { defaults.setDouble(value, forKey: defaultName) }
    @objc public func setBool(value: Bool, forKey defaultName: String)            { defaults.setBool(value, forKey: defaultName) }

    @objc public func synchronize() -> Bool                                       { return defaults.synchronize() }
}

public enum ArmchairKey: String, CustomStringConvertible {
    case FirstUseDate                           = "First Use Date"
    case UseCount                               = "Use Count"
    case SignificantEventCount                  = "Significant Event Count"
    case CurrentVersion                         = "Current Version"
    case RatedCurrentVersion                    = "Rated Current Version"
    case DeclinedToRate                         = "Declined To Rate"
    case ReminderRequestDate                    = "Reminder Request Date"
    case PreviousVersion                        = "Previous Version"
    case PreviousVersionRated                   = "Previous Version Rated"
    case PreviousVersionDeclinedToRate          = "Previous Version Declined To Rate"
    case RatedAnyVersion                        = "Rated Any Version"
    case AppiraterMigrationCompleted            = "Appirater Migration Completed"
    case UAAppReviewManagerMigrationCompleted   = "UAAppReviewManager Migration Completed"

    static let allValues = [FirstUseDate, UseCount, SignificantEventCount, CurrentVersion, RatedCurrentVersion, DeclinedToRate, ReminderRequestDate, PreviousVersion, PreviousVersionRated, PreviousVersionDeclinedToRate, RatedAnyVersion, AppiraterMigrationCompleted, UAAppReviewManagerMigrationCompleted]

    public var description : String {
        get {
            return self.rawValue
        }
    }
}

public class ArmchairTrackingInfo: CustomStringConvertible {
    public let info: Dictionary<ArmchairKey, AnyObject>

    init(info: Dictionary<ArmchairKey, AnyObject>) {
        self.info = info
    }

    public var description: String {
        get {
            var description = "ArmchairTrackingInfo\r"
            for (key, val) in info {
                description += " - \(key): \(val)\r"
            }
            return description
        }
    }
}

public struct AppiraterKey {
    static var FirstUseDate             = "kAppiraterFirstUseDate"
    static var UseCount                 = "kAppiraterUseCount"
    static var SignificantEventCount    = "kAppiraterSignificantEventCount"
    static var CurrentVersion           = "kAppiraterCurrentVersion"
    static var RatedCurrentVersion      = "kAppiraterRatedCurrentVersion"
    static var RatedAnyVersion          = "kAppiraterRatedAnyVersion"
    static var DeclinedToRate           = "kAppiraterDeclinedToRate"
    static var ReminderRequestDate      = "kAppiraterReminderRequestDate"
}

// MARK: -
// MARK: PRIVATE Interface

#if os(iOS)
public class ArmchairManager : NSObject, UIAlertViewDelegate, SKStoreProductViewControllerDelegate { }
#elseif os(OSX)
public class ArmchairManager : NSObject, NSAlertDelegate { }
#else
// Untested, and currently unsupported
#endif

public class Manager : ArmchairManager {

#if os(iOS)
    private var operatingSystemVersion = NSString(string: UIDevice.currentDevice().systemVersion).doubleValue
#elseif os(OSX)
    private var operatingSystemVersion = Double(NSProcessInfo.processInfo().operatingSystemVersion.majorVersion)
#else
#endif
    
    // MARK: -
    // MARK: Review Alert & Properties

#if os(iOS)
    private var ratingAlert: UIAlertView? = nil
    private let reviewURLTemplate  = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&id=APP_ID&at=AFFILIATE_CODE&ct=AFFILIATE_CAMPAIGN_CODE"
#elseif os(OSX)
    private var ratingAlert: NSAlert? = nil
    private let reviewURLTemplate = "macappstore://itunes.apple.com/us/app/idAPP_ID?ls=1&mt=12&at=AFFILIATE_CODE&ct=AFFILIATE_CAMPAIGN_CODE"
#else
#endif

    private lazy var appName: String = self.defaultAppName()
    private func defaultAppName() -> String {
        let mainBundle = NSBundle.mainBundle()
        let displayName = mainBundle.objectForInfoDictionaryKey("CFBundleDisplayName") as? String
        let bundleNameKey = kCFBundleNameKey as String
        let name = mainBundle.objectForInfoDictionaryKey(bundleNameKey) as? String
        return displayName ?? name ?? "This App"
    }
    
    private lazy var reviewTitle: String = self.defaultReviewTitle()
    private func defaultReviewTitle() -> String {
        var template = "Rate %@"
        // Check for a localized version of the default title
        if let bundle = self.bundle() {
            template = bundle.localizedStringForKey(template, value:"", table: "ArmchairLocalizable")
        }

        return template.stringByReplacingOccurrencesOfString("%@", withString: "\(self.appName)", options: NSStringCompareOptions(rawValue: 0), range: nil)
    }

    private lazy var reviewMessage: String = self.defaultReviewMessage()
    private func defaultReviewMessage() -> String {
        var template = "If you enjoy using %@, would you mind taking a moment to rate it? It won't take more than a minute. Thanks for your support!"
        // Check for a localized version of the default title
        if let bundle = self.bundle() {
            template = bundle.localizedStringForKey(template, value:"", table: "ArmchairLocalizable")
        }

        return template.stringByReplacingOccurrencesOfString("%@", withString: "\(self.appName)", options: NSStringCompareOptions(rawValue: 0), range: nil)
    }

    private lazy var cancelButtonTitle: String = self.defaultCancelButtonTitle()
    private func defaultCancelButtonTitle() -> String {
        var title = "No, Thanks"
        // Check for a localized version of the default title
        if let bundle = self.bundle() {
            title = bundle.localizedStringForKey(title, value:"", table: "ArmchairLocalizable")
        }

        return title
    }

    private lazy var rateButtonTitle: String = self.defaultRateButtonTitle()
    private func defaultRateButtonTitle() -> String {
        var template = "Rate %@"
        // Check for a localized version of the default title
        if let bundle = self.bundle() {
            template = bundle.localizedStringForKey(template, value:"", table: "ArmchairLocalizable")
        }

        return template.stringByReplacingOccurrencesOfString("%@", withString: "\(self.appName)", options: NSStringCompareOptions(rawValue: 0), range: nil)
    }

    private lazy var remindButtonTitle: String? = self.defaultRemindButtonTitle()
    private func defaultRemindButtonTitle() -> String? {
        //if reminders are disabled, return a nil title to supress the button
        if self.daysBeforeReminding == 0 {
            return nil
        }
        var title = "Remind me later"
        // Check for a localized version of the default title
        if let bundle = self.bundle() {
            title = bundle.localizedStringForKey(title, value:"", table: "ArmchairLocalizable")
        }

        return title
    }

    // Tracking Logic / Configuration
    private var appID: String = "" {
        didSet {
            keyPrefix = defaultKeyPrefix()
            if affiliateCampaignCode == defaultAffiliateCampaignCode() {
                affiliateCampaignCode = affiliateCampaignCode + "-\(appID)"
            }
        }
    }

    // MARK: Properties with sensible defaults
    private var daysUntilPrompt: UInt                   = 30
    private var usesUntilPrompt: UInt                   = 20
    private var significantEventsUntilPrompt: UInt      = 0
    private var daysBeforeReminding: UInt               = 1
    private var tracksNewVersions: Bool                 = true
    private var shouldPromptIfRated: Bool               = true
    private var useMainAppBundleForLocalizations: Bool  = false
    private var debugEnabled: Bool                      = false {
        didSet {
            if self.debugEnabled {
                debugLog("Debug enabled for app: \(appID)")
            }
        }
    }

    // If you aren't going to set an affiliate code yourself, please leave this as is.
    // It is my affiliate code. It is better that somebody's code is used rather than nobody's.
    private var affiliateCode: String                   = "11l7j9"
    private var affiliateCampaignCode: String           = "Armchair"

#if os(iOS)
    private var usesAnimation: Bool                     = true
    private var usesAlertController: Bool               = false
    private lazy var opensInStoreKit: Bool              = self.defaultOpensInStoreKit()

    private func defaultOpensInStoreKit() -> Bool {
        return operatingSystemVersion >= 8
    }
#endif

    // MARK: Tracking Keys with sensible defaults
    private lazy var armchairKeyFirstUseDate: String                         = self.defaultArmchairKeyFirstUseDate()
    private lazy var armchairKeyUseCount: String                             = self.defaultArmchairKeyUseCount()
    private lazy var armchairKeySignificantEventCount: String                = self.defaultArmchairKeySignificantEventCount()
    private lazy var armchairKeyCurrentVersion: String                       = self.defaultArmchairKeyCurrentVersion()
    private lazy var armchairKeyRatedCurrentVersion: String                  = self.defaultArmchairKeyRatedCurrentVersion()
    private lazy var armchairKeyDeclinedToRate: String                       = self.defaultArmchairKeyDeclinedToRate()
    private lazy var armchairKeyReminderRequestDate: String                  = self.defaultArmchairKeyReminderRequestDate()
    private lazy var armchairKeyPreviousVersion: String                      = self.defaultArmchairKeyPreviousVersion()
    private lazy var armchairKeyPreviousVersionRated: String                 = self.defaultArmchairKeyPreviousVersionRated()
    private lazy var armchairKeyPreviousVersionDeclinedToRate: String        = self.defaultArmchairKeyPreviousVersionDeclinedToRate()
    private lazy var armchairKeyRatedAnyVersion: String                      = self.defaultArmchairKeyRatedAnyVersion()
    private lazy var armchairKeyAppiraterMigrationCompleted: String          = self.defaultArmchairKeyAppiraterMigrationCompleted()
    private lazy var armchairKeyUAAppReviewManagerMigrationCompleted: String = self.defaultArmchairKeyUAAppReviewManagerMigrationCompleted()

    private func defaultArmchairKeyFirstUseDate() -> String                          { return "ArmchairFirstUseDate" }
    private func defaultArmchairKeyUseCount() -> String                              { return "ArmchairUseCount" }
    private func defaultArmchairKeySignificantEventCount() -> String                 { return "ArmchairSignificantEventCount" }
    private func defaultArmchairKeyCurrentVersion() -> String                        { return "ArmchairKeyCurrentVersion" }
    private func defaultArmchairKeyRatedCurrentVersion() -> String                   { return "ArmchairRatedCurrentVersion" }
    private func defaultArmchairKeyDeclinedToRate() -> String                        { return "ArmchairKeyDeclinedToRate" }
    private func defaultArmchairKeyReminderRequestDate() -> String                   { return "ArmchairReminderRequestDate" }
    private func defaultArmchairKeyPreviousVersion() -> String                       { return "ArmchairPreviousVersion" }
    private func defaultArmchairKeyPreviousVersionRated() -> String                  { return "ArmchairPreviousVersionRated" }
    private func defaultArmchairKeyPreviousVersionDeclinedToRate() -> String         { return "ArmchairPreviousVersionDeclinedToRate" }
    private func defaultArmchairKeyRatedAnyVersion() -> String                       { return "ArmchairKeyRatedAnyVersion" }
    private func defaultArmchairKeyAppiraterMigrationCompleted() -> String           { return "ArmchairAppiraterMigrationCompleted" }
    private func defaultArmchairKeyUAAppReviewManagerMigrationCompleted() -> String  { return "ArmchairUAAppReviewManagerMigrationCompleted" }


    private lazy var keyPrefix: String = self.defaultKeyPrefix()
    private func defaultKeyPrefix() -> String {
        if !self.appID.isEmpty {
            return self.appID + "_"
        } else {
            return "_"
        }
    }

    private var userDefaultsObject:ArmchairDefaultsObject? = StandardUserDefaults()

    // MARK: Optional Closures
    var didDisplayAlertClosure: ArmchairClosure?
    var didDeclineToRateClosure: ArmchairClosure?
    var didOptToRateClosure: ArmchairClosure?
    var didOptToRemindLaterClosure: ArmchairClosure?

#if os(iOS)
    var willPresentModalViewClosure: ArmchairAnimateClosure?
    var didDismissModalViewClosure: ArmchairAnimateClosure?
#endif
    var shouldPromptClosure: ArmchairShouldPromptClosure?
    var shouldIncrementUseCountClosure: ArmchairShouldIncrementClosure?

    // MARK: State Vars
    private var modalPanelOpen: Bool = false
#if os(iOS)
    private lazy var currentStatusBarStyle: UIStatusBarStyle = {
        return UIApplication.sharedApplication().statusBarStyle
    }()
#endif

    // MARK: -
    // MARK: PRIVATE Methods

    private func userDidSignificantEvent(canPromptForRating: Bool) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)) {
            self.incrementSignificantEventAndRate(canPromptForRating)
        }
    }

    private func userDidSignificantEvent(shouldPrompt: ArmchairShouldPromptClosure) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)) {
            self.incrementSignificantEventAndRate(shouldPrompt)
        }
    }

    // MARK: -
    // MARK: PRIVATE Rating Helpers

    private func incrementAndRate(canPromptForRating: Bool) {
        migrateKeysIfNecessary()
        incrementUseCount()
        showPrompt(ifNecessary: canPromptForRating)
    }

    private func incrementAndRate(shouldPrompt: ArmchairShouldPromptClosure) {
        migrateKeysIfNecessary()
        incrementUseCount()
        showPrompt(shouldPrompt)
    }

    private func incrementSignificantEventAndRate(canPromptForRating: Bool) {
        migrateKeysIfNecessary()
        incrementSignificantEventCount()
        showPrompt(ifNecessary: canPromptForRating)
    }

    private func incrementSignificantEventAndRate(shouldPrompt: ArmchairShouldPromptClosure) {
        migrateKeysIfNecessary()
        incrementSignificantEventCount()
        showPrompt(shouldPrompt)
    }

    private func incrementUseCount() {
        var shouldIncrement = true
        if let closure = shouldIncrementUseCountClosure {
            shouldIncrement = closure()
        }

        if shouldIncrement {
            _incrementCountForKeyType(ArmchairKey.UseCount)
        }
    }

    private func incrementSignificantEventCount() {
        _incrementCountForKeyType(ArmchairKey.SignificantEventCount)
    }

    private func _incrementCountForKeyType(incrementKeyType: ArmchairKey) {
        let incrementKey = keyForArmchairKeyType(incrementKeyType)

        let bundleVersionKey = kCFBundleVersionKey as String
        // App's version. Not settable as the other ivars because that would be crazy.
        let currentVersion = NSBundle.mainBundle().objectForInfoDictionaryKey(bundleVersionKey) as? String
        if currentVersion == nil {
            assertionFailure("Could not read kCFBundleVersionKey from InfoDictionary")
            return
        }

        // Get the version number that we've been tracking thus far
        let currentVersionKey = keyForArmchairKeyType(ArmchairKey.CurrentVersion)
        var trackingVersion: String? = userDefaultsObject?.stringForKey(currentVersionKey)
        // New install, or changed keys
        if trackingVersion == nil {
            trackingVersion = currentVersion
            userDefaultsObject?.setObject(currentVersion, forKey: currentVersionKey)
        }

        debugLog("Tracking version: \(trackingVersion!)")

        if trackingVersion == currentVersion {
            // Check if the first use date has been set. if not, set it.
            let firstUseDateKey = keyForArmchairKeyType(ArmchairKey.FirstUseDate)
            var timeInterval: Double? = userDefaultsObject?.doubleForKey(firstUseDateKey)
            if 0 == timeInterval {
                timeInterval = NSDate().timeIntervalSince1970
                userDefaultsObject?.setObject(NSNumber(double: timeInterval!), forKey: firstUseDateKey)
            }

            // Increment the key's count
            var incrementKeyCount = userDefaultsObject?.integerForKey(incrementKey)
            userDefaultsObject?.setInteger(++incrementKeyCount!, forKey:incrementKey)

            debugLog("Incremented \(incrementKeyType): \(incrementKeyCount!)")

        } else if tracksNewVersions {
            // it's a new version of the app, so restart tracking
            userDefaultsObject?.setObject(trackingVersion, forKey: keyForArmchairKeyType(ArmchairKey.PreviousVersion))
            userDefaultsObject?.setObject(userDefaultsObject?.objectForKey(keyForArmchairKeyType(ArmchairKey.RatedCurrentVersion)), forKey: keyForArmchairKeyType(ArmchairKey.PreviousVersionRated))
            userDefaultsObject?.setObject(userDefaultsObject?.objectForKey(keyForArmchairKeyType(ArmchairKey.DeclinedToRate)), forKey: keyForArmchairKeyType(ArmchairKey.PreviousVersionDeclinedToRate))

            userDefaultsObject?.setObject(currentVersion, forKey: currentVersionKey)
            userDefaultsObject?.setObject(NSNumber(double: NSDate().timeIntervalSince1970), forKey: keyForArmchairKeyType(ArmchairKey.FirstUseDate))
            userDefaultsObject?.setObject(NSNumber(integer: 1), forKey: keyForArmchairKeyType(ArmchairKey.UseCount))
            userDefaultsObject?.setObject(NSNumber(integer: 0), forKey: keyForArmchairKeyType(ArmchairKey.SignificantEventCount))
            userDefaultsObject?.setObject(NSNumber(bool: false), forKey: keyForArmchairKeyType(ArmchairKey.RatedCurrentVersion))
            userDefaultsObject?.setObject(NSNumber(bool: false), forKey: keyForArmchairKeyType(ArmchairKey.DeclinedToRate))
            userDefaultsObject?.setObject(NSNumber(double: 0), forKey: keyForArmchairKeyType(ArmchairKey.ReminderRequestDate))

            debugLog("Reset Tracking Version to: \(trackingVersion!)")
        }
    
        userDefaultsObject?.synchronize()
    }

    private func showPrompt(ifNecessary canPromptForRating: Bool) {
        if canPromptForRating && connectedToNetwork() && ratingConditionsHaveBeenMet() {
            var shouldPrompt: Bool = true
            
            if let closure = shouldPromptClosure {
                if NSThread.isMainThread() {
                    shouldPrompt = closure(trackingInfo())
                } else {
                    dispatch_sync(dispatch_get_main_queue()) {
                        shouldPrompt = closure(self.trackingInfo())
                    }
                }
            }

            if shouldPrompt {
                dispatch_async(dispatch_get_main_queue()) {
                    self.showRatingAlert()
                }
            }
        }
    }

    private func showPrompt(shouldPrompt: ArmchairShouldPromptClosure) {
        var shouldPromptVal = false

        if NSThread.isMainThread() {
            shouldPromptVal = shouldPrompt(trackingInfo())
        } else {
            dispatch_sync(dispatch_get_main_queue()) {
                shouldPromptVal = shouldPrompt(self.trackingInfo())
            }
        }


        if (shouldPromptVal) {
            dispatch_async(dispatch_get_main_queue()) {
                self.showRatingAlert()
            }
        }
    }

    private func showPrompt() {
        if !appID.isEmpty && connectedToNetwork() && !userHasDeclinedToRate() && !userHasRatedCurrentVersion() {
            showRatingAlert()
        }
    }

    private func ratingConditionsHaveBeenMet() -> Bool {
        if debugEnabled {
            return true
        }

        if appID.isEmpty {
            return false
        }

        // check if the app has been used long enough
        let timeIntervalOfFirstLaunch = userDefaultsObject?.doubleForKey(keyForArmchairKeyType(ArmchairKey.FirstUseDate))
        if let timeInterval = timeIntervalOfFirstLaunch {
            let dateOfFirstLaunch = NSDate(timeIntervalSince1970: timeInterval)
            let timeSinceFirstLaunch = NSDate().timeIntervalSinceDate(dateOfFirstLaunch)
            let timeUntilRate: NSTimeInterval = 60 * 60 * 24 * Double(daysUntilPrompt)
            if timeSinceFirstLaunch < timeUntilRate {
                return false
            }
        } else {
            return false
        }

        // check if the app has been used enough times
        let useCount = userDefaultsObject?.integerForKey(keyForArmchairKeyType(ArmchairKey.UseCount))
        if let count = useCount {
            if UInt(count) <= usesUntilPrompt {
                return false
            }
        } else {
            return false
        }

        // check if the user has done enough significant events
        let significantEventCount = userDefaultsObject?.integerForKey(keyForArmchairKeyType(ArmchairKey.SignificantEventCount))
        if let count = significantEventCount {
            if UInt(count) < significantEventsUntilPrompt {
                return false
            }
        } else {
            return false
        }

        // Check if the user previously has declined to rate this version of the app
        if userHasDeclinedToRate() {
            return false
        }

        // Check if the user has already rated the app?
        if userHasRatedCurrentVersion() {
            return false
        }

        // If the user wanted to be reminded later, has enough time passed?
        let timeIntervalOfReminder = userDefaultsObject?.doubleForKey(keyForArmchairKeyType(ArmchairKey.ReminderRequestDate))
        if let timeInterval = timeIntervalOfReminder {
            let reminderRequestDate = NSDate(timeIntervalSince1970: timeInterval)
            let timeSinceReminderRequest = NSDate().timeIntervalSinceDate(reminderRequestDate)
            let timeUntilReminder: NSTimeInterval = 60 * 60 * 24 * Double(daysBeforeReminding)
            if timeSinceReminderRequest < timeUntilReminder {
                return false
            }
        } else {
            return false
        }

        // if we have a global set to not show if the end-user has already rated once, and the developer has not opted out of displaying on minor updates
        let ratedAnyVersion = userDefaultsObject?.boolForKey(keyForArmchairKeyType(ArmchairKey.RatedAnyVersion))
        if let ratedAlready = ratedAnyVersion {
            if (!shouldPromptIfRated && ratedAlready) {
                return false
            }
        }
    
        return true
    }

    private func userHasDeclinedToRate() -> Bool {
        if let declined = userDefaultsObject?.boolForKey(keyForArmchairKeyType(ArmchairKey.DeclinedToRate)) {
            return declined
        } else {
            return false
        }
    }

    private func userHasRatedCurrentVersion() -> Bool {
        if let ratedCurrentVersion = userDefaultsObject?.boolForKey(keyForArmchairKeyType(ArmchairKey.RatedCurrentVersion)) {
            return ratedCurrentVersion
        } else {
            return false
        }
    }

    private func showsRemindButton() -> Bool {
        return (remindButtonTitle != nil)
    }

    private func showRatingAlert() {
#if os(iOS)
        if operatingSystemVersion >= 8 && usesAlertController {
            /* iOS 8 uses new UIAlertController API*/
            let alertView : UIAlertController = UIAlertController(title: reviewTitle, message: reviewMessage, preferredStyle: UIAlertControllerStyle.Alert)
            alertView.addAction(UIAlertAction(title: cancelButtonTitle, style:UIAlertActionStyle.Cancel, handler: {
                (alert: UIAlertAction!) in
                self.dontRate()
            }))
            if (showsRemindButton()) {
                alertView.addAction(UIAlertAction(title: remindButtonTitle!, style:UIAlertActionStyle.Default, handler: {
                    (alert: UIAlertAction!) in
                    self.remindMeLater()
                }))
            }
            alertView.addAction(UIAlertAction(title: rateButtonTitle, style:UIAlertActionStyle.Default, handler: {
                (alert: UIAlertAction!) in
                self._rateApp()
            }))

            // get the top most controller (= the StoreKit Controller) and dismiss it
            if let presentingController = UIApplication.sharedApplication().keyWindow?.rootViewController {
                if let topController = topMostViewController(presentingController) {
                    topController.presentViewController(alertView, animated: usesAnimation) {
                        print("presentViewController() completed")
                    }
                }
            }

        } else {
            /* Otherwise we use UIAlertView still */
            var alertView: UIAlertView
            if (showsRemindButton()) {
                alertView = UIAlertView(title: reviewTitle, message: reviewMessage, delegate: self, cancelButtonTitle: cancelButtonTitle, otherButtonTitles: remindButtonTitle!, rateButtonTitle)
            } else {
                alertView = UIAlertView(title: reviewTitle, message: reviewMessage, delegate: self, cancelButtonTitle: cancelButtonTitle, otherButtonTitles: rateButtonTitle)
            }
            // If we have a remind button, show it first. Otherwise show the rate button
            // If we have a remind button, show the rate button next. Otherwise stop adding buttons.

            alertView.cancelButtonIndex = -1
            ratingAlert = alertView
            alertView.show()

            if let closure = didDisplayAlertClosure {
                closure()
            }
        }

#elseif os(OSX)
    
        let alert: NSAlert = NSAlert()
        alert.messageText = reviewTitle
        alert.informativeText = reviewMessage
        alert.addButtonWithTitle(rateButtonTitle)
        if showsRemindButton() {
            alert.addButtonWithTitle(remindButtonTitle!)
        }
        alert.addButtonWithTitle(cancelButtonTitle)
        ratingAlert = alert

        if let window = NSApplication.sharedApplication().keyWindow {
            alert.beginSheetModalForWindow(window) {
                (response: NSModalResponse) in
                self.handleNSAlertReturnCode(response)
            }
        } else {
            let returnCode = alert.runModal()
            handleNSAlertReturnCode(returnCode)
        }
        
        if let closure = self.didDisplayAlertClosure {
            closure()
        }
#else
#endif
    }

    // MARK: -
    // MARK: PRIVATE Alert View / StoreKit Delegate Methods

#if os(iOS)
    public func alertView(alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        // cancelButtonIndex is set to -1 to show the cancel button up top, but a tap on it ends up here with index 0
        if (alertView.cancelButtonIndex == buttonIndex || 0 == buttonIndex) {
            // they don't want to rate it
            dontRate()
        } else if (showsRemindButton() && 1 == buttonIndex) {
            // remind them later
            remindMeLater()
        } else {
            // they want to rate it
            _rateApp()
        }
    }

    //Delegate call from the StoreKit view.
    public func productViewControllerDidFinish(viewController: SKStoreProductViewController!) {
        closeModalPanel()
    }

    //Close the in-app rating (StoreKit) view and restore the previous status bar style.
    private func closeModalPanel() {
        if modalPanelOpen {
            UIApplication.sharedApplication().setStatusBarStyle(currentStatusBarStyle, animated:usesAnimation)
            let usedAnimation = usesAnimation
            modalPanelOpen = false

            // get the top most controller (= the StoreKit Controller) and dismiss it
            if let presentingController = UIApplication.sharedApplication().keyWindow?.rootViewController {
                if let topController = topMostViewController(presentingController) {
                    topController.dismissViewControllerAnimated(usesAnimation) {
                        if let closure = self.didDismissModalViewClosure {
                            closure(usedAnimation)
                        }
                    }
                    currentStatusBarStyle = UIStatusBarStyle.Default
                }
            }
        }
    }

#elseif os(OSX)

    private func handleNSAlertReturnCode(returnCode: NSInteger) {
        switch (returnCode) {
        case  NSAlertFirstButtonReturn:
            // they want to rate it
            _rateApp()
        case  NSAlertSecondButtonReturn:
            // remind them later or cancel
            if showsRemindButton() {
                remindMeLater()
            } else {
                dontRate()
            }
        case NSAlertThirdButtonReturn:
            // they don't want to rate it
            dontRate()
        default:
            return
        }
    }

#else
#endif

    private func dontRate() {
        userDefaultsObject?.setBool(true, forKey: keyForArmchairKeyType(ArmchairKey.DeclinedToRate))
        userDefaultsObject?.synchronize()
        if let closure = didDeclineToRateClosure {
            closure()
        }
    }

    private func remindMeLater() {
        userDefaultsObject?.setDouble(NSDate().timeIntervalSince1970, forKey: keyForArmchairKeyType(ArmchairKey.ReminderRequestDate))
        userDefaultsObject?.synchronize()
        if let closure = didOptToRemindLaterClosure {
            closure()
        }
    }

    private func _rateApp() {
        rateApp()
        if let closure = didOptToRateClosure {
            closure()
        }
    }

    private func rateApp() {

        userDefaultsObject?.setBool(true, forKey: keyForArmchairKeyType(ArmchairKey.RatedCurrentVersion))
        userDefaultsObject?.setBool(true, forKey: keyForArmchairKeyType(ArmchairKey.RatedAnyVersion))
        userDefaultsObject?.synchronize()

#if os(iOS)
        // Use the in-app StoreKit view if set, available (iOS 7+) and imported. This works in the simulator.
        if opensInStoreKit {

            let storeViewController = SKStoreProductViewController()

            var productParameters: [String:AnyObject]! = [SKStoreProductParameterITunesItemIdentifier : appID]

            if (operatingSystemVersion >= 8) {
                productParameters[SKStoreProductParameterAffiliateToken] = affiliateCode
                productParameters[SKStoreProductParameterCampaignToken] = affiliateCampaignCode
            }

            storeViewController.loadProductWithParameters(productParameters, completionBlock: nil)
            storeViewController.delegate = self

            if let closure = willPresentModalViewClosure {
                closure(usesAnimation)
            }


            if let rootController = getRootViewController() {
                rootController.presentViewController(storeViewController, animated: usesAnimation) {
                    self.modalPanelOpen = true

                    //Temporarily use a status bar to match the StoreKit view.
                    self.currentStatusBarStyle = UIApplication.sharedApplication().statusBarStyle
                    UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: self.usesAnimation)
                }
            }

        //Use the standard openUrl method
        } else {
            if let url = NSURL(string: reviewURLString()) {
                UIApplication.sharedApplication().openURL(url)
            }
        }

        if UIDevice.currentDevice().model.rangeOfString("Simulator") != nil {
            debugLog("iTunes App Store is not supported on the iOS simulator.")
            debugLog(" - We would have went to \(reviewURLString()).")
            debugLog(" - Try running on a test-device")
            let fakeURL = reviewURLString().stringByReplacingOccurrencesOfString("itms-apps", withString:"http")
            debugLog(" - Or try copy/pasting \(fakeURL) into a browser on your computer.")
        }
#elseif os(OSX)
        if let url = NSURL(string: reviewURLString()) {
            let opened = NSWorkspace.sharedWorkspace().openURL(url)
            if !opened {
                debugLog("Failed to open \(url)")
            }
        }
#else
#endif
    }

    private func reviewURLString() -> String {
        let template = reviewURLTemplate
        var reviewURL = template.stringByReplacingOccurrencesOfString("APP_ID", withString: "\(appID)")
        reviewURL = reviewURL.stringByReplacingOccurrencesOfString("AFFILIATE_CODE", withString: "\(affiliateCode)")
        reviewURL = reviewURL.stringByReplacingOccurrencesOfString("AFFILIATE_CAMPAIGN_CODE", withString: "\(affiliateCampaignCode)")
        return reviewURL
    }

    // Mark: -
    // Mark: PRIVATE Key Helpers

    private func trackingInfo() -> ArmchairTrackingInfo {
        var trackingInfo: Dictionary<ArmchairKey, AnyObject> = [:]

        for keyType in ArmchairKey.allValues {
            let obj: AnyObject? = userDefaultsObject?.objectForKey(keyForArmchairKeyType(keyType))
            if let val = obj as? NSObject {
                trackingInfo[keyType] = val
            } else {
                trackingInfo[keyType] = NSNull()
            }
        }

        return ArmchairTrackingInfo(info: trackingInfo)
    }

    private func keyForArmchairKeyType(keyType: ArmchairKey) -> String {
        switch (keyType) {
        case .FirstUseDate:
            return keyPrefix + armchairKeyFirstUseDate
        case .UseCount:
            return keyPrefix + armchairKeyUseCount
        case .SignificantEventCount:
            return keyPrefix + armchairKeySignificantEventCount
        case .CurrentVersion:
            return keyPrefix + armchairKeyCurrentVersion
        case .RatedCurrentVersion:
            return keyPrefix + armchairKeyRatedCurrentVersion
        case .DeclinedToRate:
            return keyPrefix + armchairKeyDeclinedToRate
        case .ReminderRequestDate:
            return keyPrefix + armchairKeyReminderRequestDate
        case .PreviousVersion:
            return keyPrefix + armchairKeyPreviousVersion
        case .PreviousVersionRated:
            return keyPrefix + armchairKeyPreviousVersionRated
        case .PreviousVersionDeclinedToRate:
            return keyPrefix + armchairKeyPreviousVersionDeclinedToRate
        case .RatedAnyVersion:
            return keyPrefix + armchairKeyRatedAnyVersion
        case .AppiraterMigrationCompleted:
            return keyPrefix + armchairKeyAppiraterMigrationCompleted
        case .UAAppReviewManagerMigrationCompleted:
            return keyPrefix + armchairKeyUAAppReviewManagerMigrationCompleted
        }
    }

    private func setKey(key: NSString, armchairKeyType: ArmchairKey) {
        switch armchairKeyType {
        case .FirstUseDate:
            armchairKeyFirstUseDate = key as String
        case .UseCount:
            armchairKeyUseCount = key as String
        case .SignificantEventCount:
            armchairKeySignificantEventCount = key as String
        case .CurrentVersion:
            armchairKeyCurrentVersion = key as String
        case .RatedCurrentVersion:
            armchairKeyRatedCurrentVersion = key as String
        case .DeclinedToRate:
            armchairKeyDeclinedToRate = key as String
        case .ReminderRequestDate:
            armchairKeyReminderRequestDate = key as String
        case .PreviousVersion:
            armchairKeyPreviousVersion = key as String
        case .PreviousVersionRated:
            armchairKeyPreviousVersionRated = key as String
        case .PreviousVersionDeclinedToRate:
            armchairKeyPreviousVersionDeclinedToRate = key as String
        case .RatedAnyVersion:
            armchairKeyRatedAnyVersion = key as String
        case .AppiraterMigrationCompleted:
            armchairKeyAppiraterMigrationCompleted = key as String
        case .UAAppReviewManagerMigrationCompleted:
            armchairKeyUAAppReviewManagerMigrationCompleted = key as String
        }
    }

    private func armchairKeyForAppiraterKey(appiraterKey: String) -> String {
        switch appiraterKey {
        case AppiraterKey.FirstUseDate:
            return keyForArmchairKeyType(ArmchairKey.FirstUseDate)
        case AppiraterKey.UseCount:
            return keyForArmchairKeyType(ArmchairKey.UseCount)
        case AppiraterKey.SignificantEventCount:
            return keyForArmchairKeyType(ArmchairKey.SignificantEventCount)
        case AppiraterKey.CurrentVersion:
            return keyForArmchairKeyType(ArmchairKey.CurrentVersion)
        case AppiraterKey.RatedCurrentVersion:
            return keyForArmchairKeyType(ArmchairKey.RatedCurrentVersion)
        case AppiraterKey.DeclinedToRate:
            return keyForArmchairKeyType(ArmchairKey.DeclinedToRate)
        case AppiraterKey.ReminderRequestDate:
            return keyForArmchairKeyType(ArmchairKey.ReminderRequestDate)
        case AppiraterKey.RatedAnyVersion:
            return keyForArmchairKeyType(ArmchairKey.RatedAnyVersion)
        default:
            return ""
        }
    }

    private func migrateAppiraterKeysIfNecessary() {

        let appiraterAlreadyCompletedKey: NSString = keyForArmchairKeyType(.AppiraterMigrationCompleted)
        let appiraterMigrationAlreadyCompleted = userDefaultsObject?.boolForKey(appiraterAlreadyCompletedKey as String)

        if let completed = appiraterMigrationAlreadyCompleted {
            if completed {
                return
            }
        }

        let oldKeys: [String] = [AppiraterKey.FirstUseDate,
                                 AppiraterKey.UseCount,
                                 AppiraterKey.SignificantEventCount,
                                 AppiraterKey.CurrentVersion,
                                 AppiraterKey.RatedCurrentVersion,
                                 AppiraterKey.RatedAnyVersion,
                                 AppiraterKey.DeclinedToRate,
                                 AppiraterKey.ReminderRequestDate]
        for oldKey in oldKeys {
            let oldValue: NSObject? = userDefaultsObject?.objectForKey(oldKey) as? NSObject
            if let val = oldValue {
                let newKey = armchairKeyForAppiraterKey(oldKey)
                userDefaultsObject?.setObject(val, forKey: newKey)
                userDefaultsObject?.removeObjectForKey(oldKey)
            }
        }

        userDefaultsObject?.setObject(NSNumber(bool: true), forKey: appiraterAlreadyCompletedKey as String)
        userDefaultsObject?.synchronize()
    }

    // This only supports the default UAAppReviewManager keys. If you customized them, you will have to manually migrate your values over.
    private func migrateUAAppReviewManagerKeysIfNecessary() {
        let appReviewManagerAlreadyCompletedKey: NSString = keyForArmchairKeyType(.UAAppReviewManagerMigrationCompleted)
        let appReviewManagerMigrationAlreadyCompleted = userDefaultsObject?.boolForKey(appReviewManagerAlreadyCompletedKey as String)

        if let completed = appReviewManagerMigrationAlreadyCompleted {
            if completed {
                return
            }
        }

        // By default, UAAppReviewManager keys are in the format <appID>_UAAppReviewManagerKey<keyType>
        let oldKeys: [String:ArmchairKey] = ["\(appID)_UAAppReviewManagerKeyFirstUseDate"                    : ArmchairKey.FirstUseDate,
                                            "\(appID)_UAAppReviewManagerKeyUseCount"                        : ArmchairKey.UseCount,
                                            "\(appID)_UAAppReviewManagerKeySignificantEventCount"           : ArmchairKey.SignificantEventCount,
                                            "\(appID)_UAAppReviewManagerKeyCurrentVersion"                  : ArmchairKey.CurrentVersion,
                                            "\(appID)_UAAppReviewManagerKeyRatedCurrentVersion"             : ArmchairKey.RatedCurrentVersion,
                                            "\(appID)_UAAppReviewManagerKeyDeclinedToRate"                  : ArmchairKey.DeclinedToRate,
                                            "\(appID)_UAAppReviewManagerKeyReminderRequestDate"             : ArmchairKey.ReminderRequestDate,
                                            "\(appID)_UAAppReviewManagerKeyPreviousVersion"                 : ArmchairKey.PreviousVersion,
                                            "\(appID)_UAAppReviewManagerKeyPreviousVersionRated"            : ArmchairKey.PreviousVersionRated,
                                            "\(appID)_UAAppReviewManagerKeyPreviousVersionDeclinedToRate"   : ArmchairKey.PreviousVersionDeclinedToRate,
                                            "\(appID)_UAAppReviewManagerKeyRatedAnyVersion"                 : ArmchairKey.RatedAnyVersion]
        for (oldKey, newKeyType) in oldKeys {
            let oldValue: NSObject? = userDefaultsObject?.objectForKey(oldKey) as? NSObject
            if let val = oldValue {
                userDefaultsObject?.setObject(val, forKey: keyForArmchairKeyType(newKeyType))
                userDefaultsObject?.removeObjectForKey(oldKey)
            }
        }

        userDefaultsObject?.setObject(NSNumber(bool: true), forKey: appReviewManagerAlreadyCompletedKey as String)
        userDefaultsObject?.synchronize()
    }

    private func migrateKeysIfNecessary() {
        migrateAppiraterKeysIfNecessary()
        migrateUAAppReviewManagerKeysIfNecessary()
    }

    // MARK: -
    // MARK: Internet Connectivity

    private func connectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        guard let defaultRouteReachability = withUnsafePointer(&zeroAddress, {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }) else {
            return false
        }

        var flags : SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }

        let isReachable = flags.contains(.Reachable)
        let needsConnection = flags.contains(.ConnectionRequired)
        return (isReachable && !needsConnection)
    }

    // MARK: -
    // MARK: PRIVATE Misc Helpers

    private func bundle() -> NSBundle? {
        var bundle: NSBundle? = nil
        
        if useMainAppBundleForLocalizations {
            bundle = NSBundle.mainBundle()
        } else {
            let armchairBundleURL: NSURL? = NSBundle.mainBundle().URLForResource("Armchair", withExtension: "bundle")
            if let url = armchairBundleURL {
                bundle = NSBundle(URL: url)
            } else {
                bundle = NSBundle.mainBundle()
            }
        }

        return bundle
    }

#if os(iOS)
    private func topMostViewController(controller: UIViewController?) -> UIViewController? {
        var isPresenting: Bool = false
        var topController: UIViewController? = controller
        repeat {
            // this path is called only on iOS 6+, so -presentedViewController is fine here.
            if let controller = topController {
                if let presented = controller.presentedViewController {
                    isPresenting = true
                    topController = presented
                } else {
                    isPresenting = false
                }
            }
        } while isPresenting

        return topController
    }

    private func getRootViewController() -> UIViewController? {
        if var window = UIApplication.sharedApplication().keyWindow {

            if window.windowLevel != UIWindowLevelNormal {
                let windows: NSArray = UIApplication.sharedApplication().windows
                for candidateWindow in windows {
                    if let candidateWindow = candidateWindow as? UIWindow {
                        if candidateWindow.windowLevel == UIWindowLevelNormal {
                            window = candidateWindow
                            break
                        }
                    }
                }
            }

            for subView in window.subviews {
                if let responder = subView.nextResponder() {
                    if responder.isKindOfClass(UIViewController) {
                        return topMostViewController(responder as? UIViewController)
                    }

                }
            }
        }

        return nil
    }
#endif

    private func hideRatingAlert() {
        if let alert = ratingAlert {
            debugLog("Hiding Alert")
#if os(iOS)
            if alert.visible {
                alert.dismissWithClickedButtonIndex(alert.cancelButtonIndex, animated: false)
            }
#elseif os(OSX)
            if let window = NSApplication.sharedApplication().keyWindow {
                if let parent = window.sheetParent {
                    parent.endSheet(window)
                }
            }
    
    #else
#endif
            ratingAlert = nil
        }
    }

    private func defaultAffiliateCode() -> String {
        return "11l7j9"
    }

    private func defaultAffiliateCampaignCode() -> String {
        return "Armchair"
    }

    // MARK: -
    // MARK: Notification Handlers

    public func appWillResignActive(notification: NSNotification) {
        debugLog("appWillResignActive:")
        hideRatingAlert()
    }

    public func applicationDidFinishLaunching(notification: NSNotification) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)) {
            self.debugLog("applicationDidFinishLaunching:")
            self.migrateKeysIfNecessary()
            self.incrementUseCount()
        }
    }

    public func applicationWillEnterForeground(notification: NSNotification) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)) {
            self.debugLog("applicationWillEnterForeground:")
            self.migrateKeysIfNecessary()
            self.incrementUseCount()
        }
    }

    // MARK: -
    // MARK: Singleton
    public class var defaultManager: Manager {
        assert(Armchair.appID != "", "Armchair.appID(appID: String) has to be the first Armchair call made.")
        struct Singleton {
            static let instance: Manager = Manager(appID: Armchair.appID)
        }
        return Singleton.instance
    }

    init(appID: String) {
        super.init()
        setupNotifications()
    }

    // MARK: Singleton Instance Setup

    private func setupNotifications() {
#if os(iOS)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appWillResignActive:",            name: UIApplicationWillResignActiveNotification,    object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationDidFinishLaunching:",  name: UIApplicationDidFinishLaunchingNotification,  object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillEnterForeground:", name: UIApplicationWillEnterForegroundNotification, object: nil)
#elseif os(OSX)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appWillResignActive:",            name: NSApplicationWillResignActiveNotification,    object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationDidFinishLaunching:",  name: NSApplicationDidFinishLaunchingNotification,  object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillEnterForeground:", name: NSApplicationWillBecomeActiveNotification,    object: nil)
#else
#endif
    }

    // MARK: -
    // MARK: Printable
    override public var debugDescription: String {
        get {
            return "Armchair: appID=\(Armchair.appID)"
        }
    }

    // MARK: -
    // MARK: Debug

    let lockQueue = dispatch_queue_create("com.armchair.lockqueue", nil)

    private func debugLog(log: String) {
        if debugEnabled {
            dispatch_sync(lockQueue, {
                print("[Armchair] \(log)")
            })
        }
    }
}
