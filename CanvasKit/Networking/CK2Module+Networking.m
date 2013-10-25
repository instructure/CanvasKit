//
//  CK2Module+Networking.m
//  CanvasKit
//
//  Created by Jason Larsen on 9/13/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Module+Networking.h"
#import "CK2Client.h"
#import "CK2Course.h"

@implementation CK2Module (Networking)

+ (void)fetchModulesForCourse:(CK2Course *)course success:(void (^)(CK2PagedResponse *response))success failure:(void (^)(NSError *))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"modules"];
    
    [[CK2Client currentClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CK2Module class] context:course success:success failure:failure];
}

+ (void)fetchModuleWithID:(NSString *)moduleID forCourse:(CK2Course *)course success:(void (^)(CK2Module *))success failure:(void (^)(NSError *))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"modules"];
    path = [path stringByAppendingPathComponent:moduleID];
    
    [[CK2Client currentClient] fetchModelAtPath:path parameters:nil modelClass:self context:course success:(void (^)(CK2Model *))success failure:failure];
}

@end
