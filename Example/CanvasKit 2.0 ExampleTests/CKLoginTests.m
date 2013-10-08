//
//  CKLoginTests.m
//  CanvasKit 2.0 Example
//
//  Created by rroberts on 9/18/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <KIF/KIF.h>

@interface CKLoginTests : KIFTestCase

@end

@implementation CKLoginTests

- (void)beforeAll
{
    [tester waitForTappableViewWithAccessibilityLabel:@"Login Button"];
}

- (void)testSuccessfulLogin
{
    [tester tapViewWithAccessibilityLabel:@"Login Button"];
    
}

@end
