//
//  CKTodoItem+Networking.m
//  CanvasKit
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKTodoItem+Networking.h"
#import "CKClient.h"
#import "CKLocalUser.h"

@implementation CKTodoItem (Networking)

+ (void)fetchTodoItemsForCourse:(CKCourse *)course success:(void(^)(CKPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [[course path] stringByAppendingPathComponent:@"todo"];
    [[CKClient sharedClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKTodoItem class] context:course success:success failure:failure];
}

+ (void)fetchTodoItemsForCurrentUserWithSuccess:(void(^)(CKPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [[[CKLocalUser sharedUser] path] stringByAppendingPathComponent:@"todo"];
    [[CKClient sharedClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKTodoItem class] context:nil success:success failure:failure];
}

@end
