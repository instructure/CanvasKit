//
//  CKUserDetailsViewController.h
//  CanvasKit 2.0 Example
//
//  Created by rroberts on 9/13/13.
//  Copyright (c) 2013 Instructure. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CanvasKit.h>
#import <UIImageView+AFNetworking.h>

@interface CKUserDetailsViewController : UIViewController

@property (nonatomic, strong) CKLocalUser *user;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

- (IBAction)logoutUser:(id)sender;
- (IBAction)viewTodoItems:(id)sender;

@end
