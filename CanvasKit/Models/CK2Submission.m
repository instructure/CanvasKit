//
//  CK2Submission.m
//  CanvasKit
//
//  Created by Jason Larsen on 8/29/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Submission.h"
#import "CK2SubmissionComment.h"
#import "NSValueTransformer+CK2PredefinedTransformerAdditions.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"

NSString * const CK2SubmissionTypeOnlineTextEntry = @"online_text_entry";
NSString * const CK2SubmissionTypeOnlineURL = @"online_url";
NSString * const CK2SubmissionTypeOnlineUpload = @"online_upload";
NSString * const CK2SubmissionTypeMediaRecording = @"media_recording";

@implementation CK2Submission

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
    return [NSValueTransformer valueTransformerForName:CK2NumberStringTransformerName];
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
    return [NSValueTransformer valueTransformerForName:CK2DateTransformerName];
}

+ (NSValueTransformer *)userIDJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CK2NumberStringTransformerName];
}

+ (NSValueTransformer *)graderIDJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CK2NumberStringTransformerName];
}

+ (NSValueTransformer *)commentsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[CK2SubmissionComment class]];
}

@end
