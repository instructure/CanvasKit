//
//  CKIConversation.m
//  CanvasKit
//
//  Created by derrick on 11/22/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIConversation.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"
#import "NSValueTransformer+CKIPredefinedTransformerAdditions.h"
#import "CKIUser.h"

@interface CKIConversation ()
@property (nonatomic) NSArray *properties;
@end

@implementation CKIConversation
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
        @"workflowState": @"workflow_state",
        @"lastMessage": @"last_message",
        @"lastMessageAt": @"last_message_at",
        @"messageCount": @"message_count",
        @"isSubscribed": @"subscribed",
        @"isPrivate": @"private",
        @"audienceContexts": @"audience_contexts",
        @"avatarURL": @"avatar_url",
    };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

+ (NSValueTransformer *)workflowStateJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *workflowState) {
        if ([workflowState isEqualToString:@"read"]) {
            return @(CKIConversationWorkflowStateRead);
        } else if ([workflowState isEqualToString:@"archived"]) {
            return @(CKIConversationWorkflowStateArchived);
        } else {
            return @(CKIConversationWorkflowStateUnread);
        }
    } reverseBlock:^id(NSNumber *state) {
        switch ([state integerValue]) {
            case CKIConversationWorkflowStateRead:
                return @"read";
            case CKIConversationWorkflowStateArchived:
                return @"archived";
            default:
            case CKIConversationWorkflowStateUnread:
                return @"unread";
        }
    }];
}

+ (NSValueTransformer *)lastMessageAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKIDateTransformerName];
}

+ (NSValueTransformer *)avatarURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)participantsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[CKIUser class]];
}

- (void)setProperties:(NSArray *)properties
{
    self.isLastAuthor = [properties containsObject:@"last_author"];
    self.hasAttachments = [properties containsObject:@"attachments"];
    self.containsMediaObjects = [properties containsObject:@"media_object"];
}

- (NSArray *)properties
{
    NSMutableArray *array = [NSMutableArray array];
    
    if (self.isLastAuthor) {
        [array addObject:@"last_author"];
    }
    if (self.hasAttachments) {
        [array addObject:@"attachments"];
    }
    if (self.containsMediaObjects) {
        [array addObject:@"media_objects"];
    }
    
    return array;
}

@end
