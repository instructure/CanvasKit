//
//  CKTab+Networking.m
//  CanvasKit
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKTab+Networking.h"
#import "CKClient.h"

@implementation CKTab (Networking)

+ (void)fetchTabsForCourse:(CKCourse *)course success:(void (^)(CKPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [[course path] stringByAppendingPathComponent:@"tabs"];
    [[CKClient sharedClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKTab class] context:course success:success failure:failure];
}


@end
