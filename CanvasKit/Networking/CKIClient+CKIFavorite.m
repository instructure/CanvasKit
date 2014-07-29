//
//  CKIClient+CKIFavorite.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "CKIClient+CKIFavorite.h"
#import "CKICourse.h"
#import "CKIFavorite.h"

@implementation CKIClient (CKIFavorite)

- (RACSignal *)fetchFavoriteCourses
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"users/self/favorites/courses"];
    NSDictionary *params = @{@"include": @[@"needs_grading_count", @"syllabus_body", @"total_scores", @"term"]};
    return [self fetchResponseAtPath:path parameters:params modelClass:[CKICourse class] context:nil];
}

- (NSString *)currentUserFavoritesPathStringForCourse:(CKICourse *)course
{
    return [[CKIRootContext.path stringByAppendingPathComponent:@"users/self/favorites/courses/"] stringByAppendingPathComponent:course.id];
}

- (RACSignal *)addCourse:(CKICourse *)course toFavoritesWithSuccess:(void(^)(void))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [self currentUserFavoritesPathStringForCourse:course];
    
    return [self createModelAtPath:path parameters:nil modelClass:[CKIFavorite class] context:nil];
}

- (RACSignal *)removeCourse:(CKICourse *)course fromFavoritesWithSuccess:(void(^)(void))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [self currentUserFavoritesPathStringForCourse:course];
    
    return [self deleteObjectAtPath:path modelClass:[CKIFavorite class] parameters:nil context:nil];
}

@end
