//
//  CKIAssignment+Networking.m
//  CanvasKit
//
//  Created by derrick on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIAssignment+Networking.h"
#import "CKIClient.h"
#import "CKISubmission.h"
#import "CKICourse.h"

@implementation CKIAssignment (Networking)

+ (void)fetchAssignmentsForCourse:(CKICourse *)course withSuccess:(void(^)(CKIPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [[course path] stringByAppendingPathComponent:@"assignments"];
    
    [[CKIClient currentClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKIAssignment class] context:course success:success failure:failure];
}

@end
