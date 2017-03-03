//
//  ViewController.m
//  应用管理
//
//  Created by Apple on 15/12/17.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "ZYHAppModal.h"
#import "ZYHAppCell.h"
@interface ViewController ()
@property(nonatomic,strong)NSArray*apps;
@end

@implementation ViewController
//懒加载
- (NSArray *)apps
{
    if(_apps==nil)
    {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"apps_full.plist" ofType:nil];
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArray=[NSMutableArray array];
        for(NSDictionary *dict in dictArray)
        {
            ZYHAppModal *app=[ZYHAppModal appWithDict:dict];
            [tempArray addObject:app];
        }
        _apps=tempArray;
    }
    return _apps;
}
- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    return self.apps.count;
}
//返回怎样的cell
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYHAppCell *cell=[ZYHAppCell cellWithTableView:tableView];
    ZYHAppModal *appModal=self.apps[indexPath.row];
    cell.appModal=appModal;
    return cell;
}

@end
