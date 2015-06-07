//
//  AlterView.h
//  BerryProject
//
//  Created by jewelz on 15-1-19.
//  Copyright (c) 2015年 yangtzeU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlterView : UIView
@property (nonatomic, assign) NSTimeInterval timeInterval;
@property (nonatomic, assign) BOOL shouldActivityIndicator;

- (id)initWithFrame:(CGRect)frame color:(UIColor *)color message:(NSString *)mes messageFontSize:(CGFloat)size;
- (void)loadDateCompletion:(void(^)())completionBlock;

@end
