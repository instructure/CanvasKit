//
//  CK2File+Networking.h
//  CanvasKit
//
//  Created by Jason Larsen on 10/9/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2File.h"

@interface CK2File (Networking)

+ (void)fetchFile:(NSString *)fileID success:(void(^)(CK2File *file))success failure:(void(^)(NSError *error))failure;

@end
