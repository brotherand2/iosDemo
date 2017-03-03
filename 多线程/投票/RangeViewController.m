//
//  RangeViewController.m
//  多线程
//
//  Created by Apple on VotePerNum16/11/28.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "RangeViewController.h"
#import "constant.h"
@interface RangeViewController ()
@property(nonatomic,strong) NSMutableArray *ranges;
@end

@implementation RangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset=UIEdgeInsetsMake(22, 0, 49, 0);
    _ranges=[NSMutableArray array];
    
    for(int i=0;i<groupNum;i++)
    {
        
        [_ranges addObject:[NSString stringWithFormat:@"第%d组:%d----%lu",i+1, i*VotePerNum+1,(unsigned long)((i==groupNum-1)?phonenumbers.count: (i+1)*VotePerNum)]];
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewWillAppear:(BOOL)animated
{
    _ranges=[NSMutableArray array];
    
    for(int i=0;i<groupNum;i++)
    {
        
        [_ranges addObject:[NSString stringWithFormat:@"第%d组:%d----%lu",i+1, i*VotePerNum+1,(unsigned long)((i==groupNum-1)?phonenumbers.count: (i+1)*VotePerNum)]];
    }
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.ranges.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.textLabel.text=self.ranges[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryNone;
    if(indexPath.row==rangeIndex)
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    rangeIndex=indexPath.row;
    
    [self.tableView reloadData];
}

@end
