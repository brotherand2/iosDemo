//
//  ZYHHelpViewController.m
//  微博
//
//  Created by Apple on 16/2/6.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHHelpViewController.h"
#import "ZYHHtmlViewController.h"
#import "ZYHNavigationController.h"
#import "ZYHHtmlModal.h"
#import "ZYHItemGroup.h"
#import "ZYHSettingItem.h"
@interface ZYHHelpViewController ()
@property(nonatomic,strong) NSArray *htmls;
@end

@implementation ZYHHelpViewController
- (NSArray *)htmls
{
    if(_htmls==nil)
    {
       NSString *path= [[NSBundle mainBundle]pathForResource:@"help.json" ofType:nil];
        NSData *data=[NSData dataWithContentsOfFile:path];
        NSArray *htmlArray=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *tempArray=[NSMutableArray array];
        for(NSDictionary *dict in htmlArray)
        {
            ZYHHtmlModal *modal=[ZYHHtmlModal htmlWithDict:dict];
            [tempArray addObject:modal];
        }
        _htmls=tempArray;
    }
    return _htmls;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ZYHItemGroup *group=[[ZYHItemGroup alloc]init];
    NSMutableArray *items=[NSMutableArray array];
    for(ZYHHtmlModal *modal in self.htmls)
    {
        ZYHSettingItem *item=[ZYHSettingItem settingItemWithTitle:modal.title];
        [items addObject:item];
    }
    group.items=items;
    [self.data addObject:group];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYHItemGroup *group=self.data[indexPath.section];
    ZYHSettingItem *item=group.items[indexPath.row];
    ZYHHtmlModal *modal=self.htmls[indexPath.row];
    ZYHHtmlViewController *VC=[[ZYHHtmlViewController alloc]init];
    ZYHNavigationController *naVC=[[ZYHNavigationController alloc]initWithRootViewController:VC];
    VC.htmlModal=modal;
    [self presentModalViewController:naVC animated:YES];
}
@end
