//
//  CK2Assignment+Networking.m
//  CanvasKit
//
//  Created by derrick on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Assignment+Networking.h"
#import "CK2Client.h"
#import "CK2Submission.h"
#import "CK2Course.h"

@implementation CK2Assignment (Networking)

+ (void)fetchAssignmentsForCourse:(CK2Course *)course withSuccess:(void(^)(CK2PagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [[course path] stringByAppendingPathComponent:@"assignments"];
    
    [[CK2Client currentClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CK2Assignment class] context:course success:success failure:failure];
}

@end
