//
//  CKIExternalTool+Networking.m
//  CanvasKit
//
//  Created by nlambson on 10/10/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIExternalTool+Networking.h"
#import "CKIExternalTool.h"
#import "CKIClient.h"
#import "CKICourse.h"

@implementation CKIExternalTool (Networking)

+ (void) fetchExternalToolsForCourse:(CKICourse *)course success:(void (^)(CKIPagedResponse *response))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"external_tools"];
    [[CKIClient currentClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKIExternalTool class] context:course success:success failure:failure];
}

+ (void) fetchSessionlessLaunchURLWithURL:(NSString *)url andCourse:(CKICourse *)course success:(void (^)(CKIExternalTool *response))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"external_tools/sessionless_launch"];
    
    NSDictionary *params = @{@"url":url};
    
    [[CKIClient currentClient] fetchModelAtPath:path parameters:params modelClass:[CKIExternalTool class] context:course success:(void (^)(CKIModel *))success failure:failure];
}

+ (void) fetchExternalToolForCourseWithExternalToolID:(NSString *)externalToolID andCourse:(CKICourse *)course success:(void (^)(CKIExternalTool *response))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"external_tools"];
    path = [path stringByAppendingPathComponent:externalToolID];
    
    [[CKIClient currentClient] fetchModelAtPath:path parameters:nil modelClass:[CKIExternalTool class] context:course success:(void (^)(CKIModel *))success failure:failure];
}

@end
