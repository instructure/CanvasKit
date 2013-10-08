//
//  CKPage+Networking.m
//  CanvasKit
//
//  Created by Jason Larsen on 9/12/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKPage+Networking.h"
#import "CKClient.h"
#import "CKCourse.h"

@implementation CKPage (Networking)

+ (void)fetchPagesForCourse:(CKCourse *)course success:(void (^)(CKPagedResponse *pagedResponse))success failure:(void (^)(NSError *))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"pages"];
    [[CKClient sharedClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKPage class] context:course success:success failure:failure];
}

+ (void)fetchPage:(NSString *)pageId forCourse:(CKCourse *)course success:(void (^)(CKPage *))success failure:(void (^)(NSError *))failure
{
    NSString * path = [course.path stringByAppendingPathComponent:@"pages"];
    path = [path stringByAppendingPathComponent:pageId];
    
    [[CKClient sharedClient] fetchModelAtPath:path parameters:nil modelClass:[CKPage class] context:course success:(void (^)(CKModel *model))success failure:failure];
}

@end
