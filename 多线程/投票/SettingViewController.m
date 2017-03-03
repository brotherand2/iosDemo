//
//  SettingViewController.m
//  多线程
//
//  Created by Apple on 2016/11/26.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "SettingViewController.h"
#import "constant.h"
@interface SettingViewController ()
@property(nonatomic,strong) NSArray*files;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset=UIEdgeInsetsMake(22, 0, 0, 0);
    _files=@[@"new",@"vote"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return self.files.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    cell.textLabel.text=self.files[indexPath.row];
    cell.detailTextLabel.text=([self.files[indexPath.row] isEqualToString:@"new"])?@"800票":@"600票";
    cell.accessoryType=UITableViewCellAccessoryNone;
    if([self.files[indexPath.row] isEqualToString:voteFileName] )
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    
    [userDefault setObject:self.files[indexPath.row] forKey:self.title];
    voteFileName=self.files[indexPath.row];
    [userDefault synchronize];
    [self.tableView reloadData];
    NSString *path=[[NSBundle mainBundle]pathForResource:voteFileName ofType:@"json"];
    NSData *JSONData = [NSData dataWithContentsOfFile:path];
    NSDictionary *vote=[NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    phonenumbers=[NSMutableDictionary dictionaryWithDictionary:vote];
    keyIndex=[NSMutableArray array];
    [phonenumbers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [keyIndex addObject:key];
    }];
    groupNum=(phonenumbers.count+VotePerNum-1)/VotePerNum;
}

@end
