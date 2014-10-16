//
//  CKIClient+CKISubmissionComment.m
//  CanvasKit
//
//  Created by Brandon Pluim on 8/28/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import "CKIClient+CKISubmissionComment.h"

#import "CKISubmissionComment.h"

@implementation CKIClient (CKISubmissionComment)

- (RACSignal *)createSubmissionComment:(CKISubmissionComment *)comment {
    NSMutableDictionary *commentDictionary = [@{ @"text_comment" : comment.comment } mutableCopy];
    if (comment.mediaComment.mediaID) {
        commentDictionary[@"media_comment_id"] = comment.mediaComment.mediaID;
        commentDictionary[@"media_comment_type"] = comment.mediaComment.mediaType;
    }
    NSDictionary *params = @{@"comment" : commentDictionary};
    return [self updateModel:comment.context parameters:params];
}

@end
