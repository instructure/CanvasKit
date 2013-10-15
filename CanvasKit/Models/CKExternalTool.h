//
//  CKExternalTools.h
//  CanvasKit
//
//  Created by nlambson on 10/7/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import "CKModel.h"

@interface CKExternalTool : CKModel

/**
 The consumer key used by the tool
 */
@property (nonatomic, copy) NSString *consumerKey;

/**
 The date timestamp it was created
 */
@property (nonatomic, strong) NSDate *createdAt;

/**
 A description of the tool
 */
@property (nonatomic, copy) NSString *description;

/**
 The domain to match links against
 */
@property (nonatomic, copy) NSURL *domain;

/**
  The name of the tool
 */
@property (nonatomic) NSString *name;

/**
  Timestamp of last update
 */
@property (nonatomic, strong) NSDate *updatedAt;

/**
 The url to match links against
 */
@property (nonatomic, strong) NSURL *url;

/**
 What information to send to the external tool, "anonymous", "name_only", "public"
 */
@property (nonatomic) NSString *privacyLevel;

/**
 Custom fields that will be sent to the tool consumer
 */
@property (nonatomic) NSDictionary *customFields;

/**
  Appears to return similar values as privacyLevel "anonymous", "name_only", "public"
 */
@property (nonatomic) NSString *workflowState;

/**
 A url probably for help from the vendor of the tool
 */
@property (nonatomic, strong) NSURL *vendorHelpLink;

/**
 The url of the icon to show for this tool
 */
@property (nonatomic, strong) NSURL *iconURL;

@end
