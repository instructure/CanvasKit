//
//  CKCourse+Networking.m
//  CanvasKit
//
//  Created by rroberts on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKCourse+Networking.h"
#import "CKClient.h"
#import "CKTab.h"

@implementation CKCourse (Networking)

+ (void)fetchCoursesForCurrentUserWithSuccess:(void (^)(CKPagedResponse *response))success failure:(void (^)(NSError *error))failure {
    
    NSString *path = [CKRootContext.path stringByAppendingPathComponent:@"courses"];
    NSDictionary *params = @{@"include": @[@"needs_grading_count", @"syllabus_body", @"total_scores", @"term"]};
    
    [[CKClient sharedClient] fetchPagedResponseAtPath:path parameters:params modelClass:[CKCourse class] context:nil success:success failure:failure];
}

@end
