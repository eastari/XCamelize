//
//  XCamelizeTests.swift
//  XCamelizeTests
//
//  Created by Starikov Yevgen on 25/07/2017.
//  Copyright © 2017 Starikov Yevgen. All rights reserved.
//

import XCTest
@testable import XCamelize
@testable import XCamelizeExtension


class XCamelizeTests: XCTestCase {
    
    override func setUp() {super.setUp()}
    override func tearDown() {super.tearDown()}
    
    
    func testCamelize() {
        let str = "no bugs"
        XCTAssert(str.camelize() == "noBugs")
    }
    
    
    
}
