//
//  CKSubmissionComment.h
//  CanvasKit
//
//  Created by Jason Larsen on 9/8/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKModel.h"

@class CKUser;

@interface CKSubmissionComment : CKModel

/**
 The comment text.
 */
@property (nonatomic, copy) NSString *comment;

/**
 The date the comment was made;
 */
@property (nonatomic, strong) NSDate *createdAt;

/**
 The Canvas user ID of the author of the comment.
 */
@property (nonatomic, copy) NSString *authorID;

/**
 The name of the comment's author.
 */
@property (nonatomic, copy) NSString *authorName;

@end
