//
//  CK2Folder.m
//  CanvasKit
//
//  Created by rroberts on 9/19/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Folder.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"
#import "NSValueTransformer+CK2PredefinedTransformerAdditions.h"

@interface CK2Folder ()

@end

@implementation CK2Folder

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
        @"filesCount": @"files_count",
        @"updatedAt": @"updated_at",
        @"foldersURL": @"folders_url",
        @"filesURL": @"files_url",
        @"fullName": @"full_name",
        @"lockAt": @"lock_at",
        @"foldersCount": @"folders_count",
        @"parentFolderID": @"parent_folder_id",
        @"createdAt": @"created_at",
        @"unlockAt": @"unlock_at",
        @"hiddenForUser": @"hidden_for_user"
    };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

+ (NSValueTransformer *)createdAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CK2DateTransformerName];
}

+ (NSValueTransformer *)updatedAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CK2DateTransformerName];
}

+ (NSValueTransformer *)lockAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CK2DateTransformerName];
}

+ (NSValueTransformer *)unlockAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CK2DateTransformerName];
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
