//
//  ReviewViewController.h
//  CarRental
//
//  Created by tanla on 02/12/13.
//  Copyright (c) 2013 tanla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *favouritesArray;
@property(nonatomic,strong)NSMutableArray *detailsArray;
@property (strong, nonatomic) IBOutlet UIButton *confirmButton;
- (IBAction)confirmButtonClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *favBtn;
- (IBAction)favBtnClicked:(id)sender;

@end
