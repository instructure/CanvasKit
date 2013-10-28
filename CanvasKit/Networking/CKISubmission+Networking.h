//
//  CKISubmission+Networking.h
//  CanvasKit
//
//  Created by rroberts on 9/16/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKISubmission.h"

@interface CKISubmission (Networking)

+ (void)fetchSubmissionsForContext:(CKIModel *)context success:(void (^)(NSArray *submissions))success failure:(void (^)(NSError *error))failure;

@end
