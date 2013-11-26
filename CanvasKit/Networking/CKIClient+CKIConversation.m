//
//  CKIClient+CKIConversation.m
//  CanvasKit
//
//  Created by derrick on 11/22/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient+CKIConversation.h"

NSString *CKIStringForConversationScope(CKIConversationScope scope) {
    switch (scope) {
        case CKIConversationScopeArchived:
            return @"archived";
        case CKIConversationScopeUnread:
            return @"unread";
        case CKIConversationScopeStarred:
            return @"starred";
        default:
            return nil;
    }
}

@implementation CKIClient (CKIConversation)
- (RACSignal *)fetchConversationsInScope:(CKIConversationScope)scope
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"conversations"];
    
    NSMutableDictionary *params = [@{@"interleave_submissions": @(1)} mutableCopy];
    NSString *scopeString = CKIStringForConversationScope(scope);
    if (scope) {
        params[@"scope"] = scopeString;
    }
    
    return [self fetchResponseAtPath:path parameters:params modelClass:[CKIConversation class] context:CKIRootContext];
}


- (RACSignal *)createConversationWithRecipientIDs:(NSArray *)recipients message:(NSString *)message
{
    NSString *path = [[CKIRootContext path] stringByAppendingPathComponent:@"conversations"];
    NSDictionary *parameters = @{@"recipients": recipients, @"body": message};
    
    return [self createModelAtPath:path parameters:parameters modelClass:[CKIConversation class] context:CKIRootContext];
}
@end
