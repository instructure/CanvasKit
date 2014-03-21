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
@class RACSignal;

@interface CKIClient (CKIFolder)

/**
 Fetch a folder with a specific ID.
 
 @param folderID the ID of the folder to fetch
 */
- (RACSignal *)fetchFolder:(NSString *)folderID;

/**
 Every course has a root folder which contains all the files
 and folders for the course. This method fetches that folder,
 which can in turn in be used to fetch the entire file tree.
 
 @param course the course to fetch the root folder for
 */
- (RACSignal *)fetchRootFolderForCourse:(CKICourse *)course;

/**
 Fetch the folders inside the given folder.
 
 @param folder the folder to fetch folders from
 */
- (RACSignal *)fetchFoldersForFolder:(CKIFolder *)folder;

/**
 Fetch the files in the given folder.
 
 @param folder the folder to fetch files from
 */
- (RACSignal *)fetchFilesForFolder:(CKIFolder *)folder;


- (RACSignal *)fetchFolder:(NSString *)folderID withContext:(id<CKIContext>)context;

- (RACSignal *)fetchRootFolderForContext:(id <CKIContext>)context;

@end
