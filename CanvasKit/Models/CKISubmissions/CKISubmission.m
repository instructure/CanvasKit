//
//  CKISubmissionSet.m
//  CanvasKit
//
//  Created by Jason Larsen on 8/29/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKISubmission.h"
#import "CKISubmissionComment.h"
#import "NSValueTransformer+CKIPredefinedTransformerAdditions.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"
#import "CKIAssignment.h"
#import "CKIFile.h"

NSString * const CKISubmissionTypeOnlineTextEntry = @"online_text_entry";
NSString * const CKISubmissionTypeOnlineURL = @"online_url";
NSString * const CKISubmissionTypeOnlineUpload = @"online_upload";
NSString * const CKISubmissionTypeMediaRecording = @"media_recording";

@implementation CKISubmission

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
    return [NSValueTransformer valueTransformerForName:CKINumberStringTransformerName];
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
    return [NSValueTransformer valueTransformerForName:CKIDateTransformerName];
}

+ (NSValueTransformer *)userIDJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKINumberStringTransformerName];
}

+ (NSValueTransformer *)graderIDJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:CKINumberStringTransformerName];
}

+ (NSValueTransformer *)commentsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[CKISubmissionComment class]];
}

+ (NSValueTransformer *)assignmentJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[CKIAssignment class]];
}
+ (NSValueTransformer *)attachmentsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[CKIFile class]];
}

@end
