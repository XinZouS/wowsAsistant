//
//  wowsAssistantTests.swift
//  wowsAssistantTests
//
//  Created by Xin Zou on 2/12/19.
//  Copyright © 2019 Xin Zou. All rights reserved.
//

import XCTest
@testable import wowsAssistant

class wowsAssistantTests: XCTestCase {

    func testNumberFormattedString() {
        let n = 888666888999233
        let r = getFormattedString(n)
        XCTAssertEqual(r, "888,666,888,999,233")
    }

}
