//
//  CKICourse+Networking.m
//  CanvasKit
//
//  Created by rroberts on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKICourse+Networking.h"
#import "CKIClient.h"
#import "CKITab.h"

@implementation CKICourse (Networking)

+ (void)fetchCoursesForCurrentUserWithSuccess:(void (^)(CKIPagedResponse *response))success failure:(void (^)(NSError *error))failure {
    
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"courses"];
    NSDictionary *params = @{@"include": @[@"needs_grading_count", @"syllabus_body", @"total_scores", @"term"]};
    
    [[CKIClient currentClient] fetchPagedResponseAtPath:path parameters:params modelClass:[CKICourse class] context:nil success:success failure:failure];
}

@end
