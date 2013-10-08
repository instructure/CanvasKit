//
//  CKViewController.h
//  CanvasKit 2.0 Example
//
//  Created by rroberts on 9/12/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CanvasKit.h>

@interface CKViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIButton *loginButton;

- (IBAction)loginButtonPressed:(id)sender;

@end
