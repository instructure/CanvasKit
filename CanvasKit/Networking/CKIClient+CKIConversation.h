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
    CKIConversationScopeAll,
    CKIConversationScopeUnread,
    CKIConversationScopeArchived,
    CKIConversationScopeStarred,
};

@interface CKIClient (CKIConversation)
- (RACSignal *)fetchConversationsInScope:(CKIConversationScope)scope;
@end
