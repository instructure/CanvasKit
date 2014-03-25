//
//  CKIClient+CKITab.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "CKIClient+CKITab.h"
#import "CKITab.h"
#import "CKICourse.h"

@implementation CKIClient (CKITab)

- (RACSignal *)fetchTabsForCourse:(CKICourse *)course
{
    NSString *path = [[course path] stringByAppendingPathComponent:@"tabs"];
    return [self fetchResponseAtPath:path parameters:@{@"include": @[@"external"]} modelClass:[CKITab class] context:course];
}

@end
