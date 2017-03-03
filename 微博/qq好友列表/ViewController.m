//
//  ViewController.m
//  qq好友列表
//
//  Created by Apple on 15/12/16.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "ZYHFriendModel.h"
#import "ZYHFriendCell.h"
#import "ZYHGroupFriend.h"
#import "ZYHHeadView.h"
@interface ViewController ()<ZYHHeadViewDelegate>
@property(nonatomic,strong)NSArray *groupFirend;
@end

@implementation ViewController
//懒加载
- (NSArray *)groupFirend
{
    if(_groupFirend==nil)
    {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"friends.plist" ofType:nil];
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArray=[NSMutableArray array];
        for(NSDictionary *dict in dictArray)
        {
            ZYHGroupFriend *group=[ZYHGroupFriend groupWithDict:dict];
            [tempArray addObject:group];
        }
        _groupFirend=tempArray;
    }
    return _groupFirend;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.sectionHeaderHeight=60;//头部视图高度
    // Do any additional setup after loading the view, typically from a nib.
}

//隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
//返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ZYHGroupFriend *group=self.groupFirend[section];
    return group.isOpenGroup? group.friends.count:0;
    //return group.friends.count;
} 
//返回多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groupFirend.count;
}
//返回怎样的cell
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYHFriendCell *cell=[ZYHFriendCell cellWithTableView:tableView];
    ZYHGroupFriend *group=self.groupFirend[indexPath.section];
    ZYHFriendModel *friendModel=group.friends[indexPath.row];
    cell.friendModel=friendModel;
    return cell;
}
////返回每组的标题
//- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    ZYHGroupFriend *group=self.groupFirend[section];
//
//    return group.name;
//}
- (void)headViewNameViewDidClik:(ZYHHeadView *)headView
{
    [self.tableView reloadData];//图片按钮被点击后刷新重绘
}
//返回头部视图
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ZYHHeadView *headView=[ZYHHeadView headViewWithTableView:tableView];
    ZYHGroupFriend *groupFirend=self.groupFirend[section];
    headView.groupFriend=groupFirend;
    headView.delegate=self;
    return headView;
}
- (IBAction)clipTip:(UIButton *)sender {
}
@end
