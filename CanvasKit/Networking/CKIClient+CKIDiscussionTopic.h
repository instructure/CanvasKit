//
//  CKIClient+CKIDiscussionTopic.h
//  CanvasKit
//
//  Created by derrick on 12/13/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient.h"

@class CKICourse;

@interface CKIClient (CKIDiscussionTopic)
- (RACSignal *)fetchDiscussionTopicsForCourse:(CKICourse *)course;
- (RACSignal *)fetchAnnouncementsForCourse:(CKICourse *)course;
@end
