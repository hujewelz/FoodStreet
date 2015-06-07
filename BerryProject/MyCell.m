//
//  MyCell.m
//  BerryProject
//
//  Created by jewelz on 14-11-22.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import "MyCell.h"
#import "Food.h"

@implementation MyCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setFood:(Food *)food
{
    _food = food;
//    NSString *url = _food.url;
//    
//    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadImage:) object:url];
//    [thread start]; 
    self.foodName.text = _food.foodName;
    self.foodPrice.text = [NSString stringWithFormat:@"%.2f￥",_food.price];
    //self.foodImage.image = _image;
     self.foodImage.image = [UIImage imageNamed:_food.url];
    
}


- (void)downloadImage:(NSString *)url
{

    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    NSLog(@"url%@",url);
    UIImage *image = [UIImage imageWithData:data];
    if (image != nil) {
        [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:NO];
    }
}

- (void)updateUI:(UIImage *)image
{
    self.foodImage.image = image;
}

@end
