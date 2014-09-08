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
    NSString *path = comment.path;
    return [self createModelAtPath:path parameters:nil modelClass:[CKISubmissionComment class] context:comment.context];
}

@end
