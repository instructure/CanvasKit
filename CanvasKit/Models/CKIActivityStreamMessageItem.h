//
//  CKIActivityStreamMessageItem.h
//  CanvasKit
//
//  Created by Jason Larsen on 11/4/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIActivityStreamItem.h"

/**
 Generic notification message for letting students know things
 like an assignment was graded.
 */
@interface CKIActivityStreamMessageItem : CKIActivityStreamItem

/**
 The category of notification.
 */
@property (nonatomic, copy) NSString *notificationCategory;

@end
