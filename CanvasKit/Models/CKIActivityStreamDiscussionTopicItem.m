//
//  CKIActivityStreamDiscussionTopicItem.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/4/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIActivityStreamDiscussionTopicItem.h"

#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"

@implementation CKIActivityStreamDiscussionTopicItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
        @"totalRootDiscussionEntries": @"total_root_discussion_entries",
        @"requireInitialPost": @"require_initial_post",
        @"userHasPosted": @"user_has_posted"
    };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

@end
