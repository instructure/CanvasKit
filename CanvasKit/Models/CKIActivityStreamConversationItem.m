//
//  CKIActivityStreamConversationItem.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/4/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIActivityStreamConversationItem.h"

#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"

@implementation CKIActivityStreamConversationItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
        @"isPrivate": @"private",
        @"participantCount": @"participant_count"
    };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

@end
