//
//  JsonTests.swift
//  WXKit
//
//  Created by Charlie Wu on 4/03/2016.
//  Copyright © 2016 Charlie Wu. All rights reserved.
//

import XCTest
@testable import WXKit

class JsonTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParser() {

        let json = "{\"json\":{\"value\": \"hello\", \"number\": 4}}"
        print(json)
        do {
            let parser = try JSON(json)
            print(parser["json"]["value"].string)
            let string:String? = parser["json"].optionalValueForKey("value")
            XCTAssertEqual(string, "hello")
            XCTAssertNotEqual(string, "hello1")

            let int:Int = try parser["json"].valueForKey("number")
            XCTAssertEqual(int, 4)
            XCTAssertNotEqual(int, 1)

        } catch {
            XCTAssertTrue(false)
        }
        

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
