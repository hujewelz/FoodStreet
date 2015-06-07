//
//  MenuViewController.m
//  BerryProject
//
//  Created by jewelz on 15-1-19.
//  Copyright (c) 2015年 yangtzeU. All rights reserved.
//

#import "MenuViewController.h"
#import "UIViewController+CustomerBackButton.h"
#import "ToolBar.h"
#import "Food.h"
#import "MenuCell.h"
#include "DocumentTool.h"
static NSString *IDENTIFER = @"MenuCell";

@interface MenuViewController ()
@property (strong, nonatomic) MenuCell *cell;
@property (strong, nonatomic) NSDictionary *menuDict;
@property (strong, nonatomic) NSMutableArray *menuDictArray;
@property (assign, nonatomic) CGFloat offseY;
@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.shouldBack) {
        [self setBackButtonWithimageNamed:@"backBarItem.png"];
        _offseY = 60.0;
    } else {
        _offseY = 109.0;
    }
    
    self.tableView.contentOffset = CGPointMake(0, 35);
    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);

    self.tableView.dataSource = self;
    
    UIView *toolBar = [[[NSBundle mainBundle] loadNibNamed:@"ToolBar" owner:self options:nil] lastObject];
    toolBar.frame = CGRectMake(0, self.view.frame.size.height-self.offseY, 320, 60);
    [self.view insertSubview:toolBar aboveSubview:self.tableView.superview];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedBtnEnable:) name:@"SELECTEDBTNSYATUS" object:nil];
    
    //打开menu数组文件
    self.menuDictArray = [[DocumentTool sharedDocumentTool] openContentsOfFile:@"foodMenu"];
    //self.tableView.contentSize = CGSizeMake(320, 170 * (self.menuDictArray.count+1));
    
    self.title = [NSString stringWithFormat:@"我的菜单(%d)", self.menuDictArray.count];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (Food *)foodAtIndexPath:(NSIndexPath *)indexPath
{
    self.menuDict = self.menuDictArray[(NSInteger)indexPath.section];
    self.food = [Food foddWithDict:_menuDict];
    NSLog(@"section:%d", indexPath.section);
    return self.food;
}

#pragma mark tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"count:%d", self.menuDictArray.count);
    return self.menuDictArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_menuDictArray.count == 0) {
        return 0;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFER forIndexPath:indexPath];
    if (!_cell) {
        _cell = [[MenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDENTIFER];
    }
    _cell.food = [self foodAtIndexPath:indexPath];
    //NSLog(@"%d", indexPath.section);
    _cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nemu_cell_bg"]];
    return _cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)selectedBtnEnable:(NSNotification *)info
{
    NSNumber *select = [info userInfo][@"selectedBtn"];
    self.cellBtnSelected = [select boolValue];
    //NSLog(@"%d", self.cellBtnSelected);
}


- (IBAction)btnClick:(UIButton *)sender{
    NSLog(@"ckklickkdfd");
}

- (void)selectedBtnClick:(UIButton *)sender {
    NSLog(@"ckklickkdfd");
    if (sender.isSelected) {
        sender.selected = NO;
    } else
        sender.selected = YES;
    //选中全选按钮，则将选择状态通知给menuCell的按钮
    NSDictionary *dict = @{@"selectedBtn": [NSNumber numberWithBool:sender.selected]};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SELECTEDALL" object:nil userInfo:dict];
    
    //NSLog(@"selectedBtnClick:%d", self.cellBtnSelected);
}
@end
