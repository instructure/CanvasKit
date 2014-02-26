//
//  CKIFile.m
//  CanvasKit
//
//  Created by rroberts on 9/19/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIFile.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"
#import "NSValueTransformer+CKIPredefinedTransformerAdditions.h"

@implementation CKIFile

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
       @"contentType" : @"content-type",
       @"name" : @"display_name",
       @"createdAt" : @"created_at",
       @"updatedAt" : @"updated_at",
       @"hiddenForUser" : @"hidden_for_user",
       @"thumbnailURL" : @"thumbnail_url",
       @"unlockAt" : @"unlock_at",
       @"locked" : @"locked",
       @"hidden" : @"hidden",
       @"lockedAt" : @"locked_at"
    };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

+ (NSValueTransformer *)createdAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKIDateTransformerName];
}

+ (NSValueTransformer *)updatedAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKIDateTransformerName];
}

+ (NSValueTransformer *)lockAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKIDateTransformerName];
}

+ (NSValueTransformer *)unlockAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKIDateTransformerName];
}

+ (NSValueTransformer *)thumbnailURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)urlJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

- (NSString *)path
{
    NSString *path = self.context.path;
    path = [path stringByAppendingPathComponent:@"files"];
    return [path stringByAppendingPathComponent:self.id];
}

@end
