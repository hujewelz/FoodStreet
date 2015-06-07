//
//  LoadMoreView.m
//  BerryProject
//
//  Created by jewelz on 14-11-22.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import "LoadMoreView.h"

@implementation LoadMoreView

- (id)init
{
    if (self) {
       self = [[[NSBundle mainBundle] loadNibNamed:@"LoadMoreView" owner:self options:nil] lastObject];
        //self.backgroundColor = [UIColor grayColor];
        _activityView = [[UIActivityIndicatorView alloc] init];
        _activityView.center = CGPointMake(124, 22);
        _activityView.hidesWhenStopped = YES;
        _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        
        [self addSubview:_activityView];
    }
    return self;
}

-(void)activityViewstartAnimating:(BOOL)animating
{
    if (animating) {
        [self.activityView startAnimating];
        
    } else
        [self.activityView stopAnimating];
    
}

@end
