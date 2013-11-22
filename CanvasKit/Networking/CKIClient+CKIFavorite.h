//
//  CKIClient+CKIFavorite.h
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient.h"

@class CKICourse;
@class RACSignal;

@interface CKIClient (CKIFavorite)

- (RACSignal *)fetchFavoriteCourses;

- (void)addCourse:(CKICourse *)course toFavoritesWithSuccess:(void(^)(void))success failure:(void(^)(NSError *error))failure;

- (void)removeCourse:(CKICourse *)course fromFavoritesWithSuccess:(void(^)(void))success failure:(void(^)(NSError *error))failure;

@end
