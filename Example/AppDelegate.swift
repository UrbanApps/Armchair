// AppDelegate.swift
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
        
    @UIApplicationMain
    class AppDelegate: UIResponder, UIApplicationDelegate {
        var window: UIWindow?
        
        func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
            return true
        }
    }
    
    let Pages = "361309726" // Pages iOS
    
#elseif os(OSX)
    
    import Cocoa

    @NSApplicationMain
    class AppDelegate: NSObject, NSApplicationDelegate {
        @IBOutlet weak var window: NSWindow!
        
    }
    
    let Pages = "409201541" // Pages Mac
    
#else
#endif

import Armchair

extension AppDelegate {

    override class func initialize() {
        AppDelegate.setupArmchair()
    }

    class func setupArmchair() {
        // Normally, all the setup would be here.
        // But, because we are presenting a few different setups in the example,
        // The config will be in the view controllers
        //	 Armchair.appID("408981381") // Pages
        //
        // It is always best to load Armchair as early as possible
        // because it needs to receive application life-cycle notifications
        //
        // NOTE: The appID call always has to go before any other Armchair calls
        Armchair.appID(Pages)
        Armchair.debugEnabled(true)
    }
}


