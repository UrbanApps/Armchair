//
//  ArmchairTests.swift
//  ArmchairTests
//
//  Created by Matt Coneybeare on 9/16/14.
//  Copyright (c) 2014 Armchair. All rights reserved.
//

import UIKit
import XCTest
import Armchair

class ArmchairTests: XCTestCase {

    var appID: String! = "987654321"

    override func setUp()  {
        super.setUp()

        Armchair.appID(appID)
    }

    // MARK: -

    func testAppIDSetProperly() {
        XCTAssertEqual(Armchair.appID, appID, "appID should be as set")
    }

    // Need to figure out a way to get the test suite to load the correct info.plist bundle for the test app
//    func testAppNameReadFromBundleCorrectly() {
//        XCTAssertEqual(Armchair.appName(), "Armchair Tests")
//    }

    func testAppNameNotNil() {
        XCTAssertNotNil(Armchair.appName(), "appName should never be nil")
    }
    
}
