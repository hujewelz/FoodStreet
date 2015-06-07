//
//  HULocation.h
//  BerryProject
//
//  Created by jewelz on 14-11-24.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface HULocation : NSObject
@property (nonatomic, strong) CLLocationManager *locationManager;

+ (id)shareLocation;
- (void)startUpdatingLocationWithDelegate:(id <CLLocationManagerDelegate>)delegate;

@end
