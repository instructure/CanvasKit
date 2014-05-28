//
//  CKIPoll.m
//  CanvasKit
//
//  Created by Rick Roberts on 5/7/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import "CKIPoll.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"

@implementation CKIPoll

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
                               };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

+ (NSValueTransformer *)idJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(id stringID) {
        return stringID;
    }];
}

- (NSString *)path
{
    return [[self.context.path stringByAppendingPathComponent:@"polls"] stringByAppendingPathComponent:self.id];
}

@end
