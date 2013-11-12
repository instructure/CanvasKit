//
//  CKIClient+CKICourse.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient+CKICourse.h"
#import "CKICourse.h"

@implementation CKIClient (CKICourse)

- (void)fetchCoursesForCurrentUserWithSuccess:(void (^)(CKIPagedResponse *response))success failure:(void (^)(NSError *error))failure {
    
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"courses"];
    NSDictionary *params = @{@"include": @[@"needs_grading_count", @"syllabus_body", @"total_scores", @"term"]};
    
    [self fetchPagedResponseAtPath:path parameters:params modelClass:[CKICourse class] context:nil success:success failure:failure];
}

@end
