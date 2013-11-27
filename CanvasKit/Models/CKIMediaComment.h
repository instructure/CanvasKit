//
//  CKIMediaComment.h
//  CanvasKit
//
//  Created by derrick on 11/26/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIModel.h"

typedef NS_ENUM(NSInteger, CKIMediaCommentType) {
    CKIMediaCommentTypeNone,
    CKIMediaCommentTypeAudio,
    CKIMediaCommentTypeVideo
};

@interface CKIMediaComment : CKIModel

/**
 content type i.e: "video/mp4"
 */
@property (nonatomic, copy) NSString *contentType;

/**
 media type
 */
@property (nonatomic) CKIMediaCommentType mediaType;

/**
 display name
 */
@property (nonatomic, copy) NSString *displayName;

/**
 the download url for the media item
 */
@property (nonatomic, copy) NSURL *URL;

@end
