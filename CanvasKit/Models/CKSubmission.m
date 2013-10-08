//
//  CKSubmission.m
//  CanvasKit
//
//  Created by Jason Larsen on 8/29/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKSubmission.h"
#import "CKSubmissionComment.h"
#import "NSValueTransformer+CKPredefinedTransformerAdditions.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"

NSString * const CKSubmissionTypeOnlineTextEntry = @"online_text_entry";
NSString * const CKSubmissionTypeOnlineURL = @"online_url";
NSString * const CKSubmissionTypeOnlineUpload = @"online_upload";
NSString * const CKSubmissionTypeMediaRecording = @"media_recording";

@implementation CKSubmission

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
        @"assignmentID": @"assignment_id",
        @"gradeMatchesCurrentSubmission": @"grade_matches_current_submission",
        @"htmlURL": @"html_url",
        @"previewURL": @"preview_url",
        @"submittedAt": @"submitted_at",
        @"submissionType": @"submission_type",
        @"userID": @"user_id",
        @"graderID": @"grader_id",
        @"comments": @"submission_comments"
    };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

+ (NSValueTransformer *)assignmentIDJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKNumberStringTransformerName];
}

+ (NSValueTransformer *)urlJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)htmlURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)previewURLJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)submittedAtJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKDateTransformerName];
}

+ (NSValueTransformer *)userIDJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKNumberStringTransformerName];
}

+ (NSValueTransformer *)graderIDJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKNumberStringTransformerName];
}

+ (NSValueTransformer *)commentsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[CKSubmissionComment class]];
}

@end
