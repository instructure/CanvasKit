//
//  CKIPollChoice.m
//  CanvasKit
//
//  Created by Rick Roberts on 5/22/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import "CKIPollChoice.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"

@implementation CKIPollChoice

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
                               @"isCorrect": @"is_correct",
                               @"pollID": @"poll_id"
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
    return [[self.context.path stringByAppendingPathComponent:@"poll_choices"] stringByAppendingPathComponent:self.id];
}

@end
