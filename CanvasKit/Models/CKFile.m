//
//  CKFile.m
//  CanvasKit
//
//  Created by rroberts on 9/19/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKFile.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"
#import "NSValueTransformer+CKPredefinedTransformerAdditions.h"

@implementation CKFile

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
                               @"size": @"size"
                               ,@"contentType": @"content-type"
                               ,@"url": @"url"
                               ,@"displayName": @"display_name"
                               ,@"createdAt": @"created_at"
                               ,@"updatedAt": @"updated_at"
                               ,@"locked": @"locked"
                               ,@"hidden": @"hidden"
                               ,@"lockAt": @"lock_at"
                               ,@"unlockAt": @"unlock_at"
                               ,@"lockedForUser": @"locked_for_user"
                               ,@"lockInfo": @"lock_info"
                               ,@"lockExplanation": @"lock_explanation"
                               ,@"hiddenForUser": @"hidden_for_user"
                               ,@"thumbnailURL": @"thumbnail_url"
                               };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

+ (NSValueTransformer *)createdAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKDateTransformerName];
}

+ (NSValueTransformer *)updatedAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKDateTransformerName];
}

+ (NSValueTransformer *)lockAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKDateTransformerName];
}

+ (NSValueTransformer *)unlockAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKDateTransformerName];
}

+ (NSValueTransformer *)thumbnailURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)urlJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
