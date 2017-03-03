//
//  ViewController.m
//  汽车展示(模型嵌套模型)
//
//  Created by Apple on 15/11/28.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "GroupModel.h"
#import "CarModel.h"
@interface ViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray *groups;
@end

@implementation ViewController
- (NSArray *)groups
{
    if(_groups==nil)
    {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"cars_total.plist" ofType:nil];
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArray=[NSMutableArray array];
        for(NSDictionary *dict in dictArray)
        {
            GroupModel *group=[GroupModel groupWithDict:dict];
            [tempArray addObject:group];
        }
        _groups=tempArray;
    }
    return  _groups;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    GroupModel *group=self.groups[section];
    return group.cars.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier=@"car";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    GroupModel *group=self.groups[indexPath.section];
    CarModel *car=group.cars[indexPath.row];
    cell.imageView.image=[UIImage imageNamed:car.icon];
    cell.textLabel.text=car.name;
    return cell;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
#pragma mark --返回头部文字
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    GroupModel *group=self.groups[section];
    return group.title;
}
/**
 *  返回每组标题的索引
 *
 *  @param tableView <#tableView description#>
 *
 *  @return <#return value description#>
 */
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self.groups valueForKey:@"title"];
}
@end
