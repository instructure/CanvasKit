//
//  CKFolder.m
//  CanvasKit
//
//  Created by rroberts on 9/19/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKFolder.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"
#import "NSValueTransformer+CKPredefinedTransformerAdditions.h"

@implementation CKFolder

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
                               @"contextType": @"context_type"
                               ,@"contextID": @"context_id"
                               ,@"filesCount": @"files_count"
                               ,@"position": @"position"
                               ,@"updatedAt": @"updated_at"
                               ,@"foldersURL": @"folders_url"
                               ,@"filesURL": @"files_url"
                               ,@"fullName": @"full_name"
                               ,@"lockAt": @"lock_at"
                               ,@"foldersCount": @"folders_count"
                               ,@"name": @"name"
                               ,@"parentFolderID": @"parent_folder_id"
                               ,@"createdAt": @"created_at"
                               ,@"unlockAt": @"unlock_at"
                               ,@"hidden": @"hidden"
                               ,@"hiddenForUser": @"hidden_for_user"
                               ,@"locked": @"locked"
                               ,@"lockedForUser": @"locked_for_user"
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

+ (NSValueTransformer *)filesURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)foldersURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
