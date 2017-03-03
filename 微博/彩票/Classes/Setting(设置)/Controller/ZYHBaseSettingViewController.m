//
//  ZYHBaseSettingViewController.m
//  微博
//
//  Created by Apple on 16/2/5.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHBaseSettingViewController.h"
#import "ZYHItemGroup.h"
#import "ZYHSettingCell.h"
#import "ZYHSettingItem.h"
@interface ZYHBaseSettingViewController ()

@end

@implementation ZYHBaseSettingViewController
- (NSMutableArray *)data
{
    if(_data==nil)
    {
        _data=[NSMutableArray array];
    }
    return _data;
}
- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}
- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    ZYHItemGroup *group=self.data[section];
    
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     ZYHItemGroup *group=self.data[indexPath.section];
    ZYHSettingItem *item=group.items[indexPath.row];
    ZYHSettingCell *cell = [ZYHSettingCell cellWithTableView:tableView andItem:item];
     return cell;
}

- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    ZYHItemGroup *group=self.data[section];
    return group.footTitle;
}
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ZYHItemGroup *group=self.data[section];
    return group.headTitle;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYHItemGroup *group=self.data[indexPath.section];
    ZYHSettingItem *item=group.items[indexPath.row];
    if (item.operation) {
        item.operation();
    }
    else if (item.vcClass)
    {
        UIViewController *vc=[[item.vcClass alloc]init];
        vc.title=item.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
