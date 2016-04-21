//
//  SettingAddressViewController.m
//  CarRental
//
//  Created by tanla on 05/12/13.
//  Copyright (c) 2013 tanla. All rights reserved.
//

#import "SettingAddressViewController.h"

@interface SettingAddressViewController ()

@end

@implementation SettingAddressViewController

@synthesize homeAreaTF,homeCityTF,officeAreaTF,officeCityTF;

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
        titleView.text =@"Settings";
        [titleView sizeToFit];
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    homeAreaTF.delegate=self;
    homeCityTF.delegate=self;
    officeCityTF.delegate=self;
    officeAreaTF.delegate=self;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)storeDataInDefaults:(id)sender
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if(![homeCityTF.text isEqual:@""] )
    {
        [defaults setObject:homeCityTF.text forKey:@"home"];
    }
    if(![homeAreaTF.text isEqual:@""] )
    {
        [defaults setObject:homeAreaTF.text forKey:@"home1"];
    }
    if(![officeCityTF.text isEqual:@""] )
    {
        [defaults setObject:officeCityTF.text forKey:@"office"];
    }
    if(![officeAreaTF.text isEqual:@""] )
    {
        [defaults setObject:officeAreaTF.text forKey:@"office1"];
    }
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Details Added Successfully" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
}
-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *defaults1=[NSUserDefaults standardUserDefaults];
    homeCityTF.text=[defaults1 objectForKey:@"home"];
    homeAreaTF.text=[defaults1 objectForKey:@"home1"];
    officeCityTF.text=[defaults1 objectForKey:@"office"];
    officeAreaTF.text=[defaults1 objectForKey:@"office1"];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
