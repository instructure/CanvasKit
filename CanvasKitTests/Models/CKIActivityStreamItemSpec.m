//
//  CKIActivityStreamItemSpec.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/4/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "Helpers.h"
#import "CKIISO8601DateMatcher.h"

#import "CKIActivityStreamItem.h"

SPEC_BEGIN(CKIActivityStreamItemSpec)

registerMatchers(@"CKI");

describe(@"An activity stream item", ^{
    context(@"when created from json fixture", ^{
        NSDictionary *json = loadJSONFixture(@"activity_stream_item");
        CKIActivityStreamItem *streamItem = [CKIActivityStreamItem modelFromJSONDictionary:json];
        
        it(@"gets id", ^{
            [[streamItem.id should] equal:@"1234"];
        });
        
        it(@"gets the title", ^{
            [[streamItem.title should] equal:@"Stream Item Subject"];
        });
        
        it(@"gets the message", ^{
            [[streamItem.message should] equal:@"This is the body text of the activity stream item. It is plain-text, and can be multiple paragraphs."];
        });
        
        it(@"gets the course ID", ^{
            [[streamItem.courseID should] equal:@"1"];
        });
        
        it(@"gets the group ID", ^{
            [[streamItem.groupID should] equal:@"1"];
        });
        
        it(@"gets the created at date", ^{
            [[streamItem.createdAt should] equalISO8601String:@"2011-07-13T09:12:00Z"];
        });
        
        it(@"gets the updated at date", ^{
            [[streamItem.updatedAt should] equalISO8601String:@"2011-07-25T08:52:41Z"];
        });
        
        it(@"gets the canvas html URL", ^{
            NSURL *url = [NSURL URLWithString:@"http://canvas.instructure.com/api/v1/foo"];
            [[streamItem.htmlURL should] equal:url];
        });
    });
});

SPEC_END
