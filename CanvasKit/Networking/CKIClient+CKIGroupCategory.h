//
//  CKIClient+CKIGroupCategory.h
//  CanvasKit
//
//  Created by Brandon Pluim on 12/8/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import <CanvasKit/CanvasKit.h>

@class CKICourse;

@interface CKIClient (CKIGroupCategory)

- (RACSignal *)fetchGroupCategoriesForCourse:(CKICourse *)course;
- (RACSignal *)fetchUsersInGroupCategory:(CKIGroupCategory *)category;

@end
