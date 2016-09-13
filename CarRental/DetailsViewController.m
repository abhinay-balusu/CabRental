//
//  DetailsViewController.m
//  CarRental
//
//  Created by tanla on 02/12/13.
//  Copyright (c) 2013 tanla. All rights reserved.
//

#import "DetailsViewController.h"
#import "BookCabViewController.h"
#import "BookingHistoryViewController.h"
#import "FavouritesViewController.h"
#import "LocationViewController.h"
#import "HistoryViewController.h"

@interface DetailsViewController ()
{
    NSString *isDetailsFavButtonClicked;
}

@end

@implementation DetailsViewController

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
        titleView.text =@"Home";
        [titleView sizeToFit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if(self.view.frame.size.height>=568)
    {
        
    }
    else
    {
        self.designImageView.frame=CGRectMake(self.designImageView.frame.origin.x, self.designImageView.frame.origin.y+20, self.designImageView.frame.size.width, 200);
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone  target:self action:@selector(noAction1)];
    if(self.view.frame.size.height>=568)
    {
        
    }
    else
    {
        self.designImageView.frame=CGRectMake(self.designImageView.frame.origin.x, self.designImageView.frame.origin.y, self.designImageView.frame.size.width, 200);
    }
}

-(void)noAction1
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startBookingButtonClicked:(id)sender
{
    BookCabViewController *bookCabVC;
    if(!bookCabVC)
    {
        bookCabVC=[[BookCabViewController alloc]init];
    }
    [self.navigationController pushViewController:bookCabVC animated:YES];
}

- (IBAction)bookingHistoryButtonClicked:(id)sender
{
    HistoryViewController *historyVC;
    if(!historyVC)
    {
        historyVC=[[HistoryViewController alloc]init];
    }
    [self.navigationController pushViewController:historyVC animated:YES];
}

- (IBAction)favouritesButtonClicked:(id)sender
{
    isDetailsFavButtonClicked=@"yes";
    FavouritesViewController *favouritesVC;
    if(!favouritesVC)
    {
        favouritesVC=[[FavouritesViewController alloc]init];
    }
    favouritesVC.detailsFavButtonClicked=isDetailsFavButtonClicked;
    [self.navigationController pushViewController:favouritesVC animated:YES];
}

- (IBAction)bookingThroughMapButtonClicked:(id)sender
{
    LocationViewController *locationVC;
    if(!locationVC)
    {
        locationVC=[[LocationViewController alloc]init];
    }
    
    [self.navigationController pushViewController:locationVC animated:YES];
}

- (IBAction)setAddressButton:(id)sender
{
    SettingAddressViewController *settingAddressVC=[[SettingAddressViewController alloc]init];
    [self.navigationController pushViewController:settingAddressVC animated:YES];
}
@end
