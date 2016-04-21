//
//  CarsViewController.h
//  CarRental
//
//  Created by tanla on 02/12/13.
//  Copyright (c) 2013 tanla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookCabViewController.h"

@interface CarsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)BookCabViewController *VC;

@end
