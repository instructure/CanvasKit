//
// CKISubmissionSet.m
// Created by Jason Larsen on 5/6/14.
//

#import "CKISubmissionSet.h"
#import "NSDictionary+DictionaryByAddingObjectsFromDictionary.h"
#import "CKISubmission.h"

@interface CKISubmissionSet ()

@end

@implementation CKISubmissionSet

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    NSDictionary *keyPaths = @{
            @"id" : @"user_id",
            @"submissions" : @"submission_history"
    };
    NSDictionary *superPaths = [super JSONKeyPathsByPropertyKey];
    return [superPaths dictionaryByAddingObjectsFromDictionary:keyPaths];
}

+ (NSValueTransformer *)submissionsJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[CKISubmission class]];
}

- (CKISubmission *)mostRecentSubmission
{
    return self.submissions.lastObject;
}

- (NSString *)userID
{
    return self.id;
}

- (void)setUserID:(NSString *)userID
{
    _id = userID;
}

@end