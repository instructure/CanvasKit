//
//  CK2CalendarEvent+Networking.m
//  CanvasKit
//
//  Created by rroberts on 9/18/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2CalendarEvent+Networking.h"
#import "CK2Client.h"

@implementation CK2CalendarEvent (Networking)

+ (void)fetchTodaysCalendarEventsWithSuccess:(void(^)(CK2PagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [CK2RootContext.path stringByAppendingPathComponent:@"calendar_events"];
    [[CK2Client currentClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CK2CalendarEvent class] context:nil success:success failure:failure];
}

+ (void)fetchCalendarEventsFrom:(NSDate *)startDate to:(NSDate *)endDate success:(void(^)(CK2PagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [CK2RootContext.path stringByAppendingPathComponent:@"calendar_events"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-mm-dd"];
    NSDictionary *params = @{@"start_date": [dateFormatter stringFromDate:startDate], @"end_date": [dateFormatter stringFromDate:endDate]};
    [[CK2Client currentClient] fetchPagedResponseAtPath:path parameters:params modelClass:[CK2CalendarEvent class] context:nil success:success failure:failure];
}

+ (void)fetchAllCalendarEventsWithSuccess:(void(^)(CK2PagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [CK2RootContext.path stringByAppendingPathComponent:@"calendar_events"];
    NSDictionary *params = @{@"all_events": @"true"};
    [[CK2Client currentClient] fetchPagedResponseAtPath:path parameters:params modelClass:[CK2CalendarEvent class] context:nil success:success failure:failure];
}

@end
