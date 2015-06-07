//
//  FoodDao.h
//  BerryProject
//
//  Created by jewelz on 14-11-21.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessLogic.h"
@class HUNetwork;
@interface FoodDao : NSObject <BusinessAction>
{
    HUNetwork *netWork;
    NSDictionary *dict;
    __block NSMutableArray *listDataArray;
}
@end
