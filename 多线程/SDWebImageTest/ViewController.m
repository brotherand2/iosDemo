//
//  ViewController.m
//  表格图片下载（无沙盒）
//
//  Created by Apple on 16/2/11.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "ZYHAppModal.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSArray *apps;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

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
    static NSString*identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    ZYHAppModal *modal=self.apps[indexPath.row];
    cell.textLabel.text=modal.name;
    cell.detailTextLabel.text=modal.download;
    [cell.imageView sd_setImageWithURL:modal.icon placeholderImage:[UIImage imageNamed:@"user_default"]];
    return cell;
}
@end
