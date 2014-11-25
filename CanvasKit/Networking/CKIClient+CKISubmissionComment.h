//
//  CKIClient+CKISubmissionComment.h
//  CanvasKit
//
//  Created by Brandon Pluim on 8/28/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import <CanvasKit/CanvasKit.h>

#import "CKIMediaComment.h"

@class CKMediaServer;
@class CKISubmissionRecord;

typedef enum {
    CKIAttachmentMediaTypeUnknown,
    CKIAttachmentMediaTypeVideo,
    CKIAttachmentMediaTypeAudio,
    CKIAttachmentMediaTypeImage
} CKIAttachmentMediaType;

@interface CKIClient (CKISubmissionComment)

@property (nonatomic, strong) CKMediaServer *mediaServer;

- (RACSignal *)createSubmissionComment:(CKISubmissionComment *)comment;
- (void)createCommentWithMedia:(CKIMediaComment *)mediaComment forSubmissionRecord:(CKISubmissionRecord *)submissionRecord success:(void(^)(void))success failure:(void(^)(NSError *error))failure;

@end
