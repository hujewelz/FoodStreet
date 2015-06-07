//
//  Food.h
//  BerryProject
//
//  Created by jewelz on 14-11-21.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Shop;

@interface Food : NSObject
@property (copy, nonatomic) NSString *foodName;
@property (copy, nonatomic) NSString *url;
@property (assign, nonatomic) double price;
@property (copy, nonatomic) NSString *place;
@property (strong, nonatomic) Shop *shop;

- (id)initWithDict:(NSDictionary *)dict;

+ (id)foddWithDict:(NSDictionary *)dict;

@end
