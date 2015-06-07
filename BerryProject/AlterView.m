//
//  AlterView.m
//  BerryProject
//
//  Created by jewelz on 15-1-19.
//  Copyright (c) 2015年 yangtzeU. All rights reserved.
//

#import "AlterView.h"


@interface AlterView()
@property (nonatomic, strong) UIView *alterView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIActivityIndicatorView *activity;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, assign) CGRect aFrame;
@property (nonatomic, assign) CGFloat size;

@end

@implementation AlterView

- (id)initWithFrame:(CGRect)frame color:(UIColor *)color message:(NSString *)mes messageFontSize:(CGFloat)size
{
    self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    if (self) {
        _aFrame = frame;
        _color = color;
        _message = [mes copy];
        _size = size;
        _timeInterval = 2.0;
        _shouldActivityIndicator = YES;
        
        _alterView = [[UIView alloc] init];
        _alterView.frame = CGRectZero;
        
        _label = [[UILabel alloc] init];
        _label.frame = CGRectZero;
        [_alterView addSubview:_label];
        
        _activity = [[UIActivityIndicatorView alloc] init];
        _activity.frame = CGRectZero;
        [_alterView addSubview:_activity];
        
        [self addSubview:_alterView];
        
    }
    return self;
}

- (void)layoutSubviews
{
    self.alpha = 0.8;
    self.backgroundColor = [UIColor grayColor];
    
    self.alterView.frame = self.aFrame;
    self.alterView.layer.cornerRadius = self.alterView.frame.size.height * 0.2;
    self.alterView.layer.masksToBounds = YES;
    self.alterView.backgroundColor = self.color;
    
    self.label.textColor = [UIColor whiteColor];
    self.label.font = [UIFont systemFontOfSize:self.size];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.numberOfLines = 0;
    
    UIFont *font = [UIFont systemFontOfSize:_size];
    CGSize size = CGSizeMake(320, 2000);
    CGRect lablelRect = [_message boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    
    CGFloat y = (self.alterView.frame.size.height - lablelRect.size.height) / 2;
    
    self.label.frame = CGRectMake(0,y,self.alterView.frame.size.width, lablelRect.size.height);
    
    
    self.activity.center = CGPointMake((self.alterView.frame.size.width-10)/2, (self.alterView.frame.size.height-8)/2);
    self.activity.hidesWhenStopped = YES;
    self.activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    
}

- (void)loadDateCompletion:(void (^)())completionBlock
{
    if (_shouldActivityIndicator) {
        [self.activity startAnimating];
    }
    
    [self performSelector:@selector(stop:) withObject:nil afterDelay:_timeInterval];
    completionBlock();
}

- (void)stop: (NSTimer *)timer
{
    if (self.activity.isAnimating) {
        [self.activity stopAnimating];
    }
    
    self.label.text = self.message;
    [self performSelector:@selector(hid:) withObject:nil afterDelay:2];
    [timer invalidate];
}

- (void)hid: (NSTimer *)timer
{
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        
    }];
    [timer invalidate];
}

@end
