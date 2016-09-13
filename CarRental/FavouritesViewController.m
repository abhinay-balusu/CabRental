//
//  FavouritesViewController.m
//  CarRental
//
//  Created by tanla on 02/12/13.
//  Copyright (c) 2013 tanla. All rights reserved.
//

#import "FavouritesViewController.h"
#import "LocationViewController.h"


@interface FavouritesViewController ()
{
    NSMutableArray *favArrayCopy;
    UITableView *favTableView;
    NSString *source;
    NSString *destination;
    NSString *noofPassengers;
    NSString *dateBooked;
    
}

@end

@implementation FavouritesViewController

@synthesize favArray,bookVC,lVC,detailsFavButtonClicked;

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
        titleView.text =@"Favourites";
        [titleView sizeToFit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    favArrayCopy=[[NSMutableArray alloc]initWithArray:[defaults objectForKey:@"favRides"] copyItems:YES];
    
    favTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 450) style:UITableViewStylePlain];
    favTableView.delegate=self;
    favTableView.dataSource=self;
    [self.view addSubview:favTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [favArrayCopy count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil)//reusing cell
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    source=[[favArrayCopy objectAtIndex:indexPath.section] objectAtIndex:0];
    destination=[[favArrayCopy objectAtIndex:indexPath.section] objectAtIndex:1];
    noofPassengers=[[favArrayCopy objectAtIndex:indexPath.section] objectAtIndex:2];
    dateBooked=[[favArrayCopy objectAtIndex:indexPath.section] objectAtIndex:3];
    
    cell.textLabel.text=[NSString stringWithFormat:@"%@ - %@",source,destination];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"Date:%@       No Of Passengers: %@",dateBooked,noofPassengers];
    
    cell.textLabel.textColor=[UIColor colorWithRed:76.0/255.0 green:126.0/255.0 blue:200.0/255.0 alpha:1.0];
    cell.textLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:16];
    cell.textLabel.numberOfLines=0;
    tableView.separatorColor=[UIColor lightGrayColor];
    cell.detailTextLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:12];
    cell.detailTextLabel.textAlignment=NSTextAlignmentCenter;
    
    if([detailsFavButtonClicked isEqualToString:@"yes"])
    {
        UIButton *gotoBooking=[[UIButton alloc]initWithFrame:CGRectMake(267, cell.frame.origin.y+10, 50, 22)];
        [gotoBooking setTitle:@"Book" forState:UIControlStateNormal];
        [gotoBooking setBackgroundColor:[UIColor colorWithRed:3.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0]];
        gotoBooking.tag=indexPath.section;
        [gotoBooking addTarget:self action:@selector(bookCab:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:gotoBooking];
    }
    return cell;
}
-(void)bookCab: (UIButton *)button
{
    int sectionIndexPath = button.tag;
    NSLog(@"go to booking page:%d",sectionIndexPath);
    BookCabViewController *bookVC2=[[BookCabViewController alloc]init];
    
    bookVC2.fromCity=[[favArrayCopy objectAtIndex:sectionIndexPath] objectAtIndex:0];
    bookVC2.toCity=[[favArrayCopy objectAtIndex:sectionIndexPath] objectAtIndex:1];
    bookVC2.passengerCount=[[favArrayCopy objectAtIndex:sectionIndexPath] objectAtIndex:2];
    bookVC2.carService=[[favArrayCopy objectAtIndex:sectionIndexPath] objectAtIndex:4];
    bookVC2.boolString=@"yes";
    [self.navigationController pushViewController:bookVC2 animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for(int i=0;i<[self.navigationController.viewControllers count];i++)
    {
        if (self.navigationController.viewControllers[i]==bookVC)
        {
            bookVC.fromCity=[[favArrayCopy objectAtIndex:indexPath.section] objectAtIndex:0];
            bookVC.toCity=[[favArrayCopy objectAtIndex:indexPath.section] objectAtIndex:1];
            bookVC.passengerCount=[[favArrayCopy objectAtIndex:indexPath.section] objectAtIndex:2];
            bookVC.carService=[[favArrayCopy objectAtIndex:indexPath.section] objectAtIndex:4];
            [self.navigationController popToViewController:bookVC animated:YES];
            
        }
        if (self.navigationController.viewControllers[i]==lVC)
        {
            BookCabViewController *bookVC1=[[BookCabViewController alloc]init];
            
            bookVC1.fromCity=[[favArrayCopy objectAtIndex:indexPath.section] objectAtIndex:0];
            bookVC1.toCity=[[favArrayCopy objectAtIndex:indexPath.section] objectAtIndex:1];
            bookVC1.passengerCount=[[favArrayCopy objectAtIndex:indexPath.section] objectAtIndex:2];
            bookVC1.carService=[[favArrayCopy objectAtIndex:indexPath.section] objectAtIndex:4];
            bookVC1.boolString=@"yes";
            [self.navigationController pushViewController:bookVC1 animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [favTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
