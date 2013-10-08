//
//  CKAssignment.m
//  CanvasKit
//
//  Created by Jason Larsen on 8/22/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKAssignment.h"
#import "CKRubricCriterion.h"
#import "CKCourse.h"
#import "NSValueTransformer+CKPredefinedTransformerAdditions.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"

@implementation CKAssignment

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
        @"descriptionHTML": @"description",
        @"dueAt": @"due_at",
        @"lockAt": @"lock_at",
        @"unlockAt": @"unlock_at",
        @"courseID": @"course_id",
        @"htmlURL": @"html_url",
        @"allowedExtensions": @"allowed_extensions",
        @"assignmentGroupID": @"assignment_group_id",
        @"groupCategoryID": @"group_category_id",
        @"gradeGroupStudentsIndividually": @"grade_group_students_individually",
        @"needsGradingCount": @"needs_grading_count",
        @"peerReviews": @"peer_reviews",
        @"automaticPeerReviews": @"automatic_peer_reviews",
        @"peerReviewCount": @"peer_review_count",
        @"peerReviewsAssignAt": @"peer_reviews_assign_at"
    };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

+ (NSValueTransformer *)dueAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKDateTransformerName];
}

+ (NSValueTransformer *)lockAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKDateTransformerName];
}

+ (NSValueTransformer *)unlockAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKDateTransformerName];
}

+ (NSValueTransformer *)courseIDJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKNumberStringTransformerName];
}

+ (NSValueTransformer *)htmlURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)assignmentGroupIDJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKNumberStringTransformerName];
}

+ (NSValueTransformer *)groupCategoryIDJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKNumberStringTransformerName];
}

+ (NSValueTransformer *)peerReviewsAssignAtJSONTransformer {
    return [NSValueTransformer valueTransformerForName:CKDateTransformerName];
}

+ (NSValueTransformer *)rubricJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[CKRubricCriterion class]];
}

- (NSString *)path
{
    return [[[self.context path] stringByAppendingPathComponent:@"assignments"] stringByAppendingPathComponent:self.id];
}

@end
