//
//  CKIClient+CKICourse.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "CKIClient+CKIModel.h"
#import "CKIClient+CKICourse.h"
#import "CKICourse.h"

@implementation CKIClient (CKICourse)

- (NSDictionary *)parametersForFetchingCourses
{
    return @{@"include": @[@"needs_grading_count", @"syllabus_body", @"total_scores", @"term", @"permissions"]};
}

- (RACSignal *)fetchCoursesForCurrentUser
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"courses"];
    
    return [self fetchResponseAtPath:path parameters:[self parametersForFetchingCourses] modelClass:[CKICourse class] context:nil];
}

- (RACSignal *)courseWithUpdatedPermissionsSignalForCourse:(CKICourse *)course
{
    return [self refreshModel:course parameters:[self parametersForFetchingCourses]];
}

@end
