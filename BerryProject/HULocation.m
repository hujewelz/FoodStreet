//
//  HULocation.m
//  BerryProject
//
//  Created by jewelz on 14-11-24.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import "HULocation.h"

@implementation HULocation
static HULocation *location = nil;
+ (id)shareLocation
{
    dispatch_once_t once;
    dispatch_once(&once, ^{
        location = [[self alloc] init];
    });
    return location;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    NSLog(@"%@",_locationManager);
    return self;
}

-(void)startUpdatingLocationWithDelegate:(id <CLLocationManagerDelegate>)delegate
{
    NSLog(@"startUpdatingLocation");
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 500;
    self.locationManager.delegate = delegate;
    [self.locationManager startUpdatingLocation];
}

//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//    CLLocation *cl = [locations lastObject];
//    NSString *latitude = [NSString stringWithFormat:@"%f", cl.coordinate.latitude];
//    NSString *longitute = [NSString stringWithFormat:@"%f", cl.coordinate.longitude];
//    NSLog(@"latitude:%@, longitute%@",latitude, longitute);
//}

@end
