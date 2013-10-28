//
//  CKIFavorite+Networking.m
//  CanvasKit
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIFavorite+Networking.h"
#import "CKIClient.h"
#import "CKILocalUser.h"

@implementation CKIFavorite (Networking)

+ (void)fetchFavoriteCoursesWithSuccess:(void(^)(CKIPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [[[CKILocalUser sharedUser] path] stringByAppendingPathComponent:@"favorites/courses"];
    [[CKIClient currentClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKIFavorite class] context:nil success:success failure:failure];
}

+ (void)addCourse:(CKICourse *)course toFavoritesWithSuccess:(void(^)(void))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [[[[CKILocalUser sharedUser] path] stringByAppendingPathComponent:@"favorites/courses/"] stringByAppendingPathComponent:course.id];
    
    [[CKIClient currentClient] POST:path parameters:0 success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

+ (void)removeCourse:(CKICourse *)course fromFavoritesWithSuccess:(void(^)(void))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [[[[CKILocalUser sharedUser] path] stringByAppendingPathComponent:@"favorites/courses"] stringByAppendingPathComponent:course.id];
    
    [[CKIClient currentClient] DELETE:path parameters:0 success:^(NSURLSessionDataTask *task, id responseObject) {
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
