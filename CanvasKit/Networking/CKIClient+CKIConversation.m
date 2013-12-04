//
//  CKIClient+CKIConversation.m
//  CanvasKit
//
//  Created by derrick on 11/22/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient+CKIConversation.h"
#import "CKIClient+CKIModel.h"

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

- (RACSignal *)refreshConversation:(CKIConversation *)conversation
{
    return [self refreshModel:conversation parameters:@{@"interleave_submissions": @(1)}];
}


- (RACSignal *)createConversationWithRecipientIDs:(NSArray *)recipients message:(NSString *)message
{
    NSString *path = [[CKIRootContext path] stringByAppendingPathComponent:@"conversations"];
    NSDictionary *parameters = @{@"recipients": recipients, @"body": message};
    
    return [self createModelAtPath:path parameters:parameters modelClass:[CKIConversation class] context:CKIRootContext];
}

- (RACSignal *)createMessage:(NSString *)message inConversation:(CKIConversation *)conversation withAttachmentIDs:(NSArray *)attachments
{
    NSString *path = [[conversation path] stringByAppendingPathComponent:@"add_message"];
    NSDictionary *parameters = @{@"body": message, @"attachment_ids" : attachments};
    
    return [self createModelAtPath:path parameters:parameters modelClass:[CKIConversation class] context:conversation.context];
}

@end
