//
//  RegistrationViewController.m
//  CarRental
//
//  Created by tanla on 02/12/13.
//  Copyright (c) 2013 tanla. All rights reserved.
//

#import "RegistrationViewController.h"

@interface RegistrationViewController ()
{
    UITapGestureRecognizer *tapGesture;
    UIScrollView *scrollView;
}

@end

@implementation RegistrationViewController

@synthesize nameTextField,mobileNumberTextField,pwdTextField,homeAddressTextField,officeAddressTextField,nameLabel,mobileLabel,passwordLabel,homeAddressLabel,officeAddressLabel,submitButton,redMark,redMark1,redMark2,note;

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
        titleView.text =@"Register";
        [titleView sizeToFit];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    nameTextField.delegate=self;
    mobileNumberTextField.delegate=self;
    pwdTextField.delegate=self;
    homeAddressTextField.delegate=self;
    officeAddressTextField.delegate=self;
    
    nameTextField.layer.borderColor=[UIColor colorWithRed:3.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0].CGColor;
    nameTextField.layer.borderWidth=1.0f;
    
    mobileNumberTextField.layer.borderColor=[UIColor colorWithRed:3.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0].CGColor;
    mobileNumberTextField.layer.borderWidth=1.0f;
    
    pwdTextField.layer.borderColor=[UIColor colorWithRed:3.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0].CGColor;
    pwdTextField.layer.borderWidth=1.0f;
    
    homeAddressTextField.layer.borderColor=[UIColor colorWithRed:3.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0].CGColor;
    homeAddressTextField.layer.borderWidth=1.0f;
    
    officeAddressTextField.layer.borderColor=[UIColor colorWithRed:3.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0].CGColor;
    officeAddressTextField.layer.borderWidth=1.0f;
    
    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, -30, 320, 480)];
    
    scrollView.autoresizesSubviews = 1;
    
    [scrollView addSubview:nameLabel];
    [scrollView addSubview:mobileLabel];
    [scrollView addSubview:nameTextField];
    [scrollView addSubview:mobileNumberTextField];
    [scrollView addSubview:pwdTextField];
    [scrollView addSubview:passwordLabel];
    [scrollView addSubview:homeAddressLabel];
    [scrollView addSubview:homeAddressTextField];
    [scrollView addSubview:officeAddressLabel];
    [scrollView addSubview:officeAddressTextField];
    [scrollView addSubview:submitButton];
    [scrollView addSubview:redMark];
    [scrollView addSubview:redMark1];
    [scrollView addSubview:redMark2];
    [scrollView addSubview:note];
    scrollView.contentSize=CGSizeMake(320, 560);
    [self.view addSubview:scrollView];
    
    tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard:)];
    tapGesture.numberOfTapsRequired=1;
   
}

-(void)dismissKeyboard:(UITapGestureRecognizer *)recognizer
{
    [nameTextField resignFirstResponder];
    [mobileNumberTextField resignFirstResponder];
    [pwdTextField resignFirstResponder];
    [homeAddressTextField resignFirstResponder];
    [officeAddressTextField resignFirstResponder];
    [self setViewMovedUp:NO tf:nil];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField==pwdTextField ||textField==homeAddressTextField ||textField==mobileNumberTextField || textField==officeAddressTextField)
    {
        [self setViewMovedUp:YES tf:textField];
    }
    return YES;
}

- (void)setViewMovedUp:(BOOL)movedUp tf:(UITextField *)tempTextFiled
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    CGRect tfRect=tempTextFiled.frame;
    
    if (movedUp)
    {
        [scrollView setContentOffset:CGPointMake(0, tfRect.origin.y-tfRect.size.height*6) animated:1];
    }
    else
    {
        
        [scrollView setContentOffset:CGPointMake(0, 0) animated:1];
    }
    
    [UIView commitAnimations];
}

//show keypad
-(void) keyboardWillShow:(NSNotification *) note
{
    [scrollView addGestureRecognizer:tapGesture];
}

//Hide keypad
-(void) keyboardWillHide:(NSNotification *) note
{
    [scrollView removeGestureRecognizer:tapGesture];
}

- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self setViewMovedUp:NO tf:textField];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitButtonClicked:(id)sender
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Registered successfully" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:nameTextField.text forKey:@"name"];
        [defaults setObject:mobileNumberTextField.text forKey:@"mobile"];
        [defaults setObject:pwdTextField.text forKey:@"password"];
        [defaults setObject:homeAddressTextField.text forKey:@"home"];
        [defaults setObject:officeAddressTextField.text forKey:@"office"];
        
        NSLog(@"%@",[defaults objectForKey:@"name"]);
        NSLog(@"%@",[defaults objectForKey:@"mobile"]);
        NSLog(@"%@",[defaults objectForKey:@"password"]);
        NSLog(@"%@",[defaults objectForKey:@"home"]);
        NSLog(@"%@",[defaults objectForKey:@"office"]);
        [defaults synchronize];
        
        if([nameTextField.text isEqual:@""] || [mobileNumberTextField.text isEqual:@""] || [pwdTextField.text isEqual:@""])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please Enter all the Mandetory Details" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
 
    }
}
@end
