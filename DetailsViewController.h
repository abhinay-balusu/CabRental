//
//  DetailsViewController.h
//  CarRental
//
//  Created by tanla on 02/12/13.
//  Copyright (c) 2013 tanla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingAddressViewController.h"

@interface DetailsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *startBooking;
- (IBAction)startBookingButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *bookingHistory;
- (IBAction)bookingHistoryButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *favourites;
- (IBAction)favouritesButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *bookingThroughMap;
- (IBAction)bookingThroughMapButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *designImageView;
- (IBAction)setAddressButton:(id)sender;

@end
