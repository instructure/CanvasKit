//
//  CK2Tab+Networking.h
//  CanvasKit
//
//  Created by rroberts on 9/17/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Tab.h"
#import "CK2Course.h"

@class CK2PagedResponse;

@interface CK2Tab (Networking)

+ (void)fetchTabsForCourse:(CK2Course *)course success:(void (^)(CK2PagedResponse *pagedResponse))success failure:(void (^)(NSError *error))failure;

@end
