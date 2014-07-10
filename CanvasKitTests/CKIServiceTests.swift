//
//  CKIServiceTests.swift
//  CanvasKit
//
//  Created by Rick Roberts on 7/8/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

import UIKit
import XCTest

class CKIServiceTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testJSONModelConversion() {
        
        var serviceDictionary = Helpers.loadJSONFixture("service") as NSDictionary
        var service = CKIService(fromJSONDictionary: serviceDictionary)
        
        XCTAssertEqualObjects(service.domain, NSURL(string: "kaltura.example.com"), "service domain not parsed correctly")
        XCTAssert(service.enabled, "service enabled not parsed correctly")
        XCTAssertEqualObjects(service.partnerID, "123456", "service partner id not parsed correctly")
        XCTAssertEqualObjects(service.resourceDomain, NSURL(string: "cdn.kaltura.example.com"), "service resource domain not parsed correctly")
        XCTAssertEqualObjects(service.rtmp, NSURL(string: "rtmp.example.com"), "service rmtp domain not parsed correctly")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
