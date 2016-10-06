//
//  handrightingTests.swift
//  handrightingTests
//
//  Created by Eric Mooney on 10/3/16.
//  Copyright © 2016 Red Joule. All rights reserved.
//

import UIKit
import XCTest

class handwritingTests: XCTestCase {
    // Tests to confirm that the Meal initializer returns when no name or a negative rating is provided.
    func testImageInitialization() {
        // Success case.
        let potentialItem = Image(name: "Hello", photo: nil, text: nil)
        XCTAssertNotNil(potentialItem)
        
        // Failure case.
        let noName = Image(name: "", photo: nil, text: "something")
        XCTAssertNil(noName, "Empty name is invalid")

    }
}
