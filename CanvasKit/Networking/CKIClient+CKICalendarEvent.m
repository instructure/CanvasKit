//
//  CKIClient+CKICalendarEvent.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient+CKICalendarEvent.h"
#import "CKICalendarEvent.h"

@implementation CKIClient (CKICalendarEvent)

- (void)fetchCalendarEventsForTodayWithSuccess:(void(^)(CKIPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"calendar_events"];
    [self fetchPagedResponseAtPath:path parameters:nil modelClass:[CKICalendarEvent class] context:nil success:success failure:failure];
}

- (void)fetchCalendarEventsFrom:(NSDate *)startDate to:(NSDate *)endDate success:(void(^)(CKIPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"calendar_events"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-mm-dd"];
    NSDictionary *params = @{@"start_date": [dateFormatter stringFromDate:startDate], @"end_date": [dateFormatter stringFromDate:endDate]};
    [self fetchPagedResponseAtPath:path parameters:params modelClass:[CKICalendarEvent class] context:nil success:success failure:failure];
}

- (void)fetchCalendarEventsWithSuccess:(void(^)(CKIPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"calendar_events"];
    NSDictionary *params = @{@"all_events": @"true"};
    [self fetchPagedResponseAtPath:path parameters:params modelClass:[CKICalendarEvent class] context:nil success:success failure:failure];
}

@end
