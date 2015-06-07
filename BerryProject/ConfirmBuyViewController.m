//
//  ConfirmBuyViewController.m
//  BerryProject
//
//  Created by jewelz on 14-12-9.
//  Copyright (c) 2014年 yangtzeU. All rights reserved.
//

#import "ConfirmBuyViewController.h"
#import "FoodInfoViewController.h"
#import "Food.h"
#import "Shop.h"
#import "AlterView.h"
#import "ToolBar.h"
#import "UIViewController+CustomerBackButton.h"

@interface ConfirmBuyViewController () <UIAlertViewDelegate>
{
    BOOL submitAgain;
}

@property (assign, nonatomic) int count;
@property (strong, nonatomic) AlterView *alterView;
@property (nonatomic, strong) UIView *cover;
@end

@implementation ConfirmBuyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置返回按钮
    [self setBackButtonWithimageNamed:@"backBarItem.png"];
    
    //self.address.textAlignment
    NSString *str = @"收获地址:浪费了的疯了疯了短发短发了收到了丰富的丰富的方法奋斗奋斗方法";
    UIFont *font = [UIFont systemFontOfSize:14];
    CGSize size = CGSizeMake(320, 2000);
    CGRect lablelRect = [str boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName] context:nil];
    self.address.frame = CGRectMake(0,0,lablelRect.size.width, lablelRect.size.height);
    self.address.text = str;
    
    self.tableView.contentOffset = CGPointMake(0, 35);
    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    

    self.shopName.text = self.food.shop.shopName;
    self.foodName.text = self.food.foodName;
    self.foodImage.image = [UIImage imageNamed:self.food.url];
    self.foodPrice.text = [NSString stringWithFormat:@"￥%.2f",_food.price];
    
    self.count = 1;
    self.totlePrice.text = [NSString stringWithFormat:@"￥%.2f",_food.price * self.count];
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadFoofCount
{
    self.foodCount.text = [NSString stringWithFormat:@"x%d", self.count];
    self.countLb.text = [NSString stringWithFormat:@"%d", self.count];
    self.totlePrice.text = [NSString stringWithFormat:@"￥%.2f",_food.price * self.count];
}


#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        return;
    } else {
        [self showAlterView];
    }
}

- (IBAction)changeNomBtnClick:(UIButton *)sender {
    
    if (sender.tag == 1) {
        self.count ++;
    } else {
        self.count --;
        if (self.count < 1) {
            self.count = 1;
        }
    }
    
    [self loadFoofCount];
}

- (IBAction)buyBtnClick:(id)sender {
    if (submitAgain) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"确定要重复提交订单吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alter show];
    } else {
        submitAgain = YES;
        [self showAlterView];
    }
}

- (void) showAlterView
{
    self.tableView.allowsSelection = NO;
    self.tableView.scrollEnabled = NO;
    
    self.alterView = [[AlterView alloc] initWithFrame:CGRectMake(100, 200, 120, 60) color:[UIColor blackColor] message:@"提交成功" messageFontSize:16];
    

    [self.view addSubview:_alterView];
    
    [self.alterView loadDateCompletion:^{
        [self performSelector:@selector(removeCover:) withObject:nil afterDelay:4];
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
