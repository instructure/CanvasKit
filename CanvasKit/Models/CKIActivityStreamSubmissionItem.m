//
//  CKIActivityStreamSubmissionItem.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/4/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIActivityStreamSubmissionItem.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"
#import "NSValueTransformer+CKIPredefinedTransformerAdditions.h"

@implementation CKIActivityStreamSubmissionItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
                               @"conversationID": @"conversation_id"
                               };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

+ (NSValueTransformer *)conversationIDJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKINumberStringTransformerName];
}

@end
