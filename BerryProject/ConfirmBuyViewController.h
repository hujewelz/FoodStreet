//
//  ConfirmBuyViewController.h
//  BerryProject
//
//  Created by jewelz on 14-12-9.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Food;

@interface ConfirmBuyViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *consignee;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *shopName;

@property (weak, nonatomic) IBOutlet UIImageView *foodImage;
@property (weak, nonatomic) IBOutlet UILabel *foodName;
@property (weak, nonatomic) IBOutlet UILabel *foodDesc;
@property (weak, nonatomic) IBOutlet UILabel *foodPrice;
@property (weak, nonatomic) IBOutlet UILabel *foodCount;
@property (weak, nonatomic) IBOutlet UILabel *countLb;

@property (weak, nonatomic) IBOutlet UILabel *totlePrice;

@property (strong, nonatomic) Food *food;

- (IBAction)changeNomBtnClick:(UIButton *)sender;

- (IBAction)buyBtnClick:(id)sender;
@end
