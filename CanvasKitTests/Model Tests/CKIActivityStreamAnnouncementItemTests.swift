//
//  CKIActivityStreamAnnouncementItemTests.swift
//  CanvasKit
//
//  Created by Nathan Lambson on 7/17/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

import UIKit
import XCTest

class CKIActivityStreamAnnouncementItemTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testJSONModelConversion() {
        let activityStreamAnnouncementItemDictionary = Helpers.loadJSONFixture("activity_stream_announcement_item") as NSDictionary
        let streamItem = CKIActivityStreamAnnouncementItem(fromJSONDictionary: activityStreamAnnouncementItemDictionary)
        
        XCTAssertEqual(streamItem.announcementID!, "1234", "Stream Announcement Item id was not parsed correctly")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}

