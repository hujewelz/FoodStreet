//
//  FoodInfoViewController.m
//  BerryProject
//
//  Created by jewelz on 14-11-22.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import "FoodInfoViewController.h"
#import "Food.h"
#import "Shop.h"
#import "ConfirmBuyViewController.h"
#import "ShopInfoViewController.h"
#import "MenuViewController.h"
#import "AlterView.h"
#import "UIViewController+CustomerBackButton.h"
#import "DocumentTool.h"

@interface FoodInfoViewController () <UINavigationControllerDelegate>
@property (strong, nonatomic) AlterView *alterView;
@property (strong, nonatomic) NSDictionary *menuDict;
@end

@implementation FoodInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.imageView.image = _image;
    self.imageView.image = [UIImage imageNamed:self.food.url];
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f", self.food.price];
    self.foodNameLb.text = self.food.foodName;
    self.shopNameLb.text = self.food.shop.shopName;
    self.placeLb.text = self.food.shop.shopAdress;
    
    self.navigationController.delegate = self;
    
    //设置返回按钮
    [self setBackButtonWithimageNamed:@"backBarItem.png"];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSString *url = self.food.url;
//        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//        UIImage *image = [UIImage imageWithData:data];
//        if (image != nil) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.imageView.image = image;
//            });
//        }
//    });
}

- (NSDictionary *)setUpDictData
{
    _menuDict = @{@"name": _food.foodName, @"shop": @{@"name": _food.shop.shopName}, @"price": [NSNumber numberWithDouble:_food.price],@"url": _food.url};
    return _menuDict;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ConfirmBuy"]) {
        
        ConfirmBuyViewController *confirmVc = [segue destinationViewController];
        [confirmVc setValue:_food forKey:@"food"];
        
    }if ([segue.identifier isEqualToString:@"Menu"]) {
        
        MenuViewController *menuVc = [segue destinationViewController];
        [menuVc setValue:@YES forKey:@"shouldBack"];
        
    } else {
    
        ShopInfoViewController *shopVc = segue.destinationViewController;
        shopVc.title = self.shopNameLb.text;
        
    }
    
    
    
}

- (void)addToMenu:(UIButton *)sender
{
    [self showAlterView];
    //写入文件
    [[DocumentTool sharedDocumentTool] write:[self setUpDictData] ToFileWithFileName:@"foodMenu"];
    
    //NSLog(@"%@",[[DocumentTool sharedDocumentTool] openContentsOfFile:@"foodMenu"]);
}

- (void) showAlterView
{
    self.tableView.allowsSelection = NO;
    self.tableView.scrollEnabled = NO;
    
    self.alterView = [[AlterView alloc] initWithFrame:CGRectMake(100, 200, 120, 60) color:[UIColor blackColor] message:@"成功添加到菜单" messageFontSize:14];
    
    [self.view addSubview:_alterView];
    self.alterView.timeInterval = .5;
    
    [self.alterView loadDateCompletion:^{
        [self performSelector:@selector(removeCover:) withObject:nil afterDelay:3];
    }];
    
}

- (void)removeCover:(NSTimer *)timer
{
    [self.alterView removeFromSuperview];
    self.tableView.allowsSelection = YES;
    self.tableView.scrollEnabled = YES;
    [timer invalidate];
}
@end
