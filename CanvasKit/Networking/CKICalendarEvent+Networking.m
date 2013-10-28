//
//  CKICalendarEvent+Networking.m
//  CanvasKit
//
//  Created by rroberts on 9/18/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKICalendarEvent+Networking.h"
#import "CKIClient.h"

@implementation CKICalendarEvent (Networking)

+ (void)fetchTodaysCalendarEventsWithSuccess:(void(^)(CKIPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"calendar_events"];
    [[CKIClient currentClient] fetchPagedResponseAtPath:path parameters:nil modelClass:[CKICalendarEvent class] context:nil success:success failure:failure];
}

+ (void)fetchCalendarEventsFrom:(NSDate *)startDate to:(NSDate *)endDate success:(void(^)(CKIPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"calendar_events"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-mm-dd"];
    NSDictionary *params = @{@"start_date": [dateFormatter stringFromDate:startDate], @"end_date": [dateFormatter stringFromDate:endDate]};
    [[CKIClient currentClient] fetchPagedResponseAtPath:path parameters:params modelClass:[CKICalendarEvent class] context:nil success:success failure:failure];
}

+ (void)fetchAllCalendarEventsWithSuccess:(void(^)(CKIPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"calendar_events"];
    NSDictionary *params = @{@"all_events": @"true"};
    [[CKIClient currentClient] fetchPagedResponseAtPath:path parameters:params modelClass:[CKICalendarEvent class] context:nil success:success failure:failure];
}

@end
