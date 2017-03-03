//
//  ViewController.m
//  团购
//
//  Created by Apple on 15/11/28.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "GroupBuy.h"
#import "ZYHCellTableViewCell.h"
#import "ZYHFootView.h"
#import "ZYHHeadView.h"
@interface ViewController ()<UITableViewDataSource,ZYHFootViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic)NSMutableArray *groupBuy;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.rowHeight=80;
    ZYHFootView *loadView=[[[NSBundle mainBundle]loadNibNamed:@"ZYHFootView" owner:nil options:nil]lastObject];
    loadView.delegate=self;
    ZYHHeadView *headView=[[[NSBundle mainBundle]loadNibNamed:@"ZYHHeadView" owner:nil options:nil]lastObject];
    CGFloat width=headView.bounds.size.width;
    CGFloat height=headView.bounds.size.height;
    CGFloat marginX=([UIScreen mainScreen].bounds.size.width-width)*0.5;
    headView.frame=CGRectMake(marginX, 0, width,height);
    self.tableView.tableFooterView=loadView;
    self.tableView.tableHeaderView=headView;
}

- (NSArray *)groupBuy
{
    if(_groupBuy==nil)
    {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"tgs.plist" ofType:nil];
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArray=[NSMutableArray array];
        for(NSDictionary *dict in dictArray)
        {
            GroupBuy *group=[GroupBuy groupWithDict:dict];
            [tempArray addObject:group];
        }
        _groupBuy=tempArray;
    }
    return _groupBuy;
}
- (void)footerViewLoadDidClick:(ZYHFootView *)footerView
{
    GroupBuy *group=[[GroupBuy alloc]init];
    group.title=@"米饭";
    group.price=@"2";
    group.buyCount=@"1";
    group.icon=@"2c97690e72365e38e3e2a95b934b8dd2";
    [self.groupBuy addObject:group];
    [self.tableView reloadData];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.groupBuy.count-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groupBuy.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idefifier=@"groupBuy";
    ZYHCellTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:idefifier];
    if(cell==nil)
    {
        //cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idefifier];
        cell=[[[NSBundle mainBundle]loadNibNamed:@"ZYHCell" owner:nil options:nil]lastObject];
    }
    GroupBuy *group=self.groupBuy[indexPath.row];
//    cell.imageView.image=[UIImage imageNamed:group.icon];
//    cell.textLabel.text=[NSString stringWithFormat:@"$%@    已经购买%@",group.price,group.buyCount];
    //UIImageView *headView=(UIImageView*)cell.contentView.subviews[0];
    //headView.image=[UIImage imageNamed:group.icon];
    cell.group=group;
    return  cell;
}

@end
