//
//  CK2Submission+Networking.h
//  CanvasKit
//
//  Created by rroberts on 9/16/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Submission.h"

@interface CK2Submission (Networking)

+ (void)fetchSubmissionsForContext:(CK2Model *)context success:(void (^)(NSArray *submissions))success failure:(void (^)(NSError *error))failure;

@end
