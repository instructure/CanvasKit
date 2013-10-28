//
//  CKIRubricCriterion.m
//  CanvasKit
//
//  Created by Jason Larsen on 8/29/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIRubricCriterion.h"
#import "CKIRubricCriterionRating.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"

@implementation CKIRubricCriterion

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
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[CKIRubricCriterionRating class]];
}

- (CKIRubricCriterionRating *)selectedRating
{
    CKIRubricCriterionRating *rating;
    
    NSUInteger index = [self.ratings indexOfObjectPassingTest:^BOOL(CKIRubricCriterionRating *rating, NSUInteger idx, BOOL *stop) {
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
