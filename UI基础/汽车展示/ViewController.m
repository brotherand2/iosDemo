//
//  ViewController.m
//  汽车展示
//
//  Created by Apple on 15/11/28.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "CarGroup.h"
@interface ViewController ()<UITableViewDataSource>
@property(nonatomic,strong)NSArray *carGroups;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController
- (NSArray *)carGroups
{
    if(_carGroups==nil)
    {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"cars_simple.plist" ofType:nil];
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArray=[NSMutableArray array];
        for(NSDictionary *dict in dictArray)
        {
            CarGroup *carGroup=[CarGroup carGroupWithDict:dict];
            [tempArray addObject:carGroup];
        }
        _carGroups=tempArray;
    }
    return _carGroups;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.dataSource=self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.carGroups.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CarGroup *carGroup=self.carGroups[section];
    return carGroup.cars.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    //cell.textLabel.text=@"1234";
    CarGroup *carGroup=self.carGroups[indexPath.section];
    cell.textLabel.text=carGroup.cars[indexPath.row];
    return  cell;
}
- (IBAction)save:(id)sender {
}
#pragma 返回怎样的头部文字
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CarGroup *carGroup=self.carGroups[section];
    return carGroup.title;
}
#pragma - 返回怎样的尾部文字
- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    CarGroup *carGroup=self.carGroups[section];
    return carGroup.desc;

}
@end
