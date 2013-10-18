//
//  CK2Group.m
//  CanvasKit
//
//  Created by Jason Larsen on 10/1/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Group.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"
#import "NSValueTransformer+CK2PredefinedTransformerAdditions.h"

NSString * const CK2GroupJoinLevelParentContextAutoJoin = @"parent_context_auto_join";
NSString * const CK2GroupJoinLevelParentContextRequest = @"parent_context_request";
NSString * const CK2GroupJoinLevelInvitationOnly = @"invitation_only";

@implementation CK2Group

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
    return [NSValueTransformer valueTransformerForName:CK2NumberStringTransformerName];
}

@end
