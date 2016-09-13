//
//  CarsViewController.m
//  CarRental
//
//  Created by tanla on 02/12/13.
//  Copyright (c) 2013 tanla. All rights reserved.
//

#import "CarsViewController.h"


@interface CarsViewController ()
{
    UITableView *carsTableView;
    NSMutableArray *arrayOfCarsImages;
    NSMutableArray *arrayOfCarsNames;
    NSMutableArray *arrayofCarsRents;
}

@end

@implementation CarsViewController

@synthesize VC;

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
        titleView.text =@"Select Car";
        [titleView sizeToFit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    carsTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStylePlain];
    carsTableView.dataSource=self;
    carsTableView.delegate=self;
    [self.view addSubview:carsTableView];
    
    arrayOfCarsImages=[[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"audi.jpg"],[UIImage imageNamed:@"benz.jpg"],[UIImage imageNamed:@"taxi.jpg"], nil];
    
    arrayOfCarsNames=[[NSMutableArray alloc]initWithObjects:@"Audi(Gold Service)",@"Benz(Gold Service)",@"Taxi(Normal Service)", nil];
    
    arrayofCarsRents=[[NSMutableArray alloc]initWithObjects:@"$100 per Hour",@"$100 per Hour",@"$25 per Hour", nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [arrayOfCarsNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil)//reusing cell
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    UIImageView * tempAd = [[UIImageView alloc]initWithFrame:CGRectMake(220, cell.frame.origin.y, 100,60)];
    tempAd.image = [arrayOfCarsImages objectAtIndex:indexPath.row];
    cell.userInteractionEnabled=YES;
    cell.imageView.frame=tempAd.frame;
    [cell addSubview:tempAd];
    
    cell.textLabel.text=[arrayOfCarsNames objectAtIndex:indexPath.row];
    cell.detailTextLabel.text=[arrayofCarsRents objectAtIndex:indexPath.row];
    
    cell.textLabel.textColor=[UIColor colorWithRed:76.0/255.0 green:126.0/255.0 blue:159.0/255.0 alpha:1.0];
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor colorWithRed:(224.0/255.0) green:(74.0/255.0) blue:(101.0/255.0) alpha:1.0];
    cell.selectedBackgroundView = selectionColor;
    cell.textLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:18];
    cell.textLabel.textAlignment=NSTextAlignmentRight;
    cell.detailTextLabel.textColor=[UIColor redColor];
    cell.textLabel.numberOfLines=0;
    tableView.separatorColor=[UIColor colorWithRed:3.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for(int i=0;i<[self.navigationController.viewControllers count];i++)
    {
    if (self.navigationController.viewControllers[i]==VC)
    {
        NSString *tempString=[NSString stringWithFormat:@"%@-%@",[arrayOfCarsNames objectAtIndex:indexPath.row],[arrayofCarsRents objectAtIndex:indexPath.row]];
        
        VC.carTitle=tempString;
        [self.navigationController popToViewController:VC animated:YES];
    }
   
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
