//
//  CompanyViewController.m
//  network
//
//  Created by Apple on 2016/12/6.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "CompanyViewController.h"
#import "constant.h"
@interface CompanyViewController ()
@property(nonatomic,strong) NSArray *keys;
@end

@implementation CompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.keys=companys.allKeys;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
/*
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
    cell.textLabel.text=companys[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryNone;
    if([companyIndex isEqualToString:self.keys[indexPath.row]])
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    
    [userDefault setInteger:indexPath.row forKey:self.title];
    timeIndex=indexPath.row;
    [userDefault synchronize];
    [self.tableView reloadData];
}
*/
@end
