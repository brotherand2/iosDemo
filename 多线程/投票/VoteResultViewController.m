//
//  VoteResultViewController.m
//  多线程
//
//  Created by Apple on 2016/11/26.
//  Copyright © 2016年 Apple. All rights reserved.
//
/*
#import "UIColor+extention.h"
#import "VoteResultViewController.h"
#import "constant.h"
@interface VoteResultViewController ()
@property(nonatomic,strong) NSMutableArray *colors;
@property(nonatomic,strong) UIColor *errorColor;
@end

@implementation VoteResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset=UIEdgeInsetsMake(22, 0, 49, 0);
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _colors=[NSMutableArray array];
    for(int i=0;i<groupNum;i++)
        [_colors addObject:[UIColor randomColorWithAlpha]];
    _errorColor=[UIColor randomColorWithAlpha];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    
    [self.tableView reloadData];
}
#pragma 返回怎样的头部文字
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return [NSString stringWithFormat:@"第%ld组",section+1];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  groupNum;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==groupNum-1)
       return phonenumbers.count-section*VotePerNum;
    else
        return VotePerNum;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //cell.textLabel.text=@"1234";
    NSInteger section=indexPath.section;
    NSDictionary *group=voteds[@(section)];
    NSString *key=keyIndex[indexPath.section*VotePerNum+indexPath.row];
    NSString *value=nil;
    cell.backgroundColor=_colors[indexPath.section];
    if(group&&group[key])
        value=group[key];
    else
        cell.backgroundColor=_errorColor;
    cell.textLabel.text=[NSString stringWithFormat:@"%@----%@",key,value?value:@"暂未投票"] ;
    return  cell;
}
//添加索引栏标题数组
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *resultArray =[NSMutableArray array];
    for (int i=1;i<=groupNum;i++) {
        [resultArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    return resultArray;
}
 */
#import "VoteResultViewController.h"
#import "constant.h"
@interface VoteResultViewController ()
@property(nonatomic,strong) NSArray *keys;
@end

@implementation VoteResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.keys=companys.allKeys;
    self.tableView.contentInset=UIEdgeInsetsMake(22, 0, 0, 0);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.keys.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.textLabel.text=self.keys[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryNone;
    if([companyIndex isEqualToString:self.keys[indexPath.row]])
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    companyIndex=self.keys[indexPath.row];
    [self.tableView reloadData];
}



@end
