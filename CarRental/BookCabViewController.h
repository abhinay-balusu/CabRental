//
//  BookCabViewController.h
//  CarRental
//
//  Created by tanla on 02/12/13.
//  Copyright (c) 2013 tanla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface BookCabViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *fromTextField;

@property (strong, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (strong, nonatomic) IBOutlet UIButton *selectDateButton;
- (IBAction)selectDateButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *toTextField;
@property (strong, nonatomic) IBOutlet UITextField *noOfPassengersTextField;
@property (strong, nonatomic) IBOutlet UIButton *selectCarButton;
- (IBAction)selectCarButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *reviewButton;
- (IBAction)reviewButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIDatePicker *dateTimePicker;
@property (strong, nonatomic) IBOutlet UILabel *carLabel;
@property(nonatomic,strong) NSString *carTitle;
@property (strong, nonatomic) IBOutlet UIButton *homeAddressButton;
- (IBAction)homeAddressButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *officeAddressButton;
- (IBAction)officeAddressButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *favouritesButton;
- (IBAction)favouritesButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIPickerView *personPickerView;
@property(nonatomic,strong) NSString *fromCity;
@property(nonatomic,strong) NSString *toCity;
@property(nonatomic,strong) NSString *passengerCount;
@property(nonatomic,strong) NSString *carService;
@property(nonatomic,strong) NSString *locationFromMap;
@property(nonatomic,strong) NSString *areaFromMap;
@property(nonatomic,strong) NSString *descriptionFromMap;
@property (strong, nonatomic) IBOutlet UILabel *fromCityLabel;
@property (strong, nonatomic) IBOutlet UILabel *fromAreaLabel;
@property (strong, nonatomic) IBOutlet UILabel *fromDescriptionLabel;
@property (strong, nonatomic) IBOutlet UIView *fromLocationView;
@property (strong, nonatomic) IBOutlet UITextField *fromLocationView_Location;
@property (strong, nonatomic) IBOutlet UITextField *fromLocationView_Area;
@property (strong, nonatomic) IBOutlet UITextField *fromLocationView_Description;
@property (strong, nonatomic) IBOutlet UITextView *fromLocationView_DescriptionTextView;
- (IBAction)fromLocationView_DoneButtonClicked:(id)sender;
- (IBAction)showFromLocationView:(id)sender;
- (IBAction)closeView:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *viewForPicker;
- (IBAction)hideViewForPicker:(id)sender;
- (IBAction)hideDatePicker:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *viewForDatePicker;
@property(nonatomic,strong)NSString *boolString;
@end
