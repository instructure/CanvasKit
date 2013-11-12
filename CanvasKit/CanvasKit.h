//
//  CanvasKit.h
//  CanvasKit
//
//  Created by Jason Larsen on 8/22/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKIUser.h"
#import "Constants.h"

@interface CanvasKit : NSObject

/**
 Prepares the shared client for OAuth2 authentication. Preparing the CKIClient for authentication with this method will not prompt the user for a domain.
 
 @param OAuth2 client id
 @param OAuth2 shared secret
 
 @warning If the domain is invalidated the login process will fail.
 */
+ (void)prepareWithClientID:(NSString *)aClientId sharedSecret:(NSString *)aSharedSecret;

/**
 Prepares the shared client for OAuth2 authentication. Use this preparation method if you would like to store the authentication token in your keychain.
 
 @param OAuth2 client id
 @param OAuth2 shared secret
 @param application keychain ID
 */
+ (void)prepareWithClientID:(NSString *)aClientId sharedSecret:(NSString *)aSharedSecret keyChainId:(NSString *)aKeyChainId;


@end

#pragma mark - models

#import "CKIAssignment.h"
#import "CKIAssignmentGroup.h"
#import "CKICalendarEvent.h"
#import "CKIContext.h"
#import "CKICourse.h"
#import "CKIExternalTool.h"
#import "CKIFavorite.h"
#import "CKIFile.h"
#import "CKIFolder.h"
#import "CKIGroup.h"
#import "CKILockInfo.h"
#import "CKILockableModel.h"
#import "CKIModel.h"
#import "CKIModule.h"
#import "CKIModuleItem.h"
#import "CKIPage.h"
#import "CKIQuiz.h"
#import "CKIRubricCriterion.h"
#import "CKIRubricCriterionRating.h"
#import "CKIService.h"
#import "CKISubmission.h"
#import "CKISubmissionComment.h"
#import "CKITab.h"
#import "CKITodoItem.h"
#import "CKIUser.h"


#pragma mark - networking

#import "CKIPagedResponse.h"

#import "CKIClient.h"
#import "CKIClient+CKIAssignment.h"
#import "CKIClient+CKICalendarEvent.h"
#import "CKIClient+CKICourse.h"
#import "CKIClient+CKIExternalTool.h"
#import "CKIClient+CKIFavorite.h"
#import "CKIClient+CKIFile.h"
#import "CKIClient+CKIFolder.h"
#import "CKIClient+CKIGroup.h"
#import "CKIClient+CKIModule.h"
#import "CKIClient+CKIModel.h"
#import "CKIClient+CKIModule.h"
#import "CKIClient+CKIModuleItem.h"
#import "CKIClient+CKIPage.h"
#import "CKIClient+CKIQuiz.h"
#import "CKIClient+CKIService.h"
#import "CKIClient+CKISubmission.h"
#import "CKIClient+CKITab.h"
#import "CKIClient+CKITodoItem.h"
#import "CKIClient+CKIUser.h"
