//
//  FavouritesViewController.h
//  CarRental
//
//  Created by tanla on 02/12/13.
//  Copyright (c) 2013 tanla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewViewController.h"
#import "BookCabViewController.h"
@class LocationViewController;

@interface FavouritesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray *favArray;
@property(nonatomic,strong)BookCabViewController *bookVC;
@property(nonatomic,strong) LocationViewController *lVC;
@property(nonatomic,strong)NSString *detailsFavButtonClicked;
@end
