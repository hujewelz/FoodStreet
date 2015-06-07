//
//  Food.m
//  BerryProject
//
//  Created by jewelz on 14-11-21.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import "Food.h"
#import "Shop.h"

@implementation Food

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.foodName = dict[@"name"];
        self.price = [dict[@"price"] doubleValue];
        self.url = dict[@"url"];
        NSDictionary *shopDict = dict[@"shop"];
        self.shop = [Shop shopWithDict:shopDict];
        NSLog(@"shopName:%@",self.shop.shopName);
        
    }
    return self;
}

+ (id)foddWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
