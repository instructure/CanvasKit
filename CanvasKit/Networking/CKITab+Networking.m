//
//  CKITab+Networking.m
//  CanvasKit
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKITab+Networking.h"
#import "CKIClient.h"

@implementation CKITab (Networking)

+ (void)fetchTabsForCourse:(CKICourse *)course success:(void (^)(CKIPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [[course path] stringByAppendingPathComponent:@"tabs"];
    [[CKIClient currentClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKITab class] context:course success:success failure:failure];
}


@end
