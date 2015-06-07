//
//  LoadMoreView.h
//  BerryProject
//
//  Created by jewelz on 14-11-22.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadMoreView : UIView
@property (retain, nonatomic) UIActivityIndicatorView *activityView;
- (void)activityViewstartAnimating:(BOOL)animating;
@end
