//
//  CK2Folder+Networking.h
//  CanvasKit
//
//  Created by Jason Larsen on 10/14/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CK2Folder.h"

@class CK2PagedResponse;
@class CK2Course;

@interface CK2Folder (Networking)

/**
 Fetch a folder with a specific ID.
 
 @param folderID the ID of the folder to fetch
 @param success a block that takes in the fetched CK2Folder
 @param failure error handling blocks
 */
+ (void)fetchFolder:(NSString *)folderID success:(void(^)(CK2Folder *folder))success failure:(void(^)(NSError *error))failure;

/**
 Every course has a root folder which contains all the files
 and folders for the course. This method fetches that folder,
 which can in turn in be used to fetch the entire file tree.
 
 @param course the course to fetch the root folder for
 @param success block that takes in the fetched root CK2Folder
 @param failure error handling block
 */
+ (void)fetchRootFolderForCourse:(CK2Course *)course success:(void(^)(CK2Folder *folder))success failure:(void(^)(NSError *error))failure;

/**
 Fetch the folders inside this folder.
 
 @param success success block that accepts a CK2PagedResponse object of CK2Folders.
 @param failure error handling block
 */
- (void)fetchFoldersWithSuccess:(void(^)(CK2PagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure;

/**
 Fetch the files in this folder.
 
 @param success success block that accepts a CK2PagedResponse object of CK2Files.
 @param failure error handling block
 */
- (void)fetchFilesWithSuccess:(void(^)(CK2PagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure;

@end
