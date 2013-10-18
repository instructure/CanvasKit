//
//  CK2Service+Networking.m
//  CanvasKit
//
//  Created by Miles Wright on 10/15/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Service+Networking.h"

#import "CK2Client.h"

@implementation CK2Service (Networking)

+ (void)fetchServiceSuccess:(void (^)(CK2Service *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [CK2RootContext.path stringByAppendingPathComponent:@"services/kaltura"];
    [[CK2Client sharedClient] fetchModelAtPath:path parameters:nil modelClass:[CK2Service class] context:CK2RootContext success:(void (^)(CK2Model *service))success failure:failure];
}

@end
