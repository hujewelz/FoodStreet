//
//  MenuViewController.h
//  BerryProject
//
//  Created by jewelz on 15-1-19.
//  Copyright (c) 2015年 yangtzeU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Food;
@protocol MenuSelectedBtnDelegate;

@interface MenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) Food *food;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) BOOL cellBtnSelected;
@property (weak, nonatomic) id<MenuSelectedBtnDelegate> delegate;
@property (assign, nonatomic) BOOL shouldBack;

- (IBAction)btnClick:(UIButton *)sender;

- (IBAction)selectedBtnClick:(UIButton *)sender;

@end

@protocol MenuSelectedBtnDelegate <NSObject>

- (void)setBtnSelected:(BOOL)isSelected;

@end