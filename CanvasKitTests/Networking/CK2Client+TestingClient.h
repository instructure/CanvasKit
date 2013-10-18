//
//  CK2Client+TestingClient.h
//  CanvasKit
//
//  Created by derrick on 9/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Client.h"

@interface CK2Client (TestingClient)

+ (void)useTestClient;

- (void)returnErrorForPath:(NSString *)path;
- (void)returnResponseObject:(id)responseObject forPath:(NSString *)path;

@end
