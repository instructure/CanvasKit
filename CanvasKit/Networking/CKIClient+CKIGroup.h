//
//  CKIClient+CKIGroup.h
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient.h"

@class CKIGroup;
@class CKICourse;
@class RACSignal;

@interface CKIClient (CKIGroup)

- (RACSignal *)fetchGroup:(NSString *)groupID;

- (RACSignal *)fetchGroupsForLocalUser;

- (RACSignal *)fetchGroupsForAccount:(NSString *)accountID;

- (RACSignal *)fetchGroupsForCourse:(CKICourse *)course;

@end
