//
//  CK2SubmissionComment.m
//  CanvasKit
//
//  Created by Jason Larsen on 9/8/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2SubmissionComment.h"
#import "CK2User.h"
#import "NSValueTransformer+CK2PredefinedTransformerAdditions.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"

@implementation CK2SubmissionComment

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
       @"createdAt": @"created_at",
       @"authorID": @"author_id",
       @"authorName": @"author_name",
       @"avatarURL": @"avatar_url"
    };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

+ (NSValueTransformer *)createdAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CK2DateTransformerName];
}

+ (NSValueTransformer *)authorIDJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CK2NumberStringTransformerName];
}


@end
