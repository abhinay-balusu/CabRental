//
//  BookCabViewController.m
//  CarRental
//
//  Created by tanla on 02/12/13.
//  Copyright (c) 2013 tanla. All rights reserved.
//

#import "BookCabViewController.h"
#import "CarsViewController.h"
#import "ReviewViewController.h"
#import "HomeViewController.h"
#import "FavouritesViewController.h"
#import "LocationViewController.h"


@interface BookCabViewController ()
{
    int pickerShowHide;
    int year, month, day, hour, minute, second;
    NSUserDefaults *defaults;
    NSString *dateTimeString;
    NSMutableString * addressStr;
    UITapGestureRecognizer *tapRecognizer;
    UITableView *cityList;
    NSMutableArray *cityArray;
    NSArray *tempCityArray;
    UITextField *textFieldSelected;
    BOOL isCarSelected;
    BOOL isFavButtonSelected;
    int pickerViewShowHide;
    NSArray *personsArray;
    BOOL isMapButtonClicked;
    NSString * string1;
}

@end

@implementation BookCabViewController

@synthesize fromTextField,toTextField,dateTimeLabel,noOfPassengersTextField,dateTimePicker,selectDateButton,carTitle,carLabel,dateLabel,timeLabel,fromCity,toCity,passengerCount,carService,locationFromMap,personPickerView,fromLocationView,fromLocationView_Area,fromLocationView_Description,fromLocationView_Location,fromAreaLabel,fromCityLabel,fromDescriptionLabel,areaFromMap,descriptionFromMap,reviewButton,viewForPicker,fromLocationView_DescriptionTextView,boolString,viewForDatePicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UILabel *titleView = (UILabel *)self.navigationItem.titleView;
        if (!titleView)
        {
            titleView = [[UILabel alloc] initWithFrame:CGRectZero];
            titleView.backgroundColor = [UIColor clearColor];
            titleView.font = [UIFont boldSystemFontOfSize:20.0];
            titleView.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
            
            titleView.textColor = [UIColor whiteColor]; // Change to desired color
            
            self.navigationItem.titleView = titleView;
        }
        titleView.text =@"Book Cab";
        [titleView sizeToFit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    fromTextField.delegate=self;
    toTextField.delegate=self;
    fromTextField.layer.borderColor=[UIColor colorWithRed:3.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0].CGColor;
    toTextField.layer.borderColor=[UIColor colorWithRed:3.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0].CGColor;
    fromTextField.layer.borderWidth=1.0f;
    toTextField.layer.borderWidth=1.0f;
    
    noOfPassengersTextField.layer.borderColor=[UIColor colorWithRed:3.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0].CGColor;
    noOfPassengersTextField.layer.borderWidth=1.0f;
    
    noOfPassengersTextField.delegate=self;
    noOfPassengersTextField.keyboardType=UIKeyboardTypeNumberPad;
    
    viewForDatePicker.hidden=YES;
    
    pickerShowHide=0;
    
    dateTimePicker.backgroundColor=[UIColor whiteColor];
    dateTimePicker.layer.borderColor=[UIColor colorWithRed:3.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0].CGColor;
    dateTimePicker.layer.borderWidth=2.0f;
    dateTimePicker.layer.cornerRadius=12;
    [dateTimePicker addTarget:self action:@selector(selectDate) forControlEvents:UIControlEventValueChanged];
    NSDate *pickerDate=[NSDate date];
    NSDate *minimumDate=[pickerDate dateByAddingTimeInterval:60*60];
    dateTimePicker.minimumDate=minimumDate;
    
    [self.view bringSubviewToFront:dateTimePicker];
    
    //calender
    NSCalendar *calendar= [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDate *todayDate = [NSDate date];
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:todayDate];

    year = [dateComponents year];
    month = [dateComponents month];
    day = [dateComponents day];
    hour = [dateComponents hour];
    minute = [dateComponents minute];
    second = [dateComponents second];
    
    NSDate *date1=[dateTimePicker date];
    NSDateFormatter *dateFormatter2 =[[NSDateFormatter alloc] init];
    dateFormatter2.timeStyle=NSDateFormatterLongStyle;
    dateFormatter2.dateStyle=NSDateFormatterLongStyle;
    [dateFormatter2 setDateFormat:@"dd MMM yy"];
    NSLog(@"%@",[dateFormatter2 stringFromDate:date1]);
    
    dateLabel.text=[dateFormatter2 stringFromDate:date1];
    
    NSDateFormatter *dateFormatter3 =[[NSDateFormatter alloc] init];
    dateFormatter3.timeStyle=NSDateFormatterLongStyle;
    dateFormatter3.dateStyle=NSDateFormatterLongStyle;
    [dateFormatter3 setDateFormat:@"HH:mm:ss"];
    
    NSLog(@"%@",[dateFormatter3 stringFromDate:date1]);
    
    NSString * ampm1;
    if(hour<11)
    {
        ampm1=@"AM";
        
    }
    else
    {
        ampm1=@"PM";
    }
    NSString *tempStr=[NSString stringWithFormat:@"%d:%d:%d %@",hour+01,minute,second,ampm1];

    timeLabel.text=tempStr;
    
    tapRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    tapRecognizer.numberOfTapsRequired=2;
    [self.view addGestureRecognizer:tapRecognizer];
    
    //cityList=[[UITableView alloc]initWithFrame:CGRectMake(100, 150, 185, 200) style:UITableViewStylePlain];
    [self.view addSubview:cityList];
    //cityList.hidden=YES;
    //cityList.delegate=self;
    //cityList.dataSource=self;
    
    //tempCityArray=[NSArray arrayWithObjects:@"Hyderabad",@"Mumbai",@"Chennai",@"Delhi",@"Vizag", @"Chittor", @"Kadapa", @"Bengaluru", @"Vijayawada", @"Kurnool", @"Kolkata", nil];
    //cityArray=[[NSMutableArray alloc]initWithArray:tempCityArray copyItems:YES];
    
    personPickerView.dataSource=self;
    personPickerView.delegate=self;
    personPickerView.backgroundColor=[UIColor whiteColor];
    personPickerView.hidden=NO;
    personPickerView.layer.cornerRadius=12;
    personPickerView.layer.borderColor=[UIColor colorWithRed:3.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0].CGColor;
    personPickerView.layer.borderWidth=2.0f;
    personPickerView.showsSelectionIndicator=YES;
  
    pickerViewShowHide=0;
    
    personsArray=[[NSArray alloc]initWithObjects:@"Select",@"1",@"2",@"3",@"4",@"5", nil];
    
    //string1 = @"";
    
    fromLocationView.hidden=YES;
    fromLocationView_Area.delegate=self;
    fromLocationView_Description.delegate=self;
    fromLocationView_Location.delegate=self;
    fromLocationView.layer.borderWidth=1.0f;
    fromLocationView.layer.borderColor=[UIColor colorWithRed:3.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0].CGColor;
    fromLocationView.layer.cornerRadius=8.0f;
    
    fromLocationView_Location.layer.borderWidth=1.0f;
    fromLocationView_Location.layer.borderColor=[UIColor colorWithRed:3.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0].CGColor;
    
    fromLocationView_Area.layer.borderWidth=1.0f;
    fromLocationView_Area.layer.borderColor=[UIColor colorWithRed:3.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0].CGColor;
    
    fromLocationView_Description.layer.borderWidth=1.0f;
    fromLocationView_Description.layer.borderColor=[UIColor colorWithRed:3.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0].CGColor;
    
    fromCityLabel.text=locationFromMap;
    fromAreaLabel.text=areaFromMap;
    fromDescriptionLabel.text=descriptionFromMap;

    viewForPicker.hidden=YES;
    
    fromLocationView_DescriptionTextView.layer.borderWidth=1.0f;
    fromLocationView_DescriptionTextView.layer.borderColor=[UIColor colorWithRed:3.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0].CGColor;
    
    fromLocationView_DescriptionTextView.delegate=self;
    
    carLabel.numberOfLines=0;
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [cityArray count];
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSString *identifier = @"cellIdentifier";
//    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
//    if(cell==nil)//reusing cell
//    {
//        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
//    }
//    
//    
//    cell.textLabel.text=[cityArray objectAtIndex:indexPath.row];
//    
//    
//    cell.textLabel.textColor=[UIColor colorWithRed:76.0/255.0 green:126.0/255.0 blue:159.0/255.0 alpha:1.0];
//    UIView *selectionColor = [[UIView alloc] init];
//    selectionColor.backgroundColor = [UIColor colorWithRed:(224.0/255.0) green:(74.0/255.0) blue:(101.0/255.0) alpha:1.0];
//    cell.selectedBackgroundView = selectionColor;
//    cell.textLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:18];
//    cell.textLabel.textAlignment=NSTextAlignmentRight;
//    return cell;
//
//}

-(void)dismissKeyboard
{
    [fromTextField resignFirstResponder];
    [toTextField resignFirstResponder];
    [noOfPassengersTextField resignFirstResponder];
//    if(!cityList.isHidden)
//    {
//        cityList.hidden = 1;
//    }
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField == noOfPassengersTextField)
    {
        viewForPicker.hidden=NO;
        return NO;
    }
    //else
    //{
//        string1 = textField.text;
//        cityArray = nil;
//        cityArray = [[NSMutableArray alloc] initWithArray:tempCityArray copyItems:YES];
//        [cityList reloadData];
//        cityList.frame = CGRectMake(textField.frame.origin.x - 5, textField.frame.origin.y + textField.frame.size.height + 2, textField.frame.size.width+10, 150);
//        cityList.hidden=NO;
//        textFieldSelected = textField;
    //}
    return YES;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
    //[cityArray removeAllObjects];
    
//    NSPredicate * pred = [NSPredicate predicateWithFormat:@"%@", textField.text];
    
//    NSString *firstLetter = @"";
//    if(range.length == 0)
//    {
//        string1 = [string1 stringByAppendingString:string];
//    }
//    else
//    {
//        string1 = [string1 substringToIndex:range.location];
//    }
//    NSInteger strlen=[string1 length];
//    for (NSString *ABCValue in tempCityArray)
//    {
//        if(ABCValue.length >= strlen)
//        {
//            firstLetter = [ABCValue substringToIndex:strlen];
//        }
//        if([string1.uppercaseString isEqualToString:firstLetter.uppercaseString])
//        {
//            NSString * s = [ABCValue copy];
//            [cityArray addObject:s]; //Store it in NSMutableArray
//        }
//    }
//    if([cityArray count] < 4)
//    {
//        cityList.frame = CGRectMake(cityList.frame.origin.x, cityList.frame.origin.y, cityList.frame.size.width+10, cityArray.count * 44);
//    }
//    
//    [cityList reloadData];
//    
    //return YES;
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    fromLocationView_Location.text=[fromLocationView_Location.text stringByAppendingString:@" "];
    fromLocationView_Area.text=[fromLocationView_Area.text stringByAppendingString:@" "];
    [textField resignFirstResponder];
    //if(textField==noOfPassengersTextField)
    //{
    //cityList.hidden = YES;
    //}
    //else
    //{
        //cityList.hidden=NO;
    //}
    return YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [personsArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [personsArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    noOfPassengersTextField.text=[personsArray objectAtIndex:row];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    textFieldSelected.text = [cityArray objectAtIndex:indexPath.row];
//    cityList.hidden=YES;
//}

-(void)viewWillAppear:(BOOL)animated
{
    if(isCarSelected)
    {
        if(carTitle!=nil)
        {
        carLabel.text=carTitle;
        }
        isCarSelected=NO;
    }
    
    if(isFavButtonSelected)
    {
        fromCityLabel.text=fromCity;
        toTextField.text=toCity;
        noOfPassengersTextField.text=passengerCount;
        carLabel.text=carService;
        isFavButtonSelected=NO;
    }
    
    if([boolString isEqualToString:@"yes"])
    {
        fromCityLabel.text=fromCity;
        toTextField.text=toCity;
        noOfPassengersTextField.text=passengerCount;
        carLabel.text=carService;
        isFavButtonSelected=NO;
    }
    
    viewForPicker.hidden=YES;
    
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    if(self.view.frame.size.height>=568)
    {
        
    }
    else
    {
        reviewButton.frame=CGRectMake(reviewButton.frame.origin.x, reviewButton.frame.origin.y, reviewButton.frame.size.width, 27);
    
    }
}

-(void)selectDate
{
    NSDate *date=[dateTimePicker date];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    dateFormatter.timeStyle=NSDateFormatterLongStyle;
    dateFormatter.dateStyle=NSDateFormatterLongStyle;
    [dateFormatter setDateFormat:@"dd MMM yy"];
    
    dateLabel.text=[dateFormatter stringFromDate:date];
    
    NSDateFormatter *dateFormatter1 =[[NSDateFormatter alloc] init];
    dateFormatter1.timeStyle=NSDateFormatterLongStyle;
    dateFormatter1.dateStyle=NSDateFormatterLongStyle;
    [dateFormatter1 setDateFormat:@"HH:mm:ss a"];
    
    timeLabel.text=[dateFormatter1 stringFromDate:date];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectCarButtonClicked:(id)sender
{
    isCarSelected=YES;
    CarsViewController *carsVC;
    
    if(!carsVC)
    {
        carsVC=[[CarsViewController alloc]init];
    }
    carsVC.VC=self;
    
    [self.navigationController pushViewController:carsVC animated:YES];
}

- (IBAction)reviewButtonClicked:(id)sender
{
    if([fromCityLabel.text isEqual:@""] || [toTextField.text isEqual:@""] || [dateTimeLabel.text isEqual:@""] || [noOfPassengersTextField.text isEqual:@""] || [carLabel.text isEqual:@""] || [noOfPassengersTextField.text isEqual:@"Select"])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please Enter all the Details" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setObject:fromTextField.text forKey:@"fromAddress"];
//        [defaults setObject:toTextField.text forKey:@"toAddress"];
//        [defaults setObject:noOfPassengersTextField.text forKey:@"noofpassengers"];
//        [defaults setObject:dateTimeLabel.text forKey:@"date"];
//        [defaults setObject:carLabel.text forKey:@"car"];
        
        dateTimeString=[NSString stringWithFormat:@"%@ %@",dateLabel.text,timeLabel.text];
        
        NSMutableArray *arrayOfData=[[NSMutableArray alloc]initWithObjects:fromCityLabel.text,toTextField.text,noOfPassengersTextField.text,dateTimeString,carLabel.text, nil];
        
        NSLog(@"%@",fromCityLabel.text);
        
        //NSMutableArray *tempArray=[[NSMutableArray alloc]init];
        
        //[tempArray addObject:arrayOfData];
        
        //[tempArray setObject:[defaults valueForKey:@"mainArray"] atIndexedSubscript:0];
        //[tempArray setObject:arrayOfData atIndexedSubscript:0];
        //[tempArray addObject:arrayOfData];
        //[defaults setObject:tempArray forKey:@"mainArray"];
        //[defaults setValue:[tempArray objectAtIndex:1] forKey:@"mainArray"];
        //NSLog(@"%@",[defaults objectForKey:@"mainArray"]);
        
      //  NSLog(@"%@",[defaults objectForKey:@"mainArray"]);
//        NSLog(@"%@",[defaults objectForKey:@"fromAddress"]);
//        NSLog(@"%@",[defaults objectForKey:@"toAddress"]);
//        NSLog(@"%@",[defaults objectForKey:@"noofpassengers"]);
//        NSLog(@"%@",[defaults objectForKey:@"date"]);
//        NSLog(@"%@",[defaults objectForKey:@"car"]);
        [defaults synchronize];
        
        ReviewViewController *reviewVC;
        if(!reviewVC)
        {
            reviewVC=[[ReviewViewController alloc]init];
        }
        reviewVC.detailsArray=arrayOfData;
        [self.navigationController pushViewController:reviewVC animated:YES];
    }
}

- (IBAction)selectDateButtonClicked:(id)sender
{
    viewForDatePicker.hidden=NO;
}

- (IBAction)homeAddressButtonClicked:(id)sender
{
    defaults = [NSUserDefaults standardUserDefaults];
    if(![[defaults objectForKey:@"home"] isEqualToString:@""])
    {
        toTextField.text=[defaults objectForKey:@"home"];
        string1 = toTextField.text;
        NSLog(@"%@",[defaults objectForKey:@"home"]);
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"No HOME ADDRESS in your profile" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)officeAddressButtonClicked:(id)sender
{
    defaults = [NSUserDefaults standardUserDefaults];
    if(![[defaults objectForKey:@"office"] isEqualToString:@""])
    {
        toTextField.text=[defaults objectForKey:@"office"];
        string1 = toTextField.text;
        NSLog(@"%@",[defaults objectForKey:@"office"]);
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"No OFFICE ADDRESS in your profile" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }

}

- (IBAction)favouritesButtonClicked:(id)sender
{
    isFavButtonSelected=YES;
    FavouritesViewController *favVC;
    if(!favVC)
    {
        favVC=[[FavouritesViewController alloc]init];
    }
    favVC.bookVC=self;
    [self.navigationController pushViewController:favVC animated:YES];
}

- (IBAction)fromLocationView_DoneButtonClicked:(id)sender
{
    fromCityLabel.text=fromLocationView_Location.text;
    fromAreaLabel.text=fromLocationView_Area.text;
    fromDescriptionLabel.text=fromLocationView_DescriptionTextView.text;
    fromLocationView.hidden=YES;
    [fromLocationView_Area resignFirstResponder];
    [fromLocationView_Description resignFirstResponder];
    [fromLocationView_Location resignFirstResponder];
}

- (IBAction)showFromLocationView:(id)sender
{
    fromLocationView.hidden=NO;
    fromLocationView_Location.text=fromCityLabel.text;
    fromLocationView_Area.text=fromAreaLabel.text;
    fromLocationView_DescriptionTextView.text=fromDescriptionLabel.text;
}

- (IBAction)closeView:(id)sender
{
    fromLocationView.hidden=YES;
}

- (IBAction)hideViewForPicker:(id)sender
{
    viewForPicker.hidden=YES;
}

- (IBAction)hideDatePicker:(id)sender
{
    viewForDatePicker.hidden=YES;
}

/*- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    fromLocationView_DescriptionTextView.text=[NSString stringWithFormat:@"%@,%@",fromLocationView_Location.text,fromLocationView_Area.text];
    return YES;
}*/
// delegate method of text view
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    return YES;
}
@end
