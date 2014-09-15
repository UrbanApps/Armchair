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

import UIKit
import Armchair

class ViewController: UIViewController {
    
    @IBAction func presentStandardPrompt(AnyObject) {
        resetAppReviewManager()

        // The AppID is the only required setup
        Armchair.appID("364709193") // iBooks

        // Debug means that it will popup on the next available change
        Armchair.debugEnabled(true)

        // true here means it is ok to show, but it doesn't matter because we have debug on.
        Armchair.userDidSignificantEvent(true)
    }

    @IBAction func presentCustomizedPrompt(AnyObject) {
        resetAppReviewManager()

        // The AppID is the only required setup
        Armchair.appID("364709193") // iBooks

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

        // This sets the Affiliate code you want to use, but is not required.
        Armchair.affiliateCode("11l7j9")

        // This sets the Affiliate campaign code for tracking, but is not required.
        Armchair.affiliateCampaignCode("Armchair-ExampleApp")

        // Armchair is block based, so setup some blocks on events
        Armchair.onDidDeclineToRate() { println("[Example App] The user just declined to rate") }
        Armchair.onDidDisplayAlert() { println("[Example App] We just displayed the rating prompt") }
        Armchair.onDidOptToRate() { println("[Example App] The user just opted to rate") }
        Armchair.onDidOptToRemindLater({ println("[Example App] The user just opted to remind later") })
        Armchair.onWillPresentModalView({ println("[Example App] About to present the modal view. Animated: \($0)") })
        Armchair.onDidDismissModalView({ println("[Example App] Just dismissed the modal view. Animated: \($0)") })

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

    @IBAction func presentStoreKitPrompt(AnyObject) {
        resetAppReviewManager()

        // The AppID is the only required setup
        Armchair.appID("364709193") // iBooks

        // Debug means that it will popup on the next available change
        Armchair.debugEnabled(true)

        // This overrides the default of NO and is iOS 6+. Instead of going to the review page in the App Store App,
        //  the user goes to the main page of the app, in side of this app. Downsides are that it doesn't go directly to
        //  reviews and doesn't take affiliate codes
        Armchair.opensInStoreKit(true)

        // If you are opening in StoreKit, you can change whether or not to animated the push of the View Controller
        Armchair.usesAnimation(true)

        // true here means it is ok to show, but it doesn't matter because we have debug on.
        Armchair.userDidSignificantEvent(true)
    }

    func resetAppReviewManager() {
        Armchair.resetDefaults()
    }
}
