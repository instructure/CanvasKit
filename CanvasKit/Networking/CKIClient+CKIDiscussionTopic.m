//
//  CKIClient+CKIDiscussionTopic.m
//  CanvasKit
//
//  Created by derrick on 12/13/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient+CKIDiscussionTopic.h"
#import "CKICourse.h"
#import "CKIDiscussionTopic.h"

@implementation CKIClient (CKIDiscussionTopic)

- (RACSignal *)fetchDiscussionTopicsForCourse:(CKICourse *)course
{
    NSString *path = [course.path stringByAppendingPathComponent:@"discussion_topics"];
    return [self fetchResponseAtPath:path parameters:nil modelClass:[CKIDiscussionTopic class] context:course];
}

- (RACSignal *)fetchDiscussionTopicForCourse:(CKICourse *)course topicID:(NSString *)topicID
{
    NSString *path = [course.path stringByAppendingPathComponent:@"discussion_topics"];
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat: @"%@", topicID]];
    return [self fetchResponseAtPath:path parameters:nil modelClass:[CKIDiscussionTopic class] context:course];
}

- (RACSignal *)fetchAnnouncementsForCourse:(CKICourse *)course
{
    NSString *path = [course.path stringByAppendingPathComponent:@"discussion_topics"];
    
    NSDictionary *params = @{@"only_announcements":@"true"};
    return [self fetchResponseAtPath:path parameters:params modelClass:[CKIDiscussionTopic class] context:course];
}
@end
