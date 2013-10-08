//
//  CKFile.h
//  CanvasKit
//
//  Created by rroberts on 9/19/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKModel.h"

@interface CKFile : CKModel

@property (nonatomic) NSInteger size;

@property (nonatomic, strong) NSString *contentType;

@property (nonatomic, strong) NSString *displayName;

@property (nonatomic, strong) NSString *fileName;

@property (nonatomic, strong) NSURL *url;

@property (nonatomic, strong) NSDate *createdAt;

@property (nonatomic, strong) NSDate *updatedAt;

@property (nonatomic, getter = isLocked) BOOL locked;

@property (nonatomic, getter = isHidden) BOOL hidden;

@property (nonatomic, getter = isLockedForUser) BOOL lockedForUser;

@property (nonatomic, strong) NSDictionary *lockInfo;

@property (nonatomic, strong) NSString *lockExplanation;

@property (nonatomic, getter = isHiddenForUser) BOOL hiddenForUser;

@property (nonatomic, strong) NSURL *thumbnailURL;

@property (nonatomic, strong) NSDate *lockAt;

@property (nonatomic, strong) NSDate *unlockAt;

@end
