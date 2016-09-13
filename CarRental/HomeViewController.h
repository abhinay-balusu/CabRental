//
//  HomeViewController.h
//  CarRental
//
//  Created by tanla on 02/12/13.
//  Copyright (c) 2013 tanla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "DetailsViewController.h"


@interface HomeViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *mobileTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)loginButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;
- (IBAction)registerButtonClicked:(id)sender;

@end
