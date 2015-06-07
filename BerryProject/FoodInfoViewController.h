//
//  FoodInfoViewController.h
//  BerryProject
//
//  Created by jewelz on 14-11-22.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Food;

@interface FoodInfoViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodNameLb;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLb;

@property (weak, nonatomic) IBOutlet UILabel *placeLb;

@property (strong, nonatomic) Food *food;
@property (strong, nonatomic) UIImage *image;

- (IBAction)addToMenu:(UIButton *)sender;

@end
