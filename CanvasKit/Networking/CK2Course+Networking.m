//
//  CK2Course+Networking.m
//  CanvasKit
//
//  Created by rroberts on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Course+Networking.h"
#import "CK2Client.h"
#import "CK2Tab.h"

@implementation CK2Course (Networking)

+ (void)fetchCoursesForCurrentUserWithSuccess:(void (^)(CK2PagedResponse *response))success failure:(void (^)(NSError *error))failure {
    
    NSString *path = [CK2RootContext.path stringByAppendingPathComponent:@"courses"];
    NSDictionary *params = @{@"include": @[@"needs_grading_count", @"syllabus_body", @"total_scores", @"term"]};
    
    [[CK2Client sharedClient] fetchPagedResponseAtPath:path parameters:params modelClass:[CK2Course class] context:nil success:success failure:failure];
}

@end
