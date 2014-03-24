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
#import "CKIGroup.h"

@implementation CKIClient (CKITab)

- (RACSignal *)fetchTabsForCourse:(CKICourse *)course
{
    NSString *path = [[course path] stringByAppendingPathComponent:@"tabs"];
    return [self fetchResponseAtPath:path parameters:nil modelClass:[CKITab class] context:course];
}

- (RACSignal *)fetchTabsForContext:(id<CKIContext>)context
{
    NSString *path = [[context path] stringByAppendingPathComponent:@"tabs"];
    return [self fetchResponseAtPath:path parameters:nil modelClass:[CKITab class] context:context];
}

@end
