//
//  CKIFileTests.swift
//  CanvasKit
//
//  Created by Rick Roberts on 7/9/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

import UIKit
import XCTest

class CKIFileTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testJSONModelConversion() {
        
        var fileDictionary = Helpers.loadJSONFixture("file") as NSDictionary
        var file = CKIFile(fromJSONDictionary: fileDictionary)
        
        XCTAssertEqualObjects(file.id, "569", "File id was not parsed correctly")
        XCTAssertNotNil(file.lockInfo, "File lock info was not parsed correctly")
        XCTAssertEqual(file.size, 4, "File size was not parsed correctly")
        XCTAssertEqualObjects(file.contentType, "text/plain", "File content type was not parsed correctly")
        XCTAssertEqualObjects(file.name, "file.txt", "File name was not parsed correctly")
        XCTAssertEqualObjects(file.url, NSURL(string: "http://www.example.com/files/569/download?download_frd=1/u0026verifier=c6HdZmxOZa0Fiin2cbvZeI8I5ry7yqD7RChQzb6P"), "File url was not parsed correctly")
        
        var formatter = ISO8601DateFormatter()
        formatter.includeTime = true
        
        var createdAtDate = formatter.dateFromString("2012-07-06T14:58:50Z")
        XCTAssertEqualObjects(file.createdAt, createdAtDate, "File created at date was not parsed correctly")
        
        var updatedAtDate = formatter.dateFromString("2012-07-06T14:58:50Z")
        XCTAssertEqualObjects(file.updatedAt, updatedAtDate, "File created at date was not parsed correctly")
        
        XCTAssert(file.hiddenForUser, "File is hidden for user not parsed correctly")
        XCTAssertEqualObjects(file.thumbnailURL, NSURL(string: "http://www.instructure.testing/this/url"), "File thumbnail url not parsed correctly")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
