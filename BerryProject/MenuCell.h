//
//  MenuCell.h
//  BerryProject
//
//  Created by jewelz on 15-1-19.
//  Copyright (c) 2015年 yangtzeU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"

@class Food;

@interface MenuCell : UITableViewCell 
@property (strong, nonatomic) Food *food;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UIImageView *foodImage;
@property (weak, nonatomic) IBOutlet UILabel *foodName;
@property (weak, nonatomic) IBOutlet UILabel *foodPrice;
@property (weak, nonatomic) IBOutlet UILabel *foodDesc;
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;

- (IBAction)SelectedBtnClick:(UIButton *)sender;


@end
