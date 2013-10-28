//
//  CKIFile+Networking.h
//  CanvasKit
//
//  Created by Jason Larsen on 10/9/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIFile.h"

@interface CKIFile (Networking)

+ (void)fetchFile:(NSString *)fileID success:(void(^)(CKIFile *file))success failure:(void(^)(NSError *error))failure;

@end
