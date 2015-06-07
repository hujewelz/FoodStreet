//
//  TableViewController.h
//  BerryProject
//
//  Created by jewelz on 14-11-22.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface FirstViewController : UITableViewController <UISearchBarDelegate>
@property (strong, nonatomic) NSArray *data;
@property (nonatomic, strong) CLLocationManager *locationManager;
@end
