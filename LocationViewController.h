//
//  LocationViewController.h
//  CarRental
//
//  Created by tanla on 04/12/13.
//  Copyright (c) 2013 tanla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
#import "BookCabViewController.h"
#import "FavouritesViewController.h"


@interface LocationViewController : UIViewController<MKMapViewDelegate,MKAnnotation,MKOverlay,CLLocationManagerDelegate,UITextFieldDelegate,UITextViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *currentAddressLabel;
@property (strong, nonatomic) IBOutlet UIButton *okButton;
- (IBAction)okButtonClicked:(id)sender;
@property(nonatomic,strong)BookCabViewController *tempBookCabVC;
@property (strong, nonatomic) IBOutlet UIImageView *annotationImageView;
@property (strong, nonatomic) IBOutlet UIView *detailsView;
@property (strong, nonatomic) IBOutlet UITextField *locationTextField;
@property (strong, nonatomic) IBOutlet UITextField *stateTextField;
@property (strong, nonatomic) IBOutlet UIButton *doneButton;
- (IBAction)doneButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *segmentView;
@property (strong, nonatomic) IBOutlet UIButton *homeLocationButton;
- (IBAction)homeLocationButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *officeLocationButton;
- (IBAction)officeLocationButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *favButton;
- (IBAction)favButtonClicked:(id)sender;
- (IBAction)closeLocationView:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;
@property(nonatomic,strong)NSString *tempLocationFromFav;
@end
