//
//  ViewController.m
//  表格图片下载
//
//  Created by Apple on 16/2/11.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "ZYHAppModal.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) NSArray *apps;
@end

@implementation ViewController
//懒加载
- (NSArray *)apps
{
    if(_apps==nil)
    {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"apps.plist" ofType:nil];
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArray=[NSMutableArray array];
        for(NSDictionary *dict in dictArray)
        {
            ZYHAppModal *modal=[ZYHAppModal appWithDict:dict];
            [tempArray addObject:modal];
        }
        _apps=tempArray;
    }
    return _apps;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.apps.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*idetifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:idetifier];
    ZYHAppModal *modal=self.apps[indexPath.row];
    cell.textLabel.text=modal.name;
    cell.detailTextLabel.text=modal.download;
    NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:modal.icon]];
    cell.imageView.image=[UIImage imageWithData:data];
    NSLog(@"正在下载中");
    return cell;
}
@end
