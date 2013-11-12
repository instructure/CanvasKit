//
//  CKIClient+CKIModule.h
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient.h"

@class CKICourse;
@class CKIModule;

@interface CKIClient (CKIModule)

/**
 Fetch all the modules for a given course.
 
 @param course the course that the modules are in
 @param success the block to be executed if the API call succeeds
 @param failure the block to be executed if the API call fails
 */
- (void)fetchModulesForCourse:(CKICourse *)course success:(void (^)(CKIPagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure;

/**
 Fetch a specific module for a course.
 
 @param course the course that the module is in
 @param success the block to be executed if the API call succeeds
 @param failure the block to be executed if the API call fails
 */
- (void)fetchModuleWithID:(NSString *)moduleID forCourse:(CKICourse *)course success:(void (^)(CKIModule *module))success failure:(void (^)(NSError *error))failure;

@end
