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

- (void)fetchPagesForCourse:(CKICourse *)course success:(void (^)(CKIPagedResponse *pagedResponse))success failure:(void (^)(NSError *))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"pages"];
    [self fetchPagedResponseAtPath:path parameters:nil modelClass:[CKIPage class] context:course success:success failure:failure];
}

- (void)fetchPage:(NSString *)pageId forCourse:(CKICourse *)course success:(void (^)(CKIPage *))success failure:(void (^)(NSError *))failure
{
    NSString * path = [course.path stringByAppendingPathComponent:@"pages"];
    path = [path stringByAppendingPathComponent:pageId];
    
    [self fetchModelAtPath:path parameters:nil modelClass:[CKIPage class] context:course success:(void (^)(CKIModel *model))success failure:failure];
}

@end
