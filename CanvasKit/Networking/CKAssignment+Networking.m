//
//  CKAssignment+Networking.m
//  CanvasKit
//
//  Created by derrick on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKAssignment+Networking.h"
#import "CKClient.h"
#import "CKSubmission.h"
#import "CKCourse.h"

@implementation CKAssignment (Networking)

- (void)fetchAssignmentsForCourse:(CKCourse *)course withSuccess:(void(^)(CKPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [[course path] stringByAppendingPathComponent:@"assignments"];
    
    [[CKClient sharedClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKAssignment class] context:course success:success failure:failure];
}

@end
