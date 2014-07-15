//
//  CKIActivityStreamConversationItem.swift
//  CanvasKit
//
//  Created by Nathan Lambson on 7/10/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

import XCTest

class CKIActivityStreamConversationItemTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testJSONModelConversion() {
        var activityStreamConversationItemDictionary = Helpers.loadJSONFixture("activity_stream_conversation_item") as NSDictionary
        var streamConversationItem = CKIActivityStreamConversationItem(fromJSONDictionary: activityStreamConversationItemDictionary)
        
        XCTAssert(streamConversationItem.isPrivate, "Stream Conversation Item isPrivate was not parsed correctly")
        
        XCTAssertEqual(streamConversationItem.participantCount, 3, "Stream Discussion Item participantCount was not parsed correctly")
        
        XCTAssertEqualObjects(streamConversationItem.conversationID, "1234", "Stream Discussion Item conversationID was not parsed correctly")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
