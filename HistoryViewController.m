//
//  HistoryViewController.m
//  CarRental
//
//  Created by tanla on 05/12/13.
//  Copyright (c) 2013 tanla. All rights reserved.
//

#import "HistoryViewController.h"
#import "BookingHistoryViewController.h"

@interface HistoryViewController ()
{
    UITableView *historyTableView1;
    NSMutableArray *historyArray1;
    NSString *source1;
    NSString *destination1;
    NSString *noofPassengers1;
    NSString *dateBooked1;
}

@end

@implementation HistoryViewController

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
        titleView.text =@"Booking History";
        [titleView sizeToFit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    historyTableView1=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 560) style:UITableViewStylePlain];
    historyTableView1.dataSource=self;
    historyTableView1.delegate=self;
    [self.view addSubview:historyTableView1];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    historyArray1=[[NSMutableArray alloc]initWithArray:[defaults objectForKey:@"travelHistory"] copyItems:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [historyTableView1 reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [historyArray1 count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil)//reusing cell
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    source1=[[historyArray1 objectAtIndex:indexPath.section] objectAtIndex:0];
    destination1=[[historyArray1 objectAtIndex:indexPath.section] objectAtIndex:1];
    noofPassengers1=[[historyArray1 objectAtIndex:indexPath.section] objectAtIndex:2];
    dateBooked1=[[historyArray1 objectAtIndex:indexPath.section] objectAtIndex:3];
    
    cell.textLabel.text=[NSString stringWithFormat:@"%@ - %@",source1,destination1];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"Date:%@       No Of Passengers: %@",dateBooked1,noofPassengers1];
    cell.textLabel.textColor=[UIColor colorWithRed:76.0/255.0 green:126.0/255.0 blue:200.0/255.0 alpha:1.0];
    cell.textLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:18];
    cell.detailTextLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:12];
    cell.textLabel.numberOfLines=0;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookingHistoryViewController *bookingHistoryVC=[[BookingHistoryViewController alloc]init];
    bookingHistoryVC.historyArray=[NSMutableArray arrayWithObjects:[[historyArray1 objectAtIndex:indexPath.section] objectAtIndex:0],[[historyArray1 objectAtIndex:indexPath.section] objectAtIndex:1],[[historyArray1 objectAtIndex:indexPath.section] objectAtIndex:2],[[historyArray1 objectAtIndex:indexPath.section] objectAtIndex:3],[[historyArray1 objectAtIndex:indexPath.section] objectAtIndex:4], nil];
    [self.navigationController pushViewController:bookingHistoryVC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.frame=CGRectMake(0, 0, 320, 0);
    return view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
