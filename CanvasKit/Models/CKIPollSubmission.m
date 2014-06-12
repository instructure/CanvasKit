//
//  CKIPollSubmission.m
//  CanvasKit
//
//  Created by Rick Roberts on 5/22/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import "CKIPollSubmission.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"

@implementation CKIPollSubmission

+ (NSString *)keyForJSONAPIContent
{
    return @"poll_submissions";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
                               @"pollChoiceID": [NSNull null],
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
    return [[self.context.path stringByAppendingPathComponent:@"poll_submissions"] stringByAppendingPathComponent:self.id];
}

@end
