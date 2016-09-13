//
//  BookingStatusViewController.h
//  CarRental
//
//  Created by tanla on 02/12/13.
//  Copyright (c) 2013 tanla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookingStatusViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *bookAnotherRideButton;
- (IBAction)bookAnotherRideButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *referenceIdLabel;

@end
