//
//  CKIClient+CKIPage.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient+CKIPage.h"
#import "CKIPage.h"
#import "CKICourse.h"

@implementation CKIClient (CKIPage)

- (RACSignal *)fetchPagesForCourse:(CKICourse *)course
{
    NSString *path = [course.path stringByAppendingPathComponent:@"pages"];
    return [self fetchResponseAtPath:path parameters:nil modelClass:[CKIPage class] context:course];
}

- (RACSignal *)fetchPage:(NSString *)pageId forCourse:(CKICourse *)course
{
    NSString * path = [course.path stringByAppendingPathComponent:@"pages"];
    path = [path stringByAppendingPathComponent:pageId];
    return [self fetchResponseAtPath:path parameters:nil modelClass:[CKIPage class] context:course];
}

- (RACSignal *)fetchPagesForContext:(id<CKIContext>)context
{
    NSString *path = [context.path stringByAppendingPathComponent:@"pages"];
    return [self fetchResponseAtPath:path parameters:nil modelClass:[CKIPage class] context:context];
}

- (RACSignal *)fetchPage:(NSString *)pageId forContext:(id<CKIContext>)context
{
    NSString * path = [context.path stringByAppendingPathComponent:@"pages"];
    path = [path stringByAppendingPathComponent:pageId];
    return [self fetchResponseAtPath:path parameters:nil modelClass:[CKIPage class] context:context];
}

@end
