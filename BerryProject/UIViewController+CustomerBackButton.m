//
//  UIViewController+CustomerBackButton.m
//  BerryProject
//
//  Created by jewelz on 15-1-19.
//  Copyright (c) 2015年 yangtzeU. All rights reserved.
//

#import "UIViewController+CustomerBackButton.h"

@implementation UIViewController (CustomerBackButton)

- (void)setBackButtonWithimageNamed:(NSString *)imageNamed
{
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 40)];
    [backBtn setImage:[UIImage imageNamed:imageNamed] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
