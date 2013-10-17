//
//  CKExternalTool+Networking.h
//  CanvasKit
//
//  Created by nlambson on 10/10/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKExternalTool.h"

@class CKPagedResponse;
@class CKCourse;

@interface CKExternalTool (Networking)

/**
 Fetches all of the external tools for a course
 */
+ (void) fetchExternalToolsForCourse:(CKCourse *)course success:(void (^)(CKPagedResponse *response))success failure:(void (^)(NSError *error))failure;

/**
  Get a sessionless launch url for an external tool with id.
 */
+ (void) fetchSessionlessLaunchURLWithURL:(NSString *)url andCourse:(CKCourse *)course success:(void (^)(CKExternalTool *response))success failure:(void (^)(NSError *error))failure;


/**
 Get a single external tool
 */
+ (void) fetchExternalToolForCourseWithExternalToolID:(NSString *)externalToolID andCourse:(CKCourse *)course success:(void (^)(CKExternalTool *response))success failure:(void (^)(NSError *error))failure;


@end