//
//  CKITab.m
//  CanvasKit
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKITab.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"

@implementation CKITab
@dynamic context;

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
                               @"htmlURL": @"html_url",
                               @"label": @"label",
                               @"type": @"type"
                               };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

+ (NSValueTransformer *)htmlURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)idJSONTransformer
{
    return nil; 
}

@end
