//
//  MyCell.h
//  BerryProject
//
//  Created by jewelz on 14-11-22.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Food;

@interface MyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *foodImage;
@property (weak, nonatomic) IBOutlet UILabel *foodName;
@property (weak, nonatomic) IBOutlet UILabel *foodPrice;

@property (strong, nonatomic) Food *food;
@property (strong, nonatomic) UIImage *image;

@end
