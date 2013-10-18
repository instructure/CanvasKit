//
//  CK2TodoItem+Networking.m
//  CanvasKit
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2TodoItem+Networking.h"
#import "CK2Client.h"
#import "CK2LocalUser.h"

@implementation CK2TodoItem (Networking)

+ (void)fetchTodoItemsForCourse:(CK2Course *)course success:(void(^)(CK2PagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [[course path] stringByAppendingPathComponent:@"todo"];
    [[CK2Client sharedClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CK2TodoItem class] context:course success:success failure:failure];
}

+ (void)fetchTodoItemsForCurrentUserWithSuccess:(void(^)(CK2PagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [[[CK2LocalUser sharedUser] path] stringByAppendingPathComponent:@"todo"];
    [[CK2Client sharedClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CK2TodoItem class] context:nil success:success failure:failure];
}

@end
