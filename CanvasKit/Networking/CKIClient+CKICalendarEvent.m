//
//  CKIClient+CKICalendarEvent.m
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "CKIClient+CKICalendarEvent.h"
#import "CKICalendarEvent.h"

@implementation CKIClient (CKICalendarEvent)

- (RACSignal *)fetchCalendarEventsForToday
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"calendar_events"];
    return [self fetchResponseAtPath:path parameters:nil modelClass:[CKICalendarEvent class] context:nil];
}

- (RACSignal *)fetchCalendarEventsFrom:(NSDate *)startDate to:(NSDate *)endDate
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"calendar_events"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-mm-dd"];
    NSDictionary *params = @{@"start_date": [dateFormatter stringFromDate:startDate], @"end_date": [dateFormatter stringFromDate:endDate]};
    return [self fetchResponseAtPath:path parameters:params modelClass:[CKICalendarEvent class] context:nil];
}

- (RACSignal *)fetchCalendarEvents
{
    NSString *path = [CKIRootContext.path stringByAppendingPathComponent:@"calendar_events"];
    NSDictionary *params = @{@"all_events": @"true"};
    return [self fetchResponseAtPath:path parameters:params modelClass:[CKICalendarEvent class] context:nil];
}

@end
