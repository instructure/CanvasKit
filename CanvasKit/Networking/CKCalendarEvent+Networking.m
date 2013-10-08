//
//  CKCalendarEvent+Networking.m
//  CanvasKit
//
//  Created by rroberts on 9/18/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKCalendarEvent+Networking.h"
#import "CKClient.h"

@implementation CKCalendarEvent (Networking)

+ (void)fetchTodaysCalendarEventsWithSuccess:(void(^)(CKPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [CKRootContext.path stringByAppendingPathComponent:@"calendar_events"];
    [[CKClient sharedClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKCalendarEvent class] context:nil success:success failure:failure];
}

+ (void)fetchCalendarEventsFrom:(NSDate *)startDate to:(NSDate *)endDate success:(void(^)(CKPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [CKRootContext.path stringByAppendingPathComponent:@"calendar_events"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-mm-dd"];
    NSDictionary *params = @{@"start_date": [dateFormatter stringFromDate:startDate], @"end_date": [dateFormatter stringFromDate:endDate]};
    [[CKClient sharedClient] fetchPagedResponseAtPath:path parameters:params modelClass:[CKCalendarEvent class] context:nil success:success failure:failure];
}

+ (void)fetchAllCalendarEventsWithSuccess:(void(^)(CKPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [CKRootContext.path stringByAppendingPathComponent:@"calendar_events"];
    NSDictionary *params = @{@"all_events": @"true"};
    [[CKClient sharedClient] fetchPagedResponseAtPath:path parameters:params modelClass:[CKCalendarEvent class] context:nil success:success failure:failure];
}

@end
