//
//  CKCalendarEvent+Networking.h
//  CanvasKit
//
//  Created by rroberts on 9/18/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKCalendarEvent.h"

@class CKPagedResponse;

@interface CKCalendarEvent (Networking)

/**
 Fetches only today's calendar events for the current user
 */
+ (void)fetchTodaysCalendarEventsWithSuccess:(void(^)(CKPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure;

/**
 Fetches the calendar events between the start date and the end date for the current user
 
 @param startDate the earlist possible date for a returned calendar event
 @param endDate the latest possible date for a returned calendar event
 */
+ (void)fetchCalendarEventsFrom:(NSDate *)startDate to:(NSDate *)endDate success:(void(^)(CKPagedResponse *events))success failure:(void(^)(NSError *error))failure;

/**
 Fetches all of the calendar events for the current user
 */
+ (void)fetchAllCalendarEventsWithSuccess:(void(^)(CKPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure;

@end
