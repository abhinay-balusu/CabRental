//
//  RegistrationViewController.h
//  CarRental
//
//  Created by tanla on 02/12/13.
//  Copyright (c) 2013 tanla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "HomeViewController.h"

@interface RegistrationViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *note;
@property (strong, nonatomic) IBOutlet UILabel *redMark;
@property (strong, nonatomic) IBOutlet UILabel *redMark2;
@property (strong, nonatomic) IBOutlet UILabel *redMark1;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *mobileNumberTextField;
@property (strong, nonatomic) IBOutlet UITextField *pwdTextField;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
- (IBAction)submitButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *homeAddressTextField;
@property (strong, nonatomic) IBOutlet UITextField *officeAddressTextField;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *mobileLabel;
@property (strong, nonatomic) IBOutlet UILabel *passwordLabel;
@property (strong, nonatomic) IBOutlet UILabel *homeAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *officeAddressLabel;

@end
