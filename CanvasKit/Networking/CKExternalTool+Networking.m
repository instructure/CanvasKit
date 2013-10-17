//
//  CKExternalTool+Networking.m
//  CanvasKit
//
//  Created by nlambson on 10/10/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKExternalTool+Networking.h"
#import "CKExternalTool.h"
#import "CKClient.h"
#import "CKCourse.h"

@implementation CKExternalTool (Networking)

+ (void) fetchExternalToolsForCourse:(CKCourse *)course success:(void (^)(CKPagedResponse *response))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"external_tools"];
    [[CKClient sharedClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKExternalTool class] context:course success:success failure:failure];
}

+ (void) fetchSessionlessLaunchURLWithURL:(NSString *)url andCourse:(CKCourse *)course success:(void (^)(CKExternalTool *response))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"external_tools/sessionless_launch"];
    
    NSDictionary *params = @{@"url":url};
    
    [[CKClient sharedClient] fetchModelAtPath:path parameters:params modelClass:[CKExternalTool class] context:course success:(void (^)(CKModel *))success failure:failure];
}

+ (void) fetchExternalToolForCourseWithExternalToolID:(NSString *)externalToolID andCourse:(CKCourse *)course success:(void (^)(CKExternalTool *response))success failure:(void (^)(NSError *error))failure
{
    NSString *path = [course.path stringByAppendingPathComponent:@"external_tools"];
    path = [path stringByAppendingPathComponent:externalToolID];
    
    [[CKClient sharedClient] fetchModelAtPath:path parameters:nil modelClass:[CKExternalTool class] context:course success:(void (^)(CKModel *))success failure:failure];
}

@end
