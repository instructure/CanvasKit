//
//  CKFile+Networking.h
//  CanvasKit
//
//  Created by Jason Larsen on 10/9/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKFile.h"

@interface CKFile (Networking)

+ (void)fetchFile:(NSString *)fileID success:(void(^)(CKFile *file))success failure:(void(^)(NSError *error))failure;

@end
