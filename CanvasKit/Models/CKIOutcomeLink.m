//
//  CKIOutcomeLink.m
//  CanvasKit
//
//  Created by Brandon Pluim on 5/22/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import "CKIOutcomeLink.h"

#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"
#import "NSValueTransformer+CKIPredefinedTransformerAdditions.h"

#import "CKIOutcome.h"
#import "CKIOutcomeGroup.h"

@implementation CKIOutcomeLink

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
                               @"contextID": @"context_id",
                               @"contextType": @"context_type",
                               @"outcomeGroup": @"outcome_group",
                               @"id": @"url"
                               };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

+ (NSValueTransformer *)contextIDJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKINumberStringTransformerName];
}

+ (NSValueTransformer *)outcomeGroupJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[CKIOutcomeGroup class]];
}

+ (NSValueTransformer *)outcomeJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[CKIOutcome class]];
}

+ (NSValueTransformer *)idJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(id theStringID) {
        return theStringID;
    } reverseBlock:^id(id theStringID) {
        return theStringID;
    }];
}



- (NSString *)path
{
    return [[self.context.path stringByAppendingPathComponent:@"outcomes"] stringByAppendingPathComponent:self.id];
}

@end
