//
//  CKILiveAssessment.m
//  CanvasKit
//
//  Created by Derrick Hathaway on 6/9/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import "CKILiveAssessment.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"

@implementation CKILiveAssessment

+ (NSString *)keyForJSONAPIContent
{
    return @"assessments";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [[super JSONKeyPathsByPropertyKey] dictionaryByAddingObjectsFromDictionary:@{@"context": [NSNull null]}];
}

+ (NSValueTransformer *)idJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(id value) {
        return value;
    }];
}

@end
