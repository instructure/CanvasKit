//
//  CKISubmissionRecord.m
//  CanvasKit
//
//  Created by Brandon Pluim on 9/5/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import "CKISubmissionRecord.h"

#import "CKISubmissionComment.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"
#import "CKIMediaComment.h"

@implementation CKISubmissionRecord

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
                               @"comments": @"submission_comments",
                               @"submissionHistory" : @"submission_history"
                               };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

+ (NSValueTransformer *)commentsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[CKISubmissionComment class]];
}

+ (NSValueTransformer *)submissionHistoryJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[CKISubmission class]];
}

- (NSString *)path {
    return [[[[[self.context path] stringByAppendingPathComponent:@"assignments"] stringByAppendingPathComponent:self.assignmentID] stringByAppendingPathComponent:@"submissions"] stringByAppendingPathComponent:self.userID];
}

@end