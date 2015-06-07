//
//  Shop.h
//  BerryProject
//
//  Created by jewelz on 14-12-9.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shop : NSObject
@property (nonatomic, copy) NSString *shopName;
@property (nonatomic, copy) NSString *shopAdress;

- (id)initWithDict:(NSDictionary *)dict;

+ (id)shopWithDict:(NSDictionary *)dict;


@end
