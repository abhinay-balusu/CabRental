//
//  LocationViewController.m
//  CarRental
//
//  Created by tanla on 04/12/13.
//  Copyright (c) 2013 tanla. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()
{
    CLLocationManager *locationManager;
    CLLocation *location;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    NSMutableString *addressStr;
    CLLocationCoordinate2D annotationCoord;
    MKPointAnnotation *annotationPoint;
    UITapGestureRecognizer *tapToShowView;
    NSString *locationString;
    NSString *stateString;
    NSString *countryString;
    NSMutableString *tempStr;
    BOOL isCurrentAddressLabelTapped;
    BOOL isfavButtonTapped;
    NSString *tempString1;
    NSString *tempString2;

}

@end

@implementation LocationViewController

@synthesize mapView,currentAddressLabel,okButton,tempBookCabVC,annotationImageView,detailsView,locationTextField,stateTextField,doneButton,tempLocationFromFav,descriptionTextView,favButton,homeLocationButton,officeLocationButton,segmentView;

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
        titleView.text =@"From?";
        [titleView sizeToFit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //mapView.showsUserLocation=YES;
    mapView.userInteractionEnabled=YES;
    mapView.delegate = self;
    
    self.navigationController.navigationBarHidden=NO;
    
    locationManager=[[CLLocationManager alloc]init];
    locationManager.delegate=self;
    [locationManager startUpdatingLocation];
    
    tapToShowView=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showView)];
    tapToShowView.numberOfTapsRequired=1;
    [currentAddressLabel addGestureRecognizer:tapToShowView];
    currentAddressLabel.userInteractionEnabled=YES;
    
    locationTextField.delegate=self;
    stateTextField.delegate=self;
    descriptionTextView.delegate=self;
    
    detailsView.hidden=YES;
    detailsView.layer.borderWidth=1.0f;
    detailsView.layer.borderColor=[UIColor colorWithRed:3.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0].CGColor;
    detailsView.layer.cornerRadius=8.0f;
    
    locationTextField.layer.borderWidth=1.0f;
    locationTextField.layer.borderColor=[UIColor colorWithRed:3.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0].CGColor;
    
    stateTextField.layer.borderWidth=1.0f;
    stateTextField.layer.borderColor=[UIColor colorWithRed:3.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0].CGColor;
    
    descriptionTextView.layer.borderWidth=1.0f;
    descriptionTextView.layer.borderColor=[UIColor colorWithRed:3.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0].CGColor;
    
    //MKCoordinateSpan span;
    //span.latitudeDelta = 0.01;
    //span.longitudeDelta = 0.01;
    MKCoordinateRegion region;
    //region.span = span;
    region = MKCoordinateRegionMakeWithDistance(locationManager.location.coordinate,4500,4500);
    //mapView.region = region;
    [mapView setRegion:region animated:YES];
    
    [mapView setCenterCoordinate:locationManager.location.coordinate];
    
    currentAddressLabel.numberOfLines=0;
    [self.view bringSubviewToFront:currentAddressLabel];
    [self.view bringSubviewToFront:okButton];
    
    NSLog(@"%@",NSStringFromCGRect(mapView.frame));
    
    //annotationImageView.center=mapView.center;
    //annotationImageView.frame=CGRectMake((320-42)/2, (381-34)/2+122, 42, 34);//139 172.5+122 42 34
    if(self.view.frame.size.height >= 568.0)
    {
        annotationImageView.frame = CGRectMake(annotationImageView.frame.origin.x, annotationImageView.frame.origin.y - annotationImageView.frame.size.height /2, annotationImageView.frame.size.width, annotationImageView.frame.size.height);
    }
    else
    {
        annotationImageView.frame = CGRectMake(annotationImageView.frame.origin.x, annotationImageView.frame.origin.y - annotationImageView.frame.size.height /2, annotationImageView.frame.size.width, annotationImageView.frame.size.height);

    }
    //NSLog(@"%@",NSStringFromCGRect(annotationImageView.frame));
    
    [self getCurrentAddress:locationManager.location];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)mapView:(MKMapView *)mapView1 regionDidChangeAnimated:(BOOL)animated
{
    //CGPoint mainPoint=mapView.center;
    
    
    CLLocationCoordinate2D mainMapCoordinate=[mapView centerCoordinate];;
    
    //NSLog(@"dropped at %f,%f", mainMapCoordinate.latitude, mainMapCoordinate.longitude);
    
    location=[[CLLocation alloc] initWithLatitude:mainMapCoordinate.latitude longitude:mainMapCoordinate.longitude];
    
    
    [self getCurrentAddress:location];
}

//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation: (MKUserLocation *)userLocation
//{
//    self.mapView.centerCoordinate = userLocation.location.coordinate;
//    
//}

//delegate method to get updated location
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//    
//}
//custom annotationview

//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id)annotation
//{
//    
//    static NSString *identifier = @"annotationView";
//    MKPinAnnotationView * annotationView = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
//    if (!annotationView)
//    {
//        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
//        annotationView.pinColor = MKPinAnnotationColorGreen;
//        annotationView.animatesDrop = NO;
//        //annotationView.canShowCallout = YES;
//        annotationView.draggable=YES;
//    }
//    
//    else
//    {
//        annotationView.annotation = annotation;
//    }
//    //annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    //UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,0,50,100)];
//    //view.backgroundColor = [UIColor clearColor];
//    //UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home.png"]];
//    //[view addSubview:imgView];
//    //annotationView.leftCalloutAccessoryView = view;
//    return annotationView;
//}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateEnding)
    {
//        CLLocationCoordinate2D droppedLocation = annotationView.annotation.coordinate;
//        NSLog(@"dropped at %f,%f", droppedLocation.latitude, droppedLocation.longitude);
        //NSString * droppedLocationStr=[NSString stringWithFormat:@"Latitude:%f \n Longitude:%f",droppedLocation.latitude, droppedLocation.longitude];
//        UIAlertView * view6 =[[UIAlertView alloc]init];
//        [view6 setTitle:@"Location"];
//        [view6 setMessage:droppedLocationStr ];
//        [view6 addButtonWithTitle:@"ok"];
//        [view6 show];
        
//        location=[[CLLocation alloc] initWithLatitude:droppedLocation.latitude longitude:droppedLocation.longitude];
//        annotationPoint.coordinate=location.coordinate;
//        
//        [self getCurrentAddress:location];
        
    }
}

-(void)getCurrentAddress:(CLLocation *)newlocation
{
    geocoder=[[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:newlocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if(error==nil && [placemarks count]>0) {
             placemark = [placemarks objectAtIndex:0];
             
             addressStr=[NSMutableString stringWithFormat:@"%@,%@",placemark.administrativeArea,placemark.country];
            
             stateString=placemark.administrativeArea;
             countryString=placemark.country;
             
             //NSLog(@"%@",addressStr);
             
             [self getLocation:addressStr];
         }
         else
         {
             NSLog(@"%@",error.description);
             
         }
         
     }];
}

-(void)getLocation:(NSString *)adrStr
{
    [geocoder geocodeAddressString:adrStr completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if(!error)
         {
             
             NSString * LocationStr=[NSString stringWithFormat:@"%@",[placemark description]];
             //NSLog(@"%@",LocationStr);
             
             tempStr = [NSMutableString stringWithCapacity:[LocationStr length]];
             
             NSScanner *scanner = [NSScanner scannerWithString:LocationStr];
             scanner.charactersToBeSkipped = NULL;
             NSString *tempText = nil;

            [scanner scanUpToString:@"," intoString:&tempText];
                 
             if (tempText != nil)
                [tempStr appendString:tempText];
                 tempText = nil;
          
             if(stateString!=nil)
             {
                 currentAddressLabel.text=[NSString stringWithFormat:@"%@,%@,%@",tempStr,stateString,countryString];
             }
             else
             {
                 currentAddressLabel.text=tempStr;
             }
         }
         else
         {
             NSLog(@"There was a forward geocoding error\n%@",[error localizedDescription]);
         }
     }
     ];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    if(isfavButtonTapped)
    {
        locationTextField.text=tempLocationFromFav;
        isfavButtonTapped=NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)okButtonClicked:(id)sender
{
    tempBookCabVC=[[BookCabViewController alloc]init];
    tempBookCabVC.locationFromMap=tempStr;
    tempBookCabVC.areaFromMap=addressStr;
    tempBookCabVC.descriptionFromMap=descriptionTextView.text;
    [self.navigationController pushViewController:tempBookCabVC animated:YES];
}

-(void)showView
{
    [UIView beginAnimations:@"show" context:nil];
    [UIView setAnimationDuration:1.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:detailsView cache:YES];
    detailsView.hidden=NO;
    isCurrentAddressLabelTapped=YES;
    locationTextField.text=tempStr;
    stateTextField.text=addressStr;
    //descriptionTextView.text=[NSString stringWithFormat:@"%@,%@,%@",tempStr,stateString,countryString];
    [UIView commitAnimations];
}

- (IBAction)doneButtonClicked:(id)sender
{
    currentAddressLabel.text=[NSString stringWithFormat:@"%@,%@,%@",locationTextField.text,stateTextField.text,descriptionTextView.text];
    [UIView beginAnimations:@"show" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:detailsView cache:YES];
    
    detailsView.hidden=YES;
    isCurrentAddressLabelTapped=NO;
    [UIView commitAnimations];
}

- (IBAction)homeLocationButtonClicked:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(![[defaults objectForKey:@"home"] isEqualToString:@""])
    {
        
        tempBookCabVC=[[BookCabViewController alloc]init];
        tempBookCabVC.locationFromMap=[defaults objectForKey:@"home"];;
        tempBookCabVC.areaFromMap=[defaults objectForKey:@"home1"];

        [self.navigationController pushViewController:tempBookCabVC animated:YES];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"No HOME ADDRESS in your profile" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)officeLocationButtonClicked:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(![[defaults objectForKey:@"office"] isEqualToString:@""])
    {
        tempBookCabVC=[[BookCabViewController alloc]init];
        tempBookCabVC.locationFromMap=[defaults objectForKey:@"office"];
        tempBookCabVC.areaFromMap=[defaults objectForKey:@"office1"];
        [self.navigationController pushViewController:tempBookCabVC animated:YES];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"No OFFICE ADDRESS in your profile" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)favButtonClicked:(id)sender
{
    FavouritesViewController *favVC1;
    if(!favVC1)
    {
        favVC1=[[FavouritesViewController alloc]init];
    }
    favVC1.lVC=self;
    [self.navigationController pushViewController:favVC1 animated:YES];
}

- (IBAction)closeLocationView:(id)sender
{
    [UIView beginAnimations:@"show" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:detailsView cache:YES];
    detailsView.hidden=YES;
    [UIView commitAnimations];
}

/*-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    descriptionTextView.text=[NSString stringWithFormat:@"%@,%@",locationTextField.text,stateTextField.text];
    return YES;
}*/

/*- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * s;
    if(textField == locationTextField)
    {
        s = [textField.text stringByAppendingString:string];
        descriptionTextView.text=[NSString stringWithFormat:@"%@,%@",s,stateTextField.text];
    }
    else if(textField == stateTextField)
    {
        s = [textField.text stringByAppendingString:string];
        descriptionTextView.text=[NSString stringWithFormat:@"%@,%@",locationTextField.text,s];
    }
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
