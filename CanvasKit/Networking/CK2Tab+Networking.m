//
//  CK2Tab+Networking.m
//  CanvasKit
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Tab+Networking.h"
#import "CK2Client.h"

@implementation CK2Tab (Networking)

+ (void)fetchTabsForCourse:(CK2Course *)course success:(void (^)(CK2PagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [[course path] stringByAppendingPathComponent:@"tabs"];
    [[CK2Client sharedClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CK2Tab class] context:course success:success failure:failure];
}


@end
