//
//  CKIActivityStreamConversationItem.h
//  CanvasKit
//
//  Created by Jason Larsen on 11/4/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIActivityStreamItem.h"

@interface CKIActivityStreamConversationItem : CKIActivityStreamItem

@property (nonatomic) BOOL isPrivate;

@property (nonatomic) NSUInteger participantCount;

@end
