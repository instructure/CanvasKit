//
//  CKIClient+CKIFolder.h
//  CanvasKit
//
//  Created by Jason Larsen on 11/11/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKIClient.h"

@class CKICourse;
@class CKIFolder;

@interface CKIClient (CKIFolder)

/**
 Fetch a folder with a specific ID.
 
 @param folderID the ID of the folder to fetch
 @param success a block that takes in the fetched CKIFolder
 @param failure error handling blocks
 */
- (void)fetchFolder:(NSString *)folderID success:(void(^)(CKIFolder *folder))success failure:(void(^)(NSError *error))failure;

/**
 Every course has a root folder which contains all the files
 and folders for the course. This method fetches that folder,
 which can in turn in be used to fetch the entire file tree.
 
 @param course the course to fetch the root folder for
 @param success block that takes in the fetched root CKIFolder
 @param failure error handling block
 */
- (void)fetchRootFolderForCourse:(CKICourse *)course success:(void(^)(CKIFolder *folder))success failure:(void(^)(NSError *error))failure;

/**
 Fetch the folders inside the given folder.
 
 @param folder the folder to fetch folders from
 @param success success block that accepts a CKIPagedResponse object of CKIFolders.
 @param failure error handling block
 */
- (void)fetchFoldersForFolder:(CKIFolder *)folder success:(void(^)(CKIPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure;

/**
 Fetch the files in the given folder.
 
 @param folder the folder to fetch files from
 @param success success block that accepts a CKIPagedResponse object of CKIFiles.
 @param failure error handling block
 */
- (void)fetchFilesForFolder:(CKIFolder *)folder success:(void(^)(CKIPagedResponse *pagedResponse))success failure:(void(^)(NSError *error))failure;

@end
