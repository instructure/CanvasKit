//
//  CKPage.h
//  CanvasKit
//
//  Created by Jason Larsen on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKLockableModel.h"

@class CKUser;

@interface CKPage : CKLockableModel

/**
 The title of the page.
 */
@property (nonatomic, copy) NSString *title;

/**
 The date the page was created.
 */
@property (nonatomic, strong) NSDate *createdAt;

/**
 The date the page was last updated.
 */
@property (nonatomic, strong) NSDate *updatedAt;

/**
 This page is hidden from students.
 
 @note Students will never see this true; pages hidden
 from them will be omitted from results
 */
@property (nonatomic) BOOL hideFromStudents;

/**
 The user that last edited this page.
 */
@property (nonatomic, readonly) CKUser *lastEditedBy;

@end
