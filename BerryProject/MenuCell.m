//
//  MenuCell.m
//  BerryProject
//
//  Created by jewelz on 15-1-19.
//  Copyright (c) 2015年 yangtzeU. All rights reserved.
//

#import "MenuCell.h"
#import "Food.h"
#import "Shop.h"
#import "MenuViewController.h"

@implementation MenuCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //_selectedBtn.selected = NO;
    }
    return self;
}

- (void)setFood:(Food *)food
{
    _food = food;
    self.shopName.text = _food.shop.shopName;
    self.foodName.text = _food.foodName;
    self.foodImage.image = [UIImage imageNamed:_food.url];
    self.foodPrice.text = [NSString stringWithFormat:@"￥%.2f",_food.price];
    UILabel *totalPrice = (UILabel *)[self viewWithTag:10];
    totalPrice.text = self.foodPrice.text;
    //NSLog(@"%@", self.foodName);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedAll:) name:@"SELECTEDALL" object:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)SelectedBtnClick:(UIButton *)sender {
    self.selectedBtn = sender;
    if (_selectedBtn.isSelected) {
        _selectedBtn.selected = NO;
    } else
        _selectedBtn.selected = YES;
    
    NSDictionary *dict = @{@"selectedBtn": [NSNumber numberWithBool:self.selectedBtn.isSelected]};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SELECTEDBTNSYATUS" object:nil userInfo:dict];

}

- (void)selectedAll:(NSNotification *)info
{
    NSNumber *select = [info userInfo][@"selectedBtn"];
    self.selectedBtn.selected = [select boolValue];
}

@end
