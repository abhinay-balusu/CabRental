//
//  HomeViewController.m
//  CarRental
//
//  Created by tanla on 02/12/13.
//  Copyright (c) 2013 tanla. All rights reserved.
//

#import "HomeViewController.h"
#import "RegistrationViewController.h"

@interface HomeViewController ()
{
    UITapGestureRecognizer *tapGesture;
}

@end

@implementation HomeViewController

@synthesize mobileTextField,passwordTextField;

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
        titleView.text =@"Welcome";
        [titleView sizeToFit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mobileTextField.delegate=self;
    passwordTextField.delegate=self;
    
    mobileTextField.layer.borderColor=[UIColor colorWithRed:3.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0].CGColor;
    mobileTextField.layer.borderWidth=1.0f;
    
    passwordTextField.layer.borderColor=[UIColor colorWithRed:3.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0].CGColor;
    passwordTextField.layer.borderWidth=1.0f;
    
    passwordTextField.secureTextEntry=YES;
    
    tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard:)];
    tapGesture.numberOfTapsRequired=1;    
}

-(void)dismissKeyboard:(UITapGestureRecognizer *)recognizer
{
    [mobileTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:3.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0];
    self.navigationItem.title=@"Welcome";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if(textField.tag == 120)
    {
        [self loginButtonClicked:nil];
    }
    return YES;
}

- (IBAction)loginButtonClicked:(id)sender
{
    if([mobileTextField.text isEqual:@""] || [passwordTextField.text isEqual:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please Enter all the Details" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if([mobileTextField.text isEqual:[defaults objectForKey:@"mobile"]] && [passwordTextField.text isEqual:[defaults objectForKey:@"password"]])
        {
            DetailsViewController *detailsVC;
            if(!detailsVC)
            {
                detailsVC=[[DetailsViewController alloc]init];
            }
            [self.navigationController pushViewController:detailsVC animated:YES];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please Enter the Correct Details" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

- (IBAction)registerButtonClicked:(id)sender
{
    RegistrationViewController *registrationVC;
    if(!registrationVC)
    {
        registrationVC=[[RegistrationViewController alloc]init];
    }
    [self.navigationController pushViewController:registrationVC animated:YES];
}
@end
