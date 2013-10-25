//
//  CK2Page+Networking.m
//  CanvasKit
//
//  Created by Jason Larsen on 9/12/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Page+Networking.h"
#import "CK2Client.h"
#import "CK2Course.h"

@implementation CK2Page (Networking)

+ (void)fetchPagesForCourse:(CK2Course *)course success:(void (^)(CK2PagedResponse *pagedResponse))success failure:(void (^)(NSError *))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"pages"];
    [[CK2Client currentClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CK2Page class] context:course success:success failure:failure];
}

+ (void)fetchPage:(NSString *)pageId forCourse:(CK2Course *)course success:(void (^)(CK2Page *))success failure:(void (^)(NSError *))failure
{
    NSString * path = [course.path stringByAppendingPathComponent:@"pages"];
    path = [path stringByAppendingPathComponent:pageId];
    
    [[CK2Client currentClient] fetchModelAtPath:path parameters:nil modelClass:[CK2Page class] context:course success:(void (^)(CK2Model *model))success failure:failure];
}

@end
