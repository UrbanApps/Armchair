// MasterViewController.swift
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

#if os(iOS)
import UIKit
class ViewController: UIViewController {
    @IBOutlet weak var languageLabel: UILabel!
}
#elseif os(OSX)
import Cocoa
class ViewController: NSViewController {
    @IBOutlet weak var languageLabel: NSTextField!
}
#else
#endif

import Armchair

extension ViewController {

#if os(iOS)
    override func viewDidLoad() {
        setLanguageLabel()
    }
#elseif os(OSX)
    
    override func awakeFromNib() {
        setLanguageLabel()
    }
    
#else
#endif

    func setLanguageLabel() {
        var languageLabelText = ""

        // Only set it if we are using Armchair localizations
        if !Armchair.useMainAppBundleForLocalizations() {
            var currentLocalization: NSString = NSBundle.mainBundle().preferredLocalizations[0] as! NSString
            // Only set it if we are using a different language than this apps development language
            if let developmentLocalization = NSBundle.mainBundle().developmentLocalization {
                if currentLocalization != developmentLocalization {
                    languageLabelText = currentLocalization as String
                    if let displayName = NSLocale(localeIdentifier: currentLocalization as String).displayNameForKey(NSLocaleIdentifier, value:currentLocalization) {
                        languageLabelText = "\(displayName): \(currentLocalization)"
                    }
                }
            }
        }
#if os(iOS)
        languageLabel.text = languageLabelText
#elseif os(OSX)
        languageLabel.stringValue = languageLabelText
#else
#endif
    }

    @IBAction func presentStandardPrompt(AnyObject) {
        resetAppReviewManager()

        // The AppID is the only required setup
        Armchair.appID(Pages)

        // Debug means that it will popup on the next available change
        Armchair.debugEnabled(true)

#if os(iOS)
        // Explicitly disable the storeKit as the default may be true if on iOS 8
        Armchair.opensInStoreKit(false)
#endif

        // true here means it is ok to show, but it doesn't matter because we have debug on.
        Armchair.userDidSignificantEvent(true)
    }

    @IBAction func presentCustomizedPrompt(AnyObject) {
        resetAppReviewManager()

        // The AppID is the only required setup
        Armchair.appID(Pages)

        // Debug means that it will popup on the next available change
        Armchair.debugEnabled(true)

        // This overrides the default value, read from your localized bundle plist
        Armchair.appName("Pong")

        // This overrides the default value, read from the UAAppReviewManager bundle plist
        Armchair.reviewTitle("Rate This Shiz")

        // This overrides the default value, read from the UAAppReviewManager bundle plist
        Armchair.reviewMessage("Yo! I werked rly hard on this shiz yo, hit me up wit some good ratings yo!")

        // This overrides the default value, read from the UAAppReviewManager bundle plist
        Armchair.cancelButtonTitle("Nah, fool")

        // This overrides the default value, read from the UAAppReviewManager bundle plist
        Armchair.rateButtonTitle("Hell yeah!")

        // This overrides the default value, read from the UAAppReviewManager bundle plist
        Armchair.remindButtonTitle("Hit me up later...")

        // This overrides the default value of 30, but it doesn't matter here because of Debug mode enabled
        Armchair.daysUntilPrompt(420)

        // This overrides the default value of 1, but it doesn't matter here because of Debug mode enabled
        Armchair.daysBeforeReminding(187)

        // This means that the popup won't show if you have already rated any version of the app, but it doesn't matter here because of Debug mode enabled
        Armchair.shouldPromptIfRated(false)

        // This overrides the default value of 20, but it doesn't matter here because of Debug mode enabled
        Armchair.significantEventsUntilPrompt(99)

        // This means that UAAppReviewManager won't track this version if it hasn't already, but it doesn't matter here because of Debug mode enabled
        Armchair.tracksNewVersions(false)

        // UAAppReviewManager comes with standard translations for dozens of Languages. If you want to provide your own translations instead,
        //  or you change the default title, message or button titles, set this to YES.
        Armchair.useMainAppBundleForLocalizations(true)

        #if os(iOS)
            // Explicitly disable the storeKit as the default may be true if on iOS 8
            Armchair.opensInStoreKit(false)
        #endif

        // This sets the Affiliate code you want to use, but is not required.
        Armchair.affiliateCode("11l7j9")

        // This sets the Affiliate campaign code for tracking, but is not required.
        Armchair.affiliateCampaignCode("Armchair-ExampleApp")

        // Armchair is block based, so setup some blocks on events
        Armchair.onDidDeclineToRate() { println("[Example App] The user just declined to rate") }
        Armchair.onDidDisplayAlert() { println("[Example App] We just displayed the rating prompt") }
        Armchair.onDidOptToRate() { println("[Example App] The user just opted to rate") }
        Armchair.onDidOptToRemindLater({ println("[Example App] The user just opted to remind later") })
#if os(iOS)
        Armchair.onWillPresentModalView({ println("[Example App] About to present the modal view. Animated: \($0)") })
        Armchair.onDidDismissModalView({ println("[Example App] Just dismissed the modal view. Animated: \($0)") })
#endif
        // Armchair has sensible defaults for the NSUserDefault keys it uses, but you can customize that here
        Armchair.setKey("kSettingsSignificantEventTally", ArmchairKey.SignificantEventCount)

        // You can also call it with a block to circumvent any of Armchair should rate logic.
        Armchair.userDidSignificantEvent({
            (trackingInfo: ArmchairTrackingInfo) -> (Bool) in
            // the trackingInfo.info dictionary has all the keys/value Armchair uses to determine whether or not to show a prompt

            println("[Example App] \(trackingInfo)")

            return true
        })

        // Or you can set a global one to get one last chance to stop the prompt, or do your own logic
        Armchair.shouldPromptClosure({
            (trackingInfo: ArmchairTrackingInfo) -> (Bool) in
            // the trackingInfo.info dictionary has all the keys/value Armchair uses to determine whether or not to show a prompt

            // This will be called once all other rating conditions have been met, but before the prompt.
            // If a local ArmchairShouldPromptClosure is called using the local methods, (like immediately above)
            // this will not be called.
            //
            // Return true to allow the prompt, false to stop the presentation.
            return true
        })
    }
    
#if os(iOS)
    @IBAction func presentStoreKitPrompt(AnyObject) {
        resetAppReviewManager()

        // The AppID is the only required setup
        Armchair.appID(Pages)

        // Debug means that it will popup on the next available change
        Armchair.debugEnabled(true)

        // This overrides the default of NO in iOS 7. Instead of going to the review page in the App Store App,
        //  the user goes to the main page of the app, in side of this app. Downsides are that it doesn't go directly to
        //  reviews and doesn't take affiliate codes
        Armchair.opensInStoreKit(true)

        // If you are opening in StoreKit, you can change whether or not to animated the push of the View Controller
        Armchair.usesAnimation(true)

        // true here means it is ok to show, but it doesn't matter because we have debug on.
        Armchair.userDidSignificantEvent(true)
    }
#endif

    func resetAppReviewManager() {
        Armchair.resetDefaults()
    }
    
    @IBAction func openUrbanApps(AnyObject) {
        if let url = NSURL(string: "http://urbanapps.com") {
#if os(iOS)
            UIApplication.sharedApplication().openURL(url)
#elseif os(OSX)
            NSWorkspace.sharedWorkspace().openURL(url)
#else
#endif
        }
    }
}
