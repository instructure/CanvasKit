//
//  CK2RubricCriterion.m
//  CanvasKit
//
//  Created by Jason Larsen on 8/29/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2RubricCriterion.h"
#import "CK2RubricCriterionRating.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"

@implementation CK2RubricCriterion

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSDictionary *keyPaths = @{
        @"descriptionText": @"description",
        @"longDescription": @"long_description"
    };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

+ (NSValueTransformer *)ratingsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[CK2RubricCriterionRating class]];
}

- (CK2RubricCriterionRating *)selectedRating
{
    CK2RubricCriterionRating *rating;
    
    NSUInteger index = [self.ratings indexOfObjectPassingTest:^BOOL(CK2RubricCriterionRating *rating, NSUInteger idx, BOOL *stop) {
        return rating.points == self.points;
    }];
    
    if (index != NSNotFound) {
        rating = self.ratings[index];
    }
    
    return rating;
}

+ (NSValueTransformer *)idJSONTransformer
{
    return nil;
}

@end
