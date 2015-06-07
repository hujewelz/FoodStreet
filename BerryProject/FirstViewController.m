//
//  TableViewController.m
//  BerryProject
//
//  Created by jewelz on 14-11-22.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import "FirstViewController.h"
#import "FoodInfoViewController.h"
#import "BusinessLogic.h"
#import "FoodDao.h"
#import "Food.h"
#import "LoadMoreView.h"
#import "MyCell.h"
#import "HULocation.h"

@interface FirstViewController () <CLLocationManagerDelegate ,UIGestureRecognizerDelegate>
{
    UISearchBar *_searchBar;
    BusinessLogic *business;
    FoodDao *foodDao;
    Food *food;
    LoadMoreView *loadView;
    BOOL isSearch,loadFailed,isOnce;
    UIView *mask;
    UIActivityIndicatorView *activityView;
    UILabel *loadFailedLabel;
    UIButton *btn;
    
    NSMutableArray *foodArray,*imageArray;
    MyCell *cell;
    
    NSString *latitude, *longitute;
    UILabel *locationLabel;
    CLGeocoder *geocoder;
}

@end

@implementation FirstViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置手势代理
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    //导航栏右侧搜索栏
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.frame = CGRectMake(0, 0, 220, 44);
    _searchBar.barTintColor = [UIColor colorWithPatternImage:[self imageWithColor:[UIColor clearColor]]];
    _searchBar.placeholder = @"搜索店内美食";
    _searchBar.delegate = self;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_searchBar];
    
    //导航栏左侧搜索栏
    UIView *leftBarItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    //leftBarItem.backgroundColor = [UIColor whiteColor];
    locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 50, 22)];
    locationLabel.text = @"";
    locationLabel.textColor = [UIColor whiteColor];
    locationLabel.font = [UIFont systemFontOfSize:15];
    
    UIButton *locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //[locationBtn setBackgroundColor:[UIColor blackColor]];
    [locationBtn setImage:[UIImage imageNamed:@"nav_btn_location.png"] forState:UIControlStateNormal];
    locationBtn.frame = CGRectMake(35, 2, 40, 40);
    [locationBtn addTarget:self action:@selector(startUpdatingMyLocation) forControlEvents:UIControlEventTouchUpInside];
    [leftBarItem addSubview:locationLabel];
    [leftBarItem addSubview:locationBtn];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarItem];
    
    //下拉刷新控件
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [refreshControl addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    //[loadView activityViewstartAnimating:YES];
    
    loadView = [[LoadMoreView alloc] init];
    
    //事物代理对象
    foodDao = [[FoodDao alloc] init];
    
    [self startRequest];
    
    [self showMaskView];
    
    imageArray = [NSMutableArray array];
    
    self.locationManager = [[CLLocationManager alloc] init];
    //创建地址解析器
    geocoder = [[CLGeocoder alloc] init];
    [self startUpdatingMyLocation];
    
}

#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.navigationController.viewControllers.count == 1)//关闭主界面的右滑返回
        return NO;
    else
        return YES;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startRequest
{
    
    business = [BusinessLogic businessWithDelegate:foodDao];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [business findAllSucceed:^(NSArray * result) {
        loadFailed = NO;
        self.data = result;
        [self loadTableViewData:_data];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failed:^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"food" ofType:@"plist"];
        self.data = [NSArray arrayWithContentsOfFile:path];
        [self loadTableViewData:_data];
//        loadFailed = YES;
//        [self.refreshControl endRefreshing];
//        //[self showAlertViewWithTitle:@"连接超时"];
//        loadFailedLabel.text = @"加载失败!";
//        btn.hidden = NO;
//        dispatch_async(dispatch_get_main_queue(), ^{
//             [activityView stopAnimating];
//        });
        
    }];
}

- (void)loadTableViewData:(NSArray *)data
{
    NSMutableArray *array = [NSMutableArray array];
    if (self.refreshControl) {
        //加载到数据后停止刷新
        [self.refreshControl endRefreshing];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
        
        for (NSDictionary *dict in data) {
            food = [Food foddWithDict:dict];
            [array addObject:food];
        }
        foodArray = [NSMutableArray arrayWithArray:array];
        //[self downLoadImage];
//        NSIndexPath *indexPath;
//        for (Food *f in foodArray) {
//            indexPath = [NSIndexPath indexPathForRow:[foodArray indexOfObject:f] inSection:0];
//            [self downLoadImageAtIndexPath:indexPath];
//        }
        
        [self.tableView reloadData];
        
    }
    
}

- (void)showMaskView
{
    
    mask = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    activityView = [[UIActivityIndicatorView alloc] init];
    activityView.center = CGPointMake(160, 60);;
    activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    activityView.hidesWhenStopped = YES;
    [activityView startAnimating];
    
    
    loadFailedLabel = [[UILabel alloc] init];
    loadFailedLabel.center = CGPointMake(160, 84);
    loadFailedLabel.bounds = CGRectMake(0, 0, 100, 22);
    loadFailedLabel.text = @"加载中...";
    loadFailedLabel.textAlignment = NSTextAlignmentCenter;
    loadFailedLabel.font = [UIFont systemFontOfSize:15];
    loadFailedLabel.textColor = [UIColor grayColor];
    
    
    btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"btn_loadmore.png"] forState:UIControlStateNormal];
    btn.center = CGPointMake(160, 120);
    btn.bounds = CGRectMake(0, 0, 80, 44);
    //btn.backgroundColor = [UIColor redColor];
    btn.hidden = YES;
    [btn addTarget:self action:@selector(reLoad:) forControlEvents:UIControlEventTouchUpInside];
    
    [mask addSubview:btn];
    [mask addSubview:loadFailedLabel];
    [mask addSubview:activityView];
    [self.tableView addSubview:mask];
    
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    self.tableView.allowsSelection = NO;
    self.tableView.scrollEnabled = NO;
    //self.tableView.contentOffset = CGPointMake(0, 5);
    //self.tableView.contentInset = UIEdgeInsetsMake(-5, 0, 0, 0);
    

}

- (void)reLoad:(UIButton *)sender
{
    sender.hidden = YES;
    [self startRequest];
    if ([activityView isAnimating]) {
        [activityView stopAnimating];
        loadFailedLabel.text = @"";
    } else {
        [activityView startAnimating];
        loadFailedLabel.text = @"加载中...";
    }
}

#pragma mark UIRefreshControl的回调方法
- (void) refreshTableView
{
    
    if (self.refreshControl.refreshing) {
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"加载中..."];
        [self startRequest];
    }
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"datacount:%d",foodArray.count);
    if (foodArray != nil) {
        [self.tableView setSeparatorColor:[UIColor colorWithRed:217.0f/255.0f green:217.0f/255.0f blue:217.0f/255.0f alpha:1]];
        [mask removeFromSuperview];
        self.tableView.allowsSelection = YES;
        self.tableView.scrollEnabled = YES;
    }
    
    return foodArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    
    cell.food = foodArray[indexPath.row];
//    if (imageArray && imageArray.count>0) {
//        cell.image = imageArray[indexPath.row];
//    }
    
    
    if (indexPath.row + 1 == self.data.count) {
        self.tableView.tableFooterView = loadView;
        [loadView activityViewstartAnimating:YES];
        //[self startRequest];
    }
    
    //NSLog(@"row:%d",indexPath.row);
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //[NSThread detachNewThreadSelector:@selector(downLoadImageAtIndexPath:) toTarget:self withObject:indexPath];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    NSInteger row = [self.tableView indexPathForSelectedRow].row;
    [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    
    FoodInfoViewController *viewController = segue.destinationViewController;
    
    Food *f = [foodArray objectAtIndex:row];
    //viewController.title = f.foodName;
    viewController.food = f;
//    UIImage *ia = [imageArray objectAtIndex:row];
//    if (ia) {
//        viewController.image = [imageArray objectAtIndex:row];
//    }
    
    
    //self.navigationController.navigationBar.alpha = 0.8;
    
}

-(void)downLoadImageAtIndexPath:(NSIndexPath *)indexPath
{
    __block UIImage *image;
    if (foodArray.count >0) {
        __block NSString *url;
        Food *f = [foodArray objectAtIndex:indexPath.row];
        url = f.url;
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        image = [UIImage imageWithData:data];
        NSLog(@"%@",image);
        [imageArray addObject:image];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"重新加载表视图");
            MyCell *_cell = (MyCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            _cell.image = image;
            //重新加载表视图
            //[self.tableView reloadData];
            //isOnce = NO;
        });
        
        //});
        
        
    }
    
    
}


-(void)downLoadImage
{
    __block UIImage *image;
    __block NSIndexPath *indexPath;
    if (foodArray.count >0) {
        __block NSString *url;
        for (Food *f in foodArray) {
            url = f.url;
            indexPath = [NSIndexPath indexPathForRow:[foodArray indexOfObject:f] inSection:0];
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            image = [UIImage imageWithData:data];
            NSLog(@"%@",image);
            [imageArray addObject:image];
        }

        
            dispatch_async(dispatch_get_main_queue(), ^{
               NSLog(@"重新加载表视图");
               MyCell *_cell = (MyCell *)[self.tableView cellForRowAtIndexPath:indexPath];
                _cell.image = image;
                //重新加载表视图
                [self.tableView reloadData];
            });
        
        //});
       
        
    }

    
}

#pragma mark SearchBar Delegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    // 开始搜索时弹出 mask 并禁止 tableview 点击
    isSearch = YES;
    [searchBar setShowsCancelButton:YES animated:YES];
    
    //修改searchBar的取消按钮
    for (UIView *v in [searchBar.subviews[0] subviews]) {
        //for (UIView *v in [subView subviews]) {
            if ([NSStringFromClass(v.class) isEqualToString:@"UINavigationButton"]) {
                [(UIButton *)v setTitle:@"取消" forState:UIControlStateNormal];
            }
        //}
        
    }
    
    //mask.alpha = 1;
    self.tableView.allowsSelection = NO;
    self.tableView.scrollEnabled = NO;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"textDidChange:%@", searchText);
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"searchBarSearchButtonClicked:%@", searchBar.text);
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    isSearch = NO;
    searchBar.showsCancelButton = NO;
    searchBar.text = @"";
    //mask.alpha = 0;
    self.tableView.allowsSelection = YES;
    self.tableView.scrollEnabled = YES;
    [searchBar resignFirstResponder];
    
    //重新加载视图
}

#pragma mark 定位
-(void)startUpdatingMyLocation
{
    NSLog(@"location");
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 500;
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
}

#pragma mark CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"location....");
    CLLocation *cl = [locations lastObject];
    latitude = [NSString stringWithFormat:@"%f", cl.coordinate.latitude];
    longitute = [NSString stringWithFormat:@"%f", cl.coordinate.longitude];
    NSLog(@"latitude:%@, longitute%@",latitude, longitute);
    [self findMyPlaceWithLatitude:latitude andLongitute:longitute];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@", [error localizedDescription]);
}

- (void)findMyPlaceWithLatitude:(NSString *)la andLongitute:(NSString *)lo
{
    NSString *longituteStr = lo;
    NSString *latitueStr = la;
    
    if (longituteStr != nil && longituteStr.length >0 && latitueStr != nil && latitueStr.length >0) {
        //NSLog(@"latitude:%@, longitute%@",latitueStr, longituteStr);
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[latitueStr floatValue] longitude:[longituteStr floatValue]];
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
            if (placemarks.count > 0) {
                CLPlacemark *placemark = [placemarks objectAtIndex:0];
                locationLabel.text = [placemark.locality substringToIndex:placemark.locality.length-1];
            } else {
                UIAlertView *alv = [[UIAlertView alloc] initWithTitle:nil message:@"定位失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alv show];
            }
        }];
    }
}

#pragma mark self define
- (void)showAlertViewWithTitle:(NSString *)title
{
    UIView *aV = [[UIView alloc] init];
    aV.frame = CGRectMake(100, 0, 120, 26);
    aV.backgroundColor = [UIColor yellowColor];
    aV.alpha = 0.8;
    
    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 110, 22)];
    la.text = title;
    //la.textColor = [];
    la.font = [UIFont systemFontOfSize:12];
    la.textAlignment = NSTextAlignmentCenter;
    
    UIImageView *signal = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"warnsignal.png"]];
    signal.frame = CGRectMake(4, 2, 22, 22);
    [aV addSubview:signal];
    [aV addSubview:la];
    [self.view addSubview:aV];
    
    
    [UIView animateWithDuration:3.0f animations:^{
        aV.alpha = 0;
        
    } completion:^(BOOL finished) {
        [aV removeFromSuperview];
    }];
    
}


- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}



@end
