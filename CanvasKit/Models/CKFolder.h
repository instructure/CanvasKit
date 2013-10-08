//
//  CKFolder.h
//  CanvasKit
//
//  Created by rroberts on 9/19/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKModel.h"

@interface CKFolder : CKModel

@property (nonatomic, strong) NSString *contextType;

@property (nonatomic, strong) NSString *contextID;

@property (nonatomic) NSInteger filesCount;

@property (nonatomic) NSInteger position;

@property (nonatomic, strong) NSDate *updatedAt;

@property (nonatomic, strong) NSURL *foldersURL;

@property (nonatomic, strong) NSURL *filesURL;

@property (nonatomic, strong) NSString *fullName;

@property (nonatomic, strong) NSDate *lockAt;

@property (nonatomic) NSInteger *foldersCount;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *parentFolderID;

@property (nonatomic, strong) NSDate *createdAt;

@property (nonatomic, strong) NSDate *unlockAt;

@property (nonatomic, getter = isHidden) BOOL hidden;

@property (nonatomic, getter = isHiddenForUser) BOOL hiddenForUser;

@property (nonatomic, getter = isLocked) BOOL locked;

@property (nonatomic, getter = isLockedForUser) BOOL lockedForUser;

@end
