//
//  CKIClient+CKIConversation.h
//  CanvasKit
//
//  Created by derrick on 11/22/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient.h"
#import "CKIConversation.h"

typedef NS_ENUM(NSInteger, CKIConversationScope) {
    CKIConversationScopeInbox,
    CKIConversationScopeUnread,
    CKIConversationScopeArchived,
    CKIConversationScopeStarred,
};

@interface CKIClient (CKIConversation)
- (RACSignal *)fetchConversationsInScope:(CKIConversationScope)scope;

/**
 on success the signal will send a single CKIConversation object (pretty sure)
 */
- (RACSignal *)createConversationWithRecipientIDs:(NSArray *)recipients message:(NSString *)message;
@end
