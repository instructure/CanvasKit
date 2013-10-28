//
//  CKIPage+Networking.m
//  CanvasKit
//
//  Created by Jason Larsen on 9/12/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIPage+Networking.h"
#import "CKIClient.h"
#import "CKICourse.h"

@implementation CKIPage (Networking)

+ (void)fetchPagesForCourse:(CKICourse *)course success:(void (^)(CKIPagedResponse *pagedResponse))success failure:(void (^)(NSError *))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"pages"];
    [[CKIClient currentClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKIPage class] context:course success:success failure:failure];
}

+ (void)fetchPage:(NSString *)pageId forCourse:(CKICourse *)course success:(void (^)(CKIPage *))success failure:(void (^)(NSError *))failure
{
    NSString * path = [course.path stringByAppendingPathComponent:@"pages"];
    path = [path stringByAppendingPathComponent:pageId];
    
    [[CKIClient currentClient] fetchModelAtPath:path parameters:nil modelClass:[CKIPage class] context:course success:(void (^)(CKIModel *model))success failure:failure];
}

@end
