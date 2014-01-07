//
//  CKICourse.m
//  CanvasKit
//
//  Created by rroberts on 9/10/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKICourse.h"
#import "NSValueTransformer+CKIPredefinedTransformerAdditions.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"
#import "CKITerm.h"

@implementation CKICourse

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
        @"sisCourseId": @"sis_course_id",
        @"name": @"name",
        @"courseCode": @"course_code",
        @"workflowState": @"workflow_state",
        @"accountId": @"account_id",
        @"startAt": @"start_at",
        @"endAt": @"end_at",
        @"enrollments": @"enrollments",
        @"calendar": @"calendar.ics",
        @"defaultView": @"default_view",
        @"syllabusBody": @"syllabus_body",
        @"term": @"term",
        @"applyAssignmentGroupWeights": @"apply_assignment_group_weights",
        @"publicSyllabus" : @"public_syllabus",
        @"canCreateDiscussionTopics" : @"permissions.create_discussion_topic"
    };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

+ (NSValueTransformer *)calendarJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)startAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKIDateTransformerName];
}

+ (NSValueTransformer *)endAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKIDateTransformerName];
}

+ (NSValueTransformer *)termJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[CKITerm class]];
}

- (NSString *)path
{
    return [[self.context.path stringByAppendingPathComponent:@"courses"] stringByAppendingPathComponent:self.id];
}

@end
