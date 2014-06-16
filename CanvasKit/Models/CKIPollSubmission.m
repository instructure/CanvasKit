//
//  CKIPollSubmission.m
//  CanvasKit
//
//  Created by Rick Roberts on 5/22/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import "CKIPollSubmission.h"
#import "NSValueTransformer+CKIPredefinedTransformerAdditions.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"

@implementation CKIPollSubmission

+ (NSString *)keyForJSONAPIContent
{
    return @"poll_submissions";
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
                               @"pollChoiceID": @"poll_choice_id",
                               @"created": @"created_at",
                               @"userID": @"user_id",
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

+ (NSValueTransformer *)createdJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKIDateTransformerName];
}

+ (NSValueTransformer *)userIDJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(id userID) {
        return userID;
    }];
}

+ (NSValueTransformer *)pollChoiceIDJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithBlock:^id(id pollChoiceID) {
        return pollChoiceID;
    }];
}

- (NSString *)path
{
    return [[self.context.path stringByAppendingPathComponent:@"poll_submissions"] stringByAppendingPathComponent:self.id];
}

@end
