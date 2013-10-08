//
//  CKGroup.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/1/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKGroup.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"
#import "NSValueTransformer+CKPredefinedTransformerAdditions.h"

NSString * const CKGroupJoinLevelParentContextAutoJoin = @"parent_context_auto_join";
NSString * const CKGroupJoinLevelParentContextRequest = @"parent_context_request";
NSString * const CKGroupJoinLevelInvitationOnly = @"invitation_only";

@implementation CKGroup

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
        @"groupDescription": @"description",
        @"isPublic": @"is_public",
        @"followedByUser": @"followed_by_user",
        @"membersCount": @"members_count",
        @"avatarURL": @"avatar_url",
        @"joinLevel": @"join_level",
        @"courseID": @"course_id"
    };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

+ (NSValueTransformer *)avatarURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)courseIDJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKNumberStringTransformerName];
}

@end
