//
//  CKIClient+CKISubmissionComment.h
//  CanvasKit
//
//  Created by Brandon Pluim on 8/28/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import <CanvasKit/CanvasKit.h>

@interface CKIClient (CKISubmissionComment)

- (RACSignal *)createSubmissionComment:(CKISubmissionComment *)comment;

@end
