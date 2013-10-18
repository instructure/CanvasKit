//
//  CKFolder+Networking.h
//  CanvasKit
//
//  Created by Jason Larsen on 10/14/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKFolder.h"

@class CKPagedResponse;
@class CKCourse;

@interface CKFolder (Networking)

/**
 Fetch a folder with a specific ID.
 
 @param folderID the ID of the folder to fetch
 @param success a block that takes in the fetched CKFolder
 @param failure error handling blocks
 */
+ (void)fetchFolder:(NSString *)folderID success:(void(^)(CKFolder *folder))success failure:(void(^)(NSError *error))failure;

/**
 Every course has a root folder which contains all the files
 and folders for the course. This method fetches that folder,
 which can in turn in be used to fetch the entire file tree.
 
 @param course the course to fetch the root folder for
 @param success block that takes in the fetched root CKFolder
 @param failure error handling block
 */
+ (void)fetchRootFolderForCourse:(CKCourse *)course success:(void(^)(CKFolder *folder))success failure:(void(^)(NSError *error))failure;

/**
 Fetch the folders inside this folder.
 
 @param success success block that accepts a CKPagedResponse object of CKFolders.
 @param failure error handling block
 */
- (void)fetchFoldersWithSuccess:(void(^)(CKPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure;

/**
 Fetch the files in this folder.
 
 @param success success block that accepts a CKPagedResponse object of CKFiles.
 @param failure error handling block
 */
- (void)fetchFilesWithSuccess:(void(^)(CKPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure;

@end
