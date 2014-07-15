//
//  CKIExternalToolTests.swift
//  CanvasKit
//
//  Created by Nathan Lambson on 7/9/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

import XCTest

class CKIExternalToolTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testJSONModelConversion() {
        var externalToolDictionary = Helpers.loadJSONFixture("external_tool") as NSDictionary
        var extTool = CKIExternalTool(fromJSONDictionary: externalToolDictionary)
        
        var formatter = ISO8601DateFormatter()
        formatter.includeTime = true
        
        XCTAssertEqualObjects(extTool.consumerKey, "test", "External Tool consumer key was not parsed correctly")

        var date = formatter.dateFromString("2013-07-29T21:28:47Z")
        XCTAssertEqualObjects(extTool.createdAt, date, "External Tool createdAt date was not parsed correctly")
        
        XCTAssertEqualObjects(extTool.description, "This example LTI Tool Provider supports LIS Outcome pass-back and the content extension.", "External Tool description was not parsed correctly")
        
        var url = NSURL.URLWithString("lti-tool-provider.herokuapp.com")
        XCTAssertEqualObjects(extTool.domain, url, "External Tool domain was not parsed correctly")
        
        XCTAssertEqualObjects(extTool.id, "24506", "External Tool id was not parsed correctly")
        
        XCTAssertEqualObjects(extTool.name, "LTI Test Tool", "External Tool name was not parsed correctly")
        
        date = formatter.dateFromString("2013-07-29T21:28:47Z")
        XCTAssertEqualObjects(extTool.updatedAt, date, "External Tool updatedAt was not parsed correctly")
        
        url = NSURL.URLWithString("http://lti-tool-provider.herokuapp.com/lti_tool")
        XCTAssertEqualObjects(extTool.url, url, "External Tool url was not parsed correctly")

        XCTAssertEqualObjects(extTool.privacyLevel, "public", "External Tool privacyLevel was not parsed correctly")
        
        var customFields = ["key": "value", "key2": "value2"]
        XCTAssertEqualObjects(extTool.customFields, customFields, "External Tool customFields was not parsed correctly")
        
        XCTAssertEqualObjects(extTool.workflowState, "public", "External Tool workflowState was not parsed correctly")
        
        url = NSURL.URLWithString("http://lti-tool-provider.herokuapp.com/lti_tool/help")
        XCTAssertEqualObjects(extTool.vendorHelpLink, url, "External Tool vendorHelpLink was not parsed correctly")
        
        url = NSURL.URLWithString("http://lti-tool-provider.herokuapp.com/selector.png")
        XCTAssertEqualObjects(extTool.iconURL, url, "External Tool iconURL was not parsed correctly")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
