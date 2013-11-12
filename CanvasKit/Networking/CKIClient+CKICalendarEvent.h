//
//  CKIClient+CKICalendarEvent.h
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient.h"

@interface CKIClient (CKICalendarEvent)

/**
 Fetches only today's calendar events for the current user
 */
- (void)fetchCalendarEventsForTodayWithSuccess:(void(^)(CKIPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure;

/**
 Fetches the calendar events between the start date and the end date for the current user
 
 @param startDate the earlist possible date for a returned calendar event
 @param endDate the latest possible date for a returned calendar event
 */
- (void)fetchCalendarEventsFrom:(NSDate *)startDate to:(NSDate *)endDate success:(void(^)(CKIPagedResponse *events))success failure:(void(^)(NSError *error))failure;

/**
 Fetches all of the calendar events for the current user
 */
- (void)fetchCalendarEventsWithSuccess:(void(^)(CKIPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure;

@end
