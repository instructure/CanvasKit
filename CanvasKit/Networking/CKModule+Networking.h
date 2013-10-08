//
//  CKModule+Networking.h
//  CanvasKit
//
//  Created by Jason Larsen on 9/13/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKModule.h"

@class CKCourse;
@class CKPagedResponse;

@interface CKModule (Networking)

/**
 Fetch all the modules for a given course.
 
 @param course the course that the modules are in
 @param success the block to be executed if the API call succeeds
 @param failure the block to be executed if the API call fails
 */
+ (void)fetchModulesForCourse:(CKCourse *)course success:(void (^)(CKPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure;

/**
 Fetch a specific module for a course.
 
 @param course the course that the module is in
 @param success the block to be executed if the API call succeeds
 @param failure the block to be executed if the API call fails
 */
+ (void)fetchModuleWithID:(NSString *)moduleID forCourse:(CKCourse *)course success:(void (^)(CKModule *module))success failure:(void (^)(NSError *error))failure;

@end
