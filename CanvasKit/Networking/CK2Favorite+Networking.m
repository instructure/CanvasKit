//
//  CK2Favorite+Networking.m
//  CanvasKit
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Favorite+Networking.h"
#import "CK2Client.h"
#import "CK2LocalUser.h"

@implementation CK2Favorite (Networking)

+ (void)fetchFavoriteCoursesWithSuccess:(void(^)(CK2PagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [[[CK2LocalUser sharedUser] path] stringByAppendingPathComponent:@"favorites/courses"];
    [[CK2Client currentClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CK2Favorite class] context:nil success:success failure:failure];
}

+ (void)addCourse:(CK2Course *)course toFavoritesWithSuccess:(void(^)(void))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [[[[CK2LocalUser sharedUser] path] stringByAppendingPathComponent:@"favorites/courses/"] stringByAppendingPathComponent:course.id];
    
    [[CK2Client currentClient] POST:path parameters:0 success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

+ (void)removeCourse:(CK2Course *)course fromFavoritesWithSuccess:(void(^)(void))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [[[[CK2LocalUser sharedUser] path] stringByAppendingPathComponent:@"favorites/courses"] stringByAppendingPathComponent:course.id];
    
    [[CK2Client currentClient] DELETE:path parameters:0 success:^(NSURLSessionDataTask *task, id responseObject) {
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
