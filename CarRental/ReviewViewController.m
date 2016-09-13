//
//  ReviewViewController.m
//  CarRental
//
//  Created by tanla on 02/12/13.
//  Copyright (c) 2013 tanla. All rights reserved.
//

#import "ReviewViewController.h"
#import "BookingStatusViewController.h"
#import "FavouritesViewController.h"

@interface ReviewViewController ()
{
    UITableView *reviewAllData;
    NSMutableArray *titlesArray;
    
    NSUserDefaults *defaults;
    
    NSMutableArray * arrayUserDefaults;
    NSMutableArray *favUserDefaults;
    NSArray *arrayOfImages;
}

@end

@implementation ReviewViewController

@synthesize favouritesArray,detailsArray;

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
            titleView.font = [UIFont boldSystemFontOfSize:14.0];
            titleView.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
            
            titleView.textColor = [UIColor whiteColor]; // Change to desired color
            
            self.navigationItem.titleView = titleView;
        }
        titleView.text =@"Review Booking";
        [titleView sizeToFit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    reviewAllData=[[UITableView alloc]initWithFrame:CGRectMake(0,64, 320, 315) style:UITableViewStylePlain];
    reviewAllData.delegate=self;
    reviewAllData.dataSource=self;
    [self.view addSubview:reviewAllData];
    
    defaults = [NSUserDefaults standardUserDefaults];
    titlesArray=[[NSMutableArray alloc]initWithObjects:@"from",@"To",@"No of Passengers",@"Date/Time",@"Type of Car", nil];
    
    //detailsArray=[[NSMutableArray alloc]initWithObjects:[defaults objectForKey:@"fromAddress"],[defaults objectForKey:@"toAddress"],[defaults objectForKey:@"noofpassengers"],[defaults objectForKey:@"date"],[defaults objectForKey:@"car"], nil];
    
    favouritesArray=[[NSMutableArray alloc]init];
    //detailsArray=[[NSMutableArray alloc]init];
    favUserDefaults=[[NSMutableArray alloc]init];
    
    arrayOfImages=[[NSArray alloc]initWithObjects:[UIImage imageNamed:@"to.png"],[UIImage imageNamed:@"From.png"],[UIImage imageNamed:@"people-icon.png"],[UIImage imageNamed:@"clock-icon-hi.png"],[UIImage imageNamed:@"car.png"], nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [detailsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil)//reusing cell
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    UIImageView * tempAd = [[UIImageView alloc]initWithFrame:CGRectMake(280, cell.frame.origin.y+15, 30,30)];
    tempAd.image = [arrayOfImages objectAtIndex:indexPath.row];
    cell.userInteractionEnabled=YES;
    cell.imageView.frame=tempAd.frame;
    [cell addSubview:tempAd];

    
    cell.textLabel.text=[titlesArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text=[detailsArray objectAtIndex:indexPath.row];
    
    cell.detailTextLabel.textColor=[UIColor colorWithRed:76.0/255.0 green:126.0/255.0 blue:200.0/255.0 alpha:1.0];
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor colorWithRed:(224.0/255.0) green:(74.0/255.0) blue:(101.0/255.0) alpha:1.0];
    cell.selectedBackgroundView = selectionColor;
    cell.textLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:12];
    cell.detailTextLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:18];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    cell.detailTextLabel.textAlignment=NSTextAlignmentCenter;
    cell.textLabel.numberOfLines=0;
    tableView.separatorColor=[UIColor colorWithRed:3.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)confirmButtonClicked:(id)sender
{
    NSUserDefaults * defaults1 = [NSUserDefaults standardUserDefaults];
    arrayUserDefaults = [[defaults1 objectForKey:@"travelHistory"] mutableCopy];
    //NSLog(@"%@ lkasjdk", arrayUserDefaults);
    if(!arrayUserDefaults)
    {
        arrayUserDefaults = [[NSMutableArray alloc] initWithObjects:detailsArray, nil];
    }
    else
    {
        [arrayUserDefaults insertObject:detailsArray atIndex:0];
    }
    [defaults1 setObject:arrayUserDefaults forKey:@"travelHistory"];
    
    BookingStatusViewController *statusVC;
    if(!statusVC)
    {
        statusVC=[[BookingStatusViewController alloc]init];
    }
    [self.navigationController pushViewController:statusVC animated:YES];
}

- (IBAction)favBtnClicked:(id)sender
{
    NSUserDefaults * defaults2 = [NSUserDefaults standardUserDefaults];
    favUserDefaults = [[defaults2 objectForKey:@"favRides"] mutableCopy];
    if(!favUserDefaults)
    {
        favUserDefaults = [[NSMutableArray alloc] initWithObjects:detailsArray, nil];
    }
    else
    {
        [favUserDefaults insertObject:detailsArray atIndex:0];
    }
    [defaults2 setObject:favUserDefaults forKey:@"favRides"];
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Booking added to favourites successfully" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
}
@end
