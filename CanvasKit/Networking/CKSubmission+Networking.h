//
//  CKSubmission+Networking.h
//  CanvasKit
//
//  Created by rroberts on 9/16/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKSubmission.h"

@interface CKSubmission (Networking)

+ (void)fetchSubmissionsForContext:(CKModel *)context success:(void (^)(NSArray *submissions))success failure:(void (^)(NSError *error))failure;

@end
