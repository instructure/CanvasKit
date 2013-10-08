//
//  CKFavorite.m
//  CanvasKit
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKFavorite.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"

@implementation CKFavorite

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
                               @"contextID": @"context_id",
                               @"contextType": @"context_type"
                               };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

@end
