//
//  BookingHistoryViewController.m
//  CarRental
//
//  Created by tanla on 02/12/13.
//  Copyright (c) 2013 tanla. All rights reserved.
//

#import "BookingHistoryViewController.h"

@interface BookingHistoryViewController ()
{
    UITableView *historyTableView;
    NSArray *titlesArray;
}

@end

@implementation BookingHistoryViewController
@synthesize historyArray;

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
        titleView.text =@"History Details";
        [titleView sizeToFit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    historyTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 560) style:UITableViewStylePlain];
    historyTableView.dataSource=self;
    historyTableView.delegate=self;
    [self.view addSubview:historyTableView];
    titlesArray=[[NSMutableArray alloc]initWithObjects:@"from",@"To",@"No of Passengers",@"Date/Time",@"Type of Car", nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [historyTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [historyArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil)//reusing cell
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.text=[titlesArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [historyArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.textColor=[UIColor colorWithRed:76.0/255.0 green:126.0/255.0 blue:200.0/255.0 alpha:1.0];
    cell.textLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:12];
    cell.detailTextLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:18];
    cell.textLabel.numberOfLines=0;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    return view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
