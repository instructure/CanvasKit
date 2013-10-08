//
//  CKFavorite+Networking.m
//  CanvasKit
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKFavorite+Networking.h"
#import "CKClient.h"
#import "CKLocalUser.h"

@implementation CKFavorite (Networking)

+ (void)fetchFavoriteCoursesWithSuccess:(void(^)(CKPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [[[CKLocalUser sharedUser] path] stringByAppendingPathComponent:@"favorites/courses"];
    [[CKClient sharedClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKFavorite class] context:nil success:success failure:failure];
}

+ (void)addCourse:(CKCourse *)course toFavoritesWithSuccess:(void(^)(void))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [[[[CKLocalUser sharedUser] path] stringByAppendingPathComponent:@"favorites/courses/"] stringByAppendingPathComponent:course.id];
    
    [[CKClient sharedClient] POST:path parameters:0 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success();
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

+ (void)removeCourse:(CKCourse *)course fromFavoritesWithSuccess:(void(^)(void))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [[[[CKLocalUser sharedUser] path] stringByAppendingPathComponent:@"favorites/courses"] stringByAppendingPathComponent:course.id];
    
    
    [[CKClient sharedClient] DELETE:path parameters:0 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success();
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

@end
