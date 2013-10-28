//
//  CKITodoItem+Networking.m
//  CanvasKit
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKITodoItem+Networking.h"
#import "CKIClient.h"
#import "CKILocalUser.h"

@implementation CKITodoItem (Networking)

+ (void)fetchTodoItemsForCourse:(CKICourse *)course success:(void(^)(CKIPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [[course path] stringByAppendingPathComponent:@"todo"];
    [[CKIClient currentClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKITodoItem class] context:course success:success failure:failure];
}

+ (void)fetchTodoItemsForCurrentUserWithSuccess:(void(^)(CKIPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [[[CKILocalUser sharedUser] path] stringByAppendingPathComponent:@"todo"];
    [[CKIClient currentClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKITodoItem class] context:nil success:success failure:failure];
}

@end
