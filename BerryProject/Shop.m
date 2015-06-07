//
//  Shop.m
//  BerryProject
//
//  Created by jewelz on 14-12-9.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import "Shop.h"

@implementation Shop

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.shopName = dict[@"name"];
        self.shopAdress = dict[@"adress"];
    }
    return self;
}

+ (id)shopWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
