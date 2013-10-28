//
//  CKIExternalTool+Networking.h
//  CanvasKit
//
//  Created by nlambson on 10/10/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIExternalTool.h"

@class CKIPagedResponse;
@class CKICourse;

@interface CKIExternalTool (Networking)

/**
 Fetches all of the external tools for a course
 */
+ (void) fetchExternalToolsForCourse:(CKICourse *)course success:(void (^)(CKIPagedResponse *response))success failure:(void (^)(NSError *error))failure;

/**
  Get a sessionless launch url for an external tool with id.
 */
+ (void) fetchSessionlessLaunchURLWithURL:(NSString *)url andCourse:(CKICourse *)course success:(void (^)(CKIExternalTool *response))success failure:(void (^)(NSError *error))failure;


/**
 Get a single external tool
 */
+ (void) fetchExternalToolForCourseWithExternalToolID:(NSString *)externalToolID andCourse:(CKICourse *)course success:(void (^)(CKIExternalTool *response))success failure:(void (^)(NSError *error))failure;


@end