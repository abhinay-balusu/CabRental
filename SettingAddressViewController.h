//
//  SettingAddressViewController.h
//  CarRental
//
//  Created by tanla on 05/12/13.
//  Copyright (c) 2013 tanla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingAddressViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *homeCityTF;
@property (strong, nonatomic) IBOutlet UITextField *homeAreaTF;
@property (strong, nonatomic) IBOutlet UITextField *officeCityTF;
@property (strong, nonatomic) IBOutlet UITextField *officeAreaTF;
- (IBAction)storeDataInDefaults:(id)sender;

@end
