//
//  CKIClient+CKIFavorite.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "CKIClient+CKIFavorite.h"
#import "CKIFavorite.h"
#import "CKICourse.h"

@implementation CKIClient (CKIFavorite)

- (RACSignal *)fetchFavoriteCourses
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"users/self/favorites/courses"];
    return [self fetchResponseAtPath:path parameters:nil modelClass:[CKICourse class] context:nil];
}

- (NSString *)currentUserFavoritesPathStringForCourse:(CKICourse *)course
{
    return [[CKIRootContext.path stringByAppendingPathComponent:@"users/self/favorites/courses/"] stringByAppendingPathComponent:course.id];
}

- (void)addCourse:(CKICourse *)course toFavoritesWithSuccess:(void(^)(void))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [self currentUserFavoritesPathStringForCourse:course];
    
    [self POST:path parameters:0 success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)removeCourse:(CKICourse *)course fromFavoritesWithSuccess:(void(^)(void))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [self currentUserFavoritesPathStringForCourse:course];
    
    [self DELETE:path parameters:0 success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

@end
