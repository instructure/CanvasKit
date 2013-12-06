//
//  CKIClient+CKICourse.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "CKIClient+CKICourse.h"
#import "CKICourse.h"

@implementation CKIClient (CKICourse)

- (RACSignal *)fetchCoursesForCurrentUser
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"courses"];
    NSDictionary *params = @{@"include": @[@"needs_grading_count", @"syllabus_body", @"total_scores", @"term"]};
    
    return [self fetchResponseAtPath:path parameters:params modelClass:[CKICourse class] context:nil];
}

@end
