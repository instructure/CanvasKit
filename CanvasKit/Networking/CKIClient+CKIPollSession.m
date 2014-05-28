//
//  CKIClient+CKIPollSession.m
//  CanvasKit
//
//  Created by Rick Roberts on 5/22/14.
//  Copyright (c) 2014 Instructure. All rights reserved.
//

#import "CKIClient+CKIPollSession.h"

@implementation CKIClient (CKIPollSession)

- (RACSignal *)createPollSession:(CKIPollSession *)session forPoll:(CKIPoll *)poll
{
    NSString *path = [poll.path stringByAppendingPathComponent:@"poll_sessions"];
    return [self createModelAtPath:path parameters:@{@"poll_session": @{@"course_id": session.courseID, @"course_section_id": session.courseSectionID}} modelClass:[CKIPollSession class] context:poll];
}

- (RACSignal *)fetchPublishedPollSessionsForCurrentUser
{
    NSString *path = [[CKIRootContext.path stringByAppendingPathComponent:@"poll_sessions"] stringByAppendingPathComponent:@"published"];
    return [self fetchResponseAtPath:path parameters:0 modelClass:[CKIPollSession class] context:nil];
}

- (RACSignal *)publishPollSession:(CKIPollSession *)session
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSString *path = [session.path stringByAppendingPathComponent:@"publish"];
        NSURLSessionDataTask *task = [self GET:path parameters:0 success:^(NSURLSessionDataTask *task, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

- (RACSignal *)closePollSession:(CKIPollSession *)session
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSString *path = [session.path stringByAppendingPathComponent:@"close"];
        NSURLSessionDataTask *task = [self GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
            [subscriber sendCompleted];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

@end
