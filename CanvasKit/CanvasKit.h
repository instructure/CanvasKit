//
//  CanvasKit.h
//  CanvasKit
//
//  Created by Jason Larsen on 8/22/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKIUser.h"
#import "CKILocalUser.h"
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

/**
 Set the current base URL for the canvas instance you want to work with. Ex: http://canvas.instructure.com
 
 @param currentDomain the domain/subdomains where you want to be hitting the APIs
 @warning if you don't call one of the prepareWithClientID methods first, you're gonna have a bad time.
 */
+ (void)setCurrentDomain:(NSURL *)currentDomain;

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
#import "CKILocalUser.h"
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

#import "CKIAssignment+Networking.h"
#import "CKICalendarEvent+Networking.h"
#import "CKIClient+Keychain.h"
#import "CKIClient.h"
#import "CKICourse+Networking.h"
#import "CKIExternalTool+Networking.h"
#import "CKIFavorite+Networking.h"
#import "CKIFile+Networking.h"
#import "CKIFolder+Networking.h"
#import "CKIGroup+Networking.h"
#import "CKILocalUser+Networking.h"
#import "CKIModel+Networking.h"
#import "CKIModule+Networking.h"
#import "CKIModuleItem+Networking.h"
#import "CKIPage+Networking.h"
#import "CKIPagedResponse.h"
#import "CKIQuiz+Networking.h"
#import "CKIService+Networking.h"
#import "CKISubmission+Networking.h"
#import "CKITab+Networking.h"
#import "CKITodoItem+Networking.h"
#import "CKIUser+Networking.h"

