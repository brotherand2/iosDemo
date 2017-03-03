//
//  ViewController.m
//  LOL人物展示
//
//  Created by Apple on 15/11/28.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"
#include "HeroModel.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong,nonatomic)NSMutableArray *heros;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.rowHeight=60;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.separatorColor=[UIColor redColor];
    UIView *redView=[[UIView alloc]init];
    redView.backgroundColor=[UIColor colorWithRed:34/255.0 green:124.0/255.0 blue:183/255.0 alpha:0.6];
    redView.frame=CGRectMake(0, 0, 80, 80);
    self.tableView.tableHeaderView=redView;
    
    UIView *blueView=[[UIView alloc]init];
    blueView.backgroundColor=[UIColor colorWithRed:144/255.0 green:124.0/255.0 blue:183/255.0 alpha:0.16];
    blueView.frame=CGRectMake(80, 0, 80, 30);
    self.tableView.tableFooterView=blueView;
    self.tableView.editing=YES;
}

- (NSArray *)heros
{
    if(_heros==nil)
    {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"heros.plist" ofType:nil];
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArray=[NSMutableArray array];
        for(NSDictionary *dict in dictArray)
        {
            HeroModel *hero=[HeroModel heroWithDict:dict];
            [tempArray addObject:hero];
        }
        _heros=tempArray;
    }
    return  _heros;
}
- (IBAction)clearPainter:(id)sender {
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.heros.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"hero";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    HeroModel *hero=self.heros[indexPath.row];
    cell.textLabel.text=hero.name;
    cell.imageView.image=[UIImage imageNamed:hero.icon];
    cell.detailTextLabel.text=hero.intro;
    //cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    //cell.backgroundColor=[UIColor blueColor];
    
    UIView *blueView=[[UIView alloc]init];
    blueView.backgroundColor=[UIColor colorWithRed:234/255.0 green:24.0/255.0 blue:183/255.0 alpha:0.6];
    
    blueView.frame=CGRectMake(100,20,70,30);
    //cell.backgroundView=blueView;
    //cell.accessoryView=blueView;
    cell.selectedBackgroundView=blueView;
    return cell;
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
//返回每1行的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        return  100;
    }else
    {
        return 60;
    }
}
#pragma mark ---当选中某一行时调用这个方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"修改名称" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag=indexPath.row;
    alertView.alertViewStyle=UIAlertViewStylePlainTextInput;//样式中添加输入框
    UITextField *textField=[alertView textFieldAtIndex:0];
    HeroModel *hero=self.heros[indexPath.row];
    textField.text=hero.name;//在输入模型显示当前的英雄名
    [alertView show];
}
//提示框被选择
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)//选择确定
    {
        HeroModel *hero=self.heros[alertView.tag];
        hero.name=[alertView textFieldAtIndex:0].text;
        //[self.tableView reloadData];
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:alertView.tag inSection:0];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationLeft];//更新当前行格子
    }
    else
        NSLog(@"YOU CLIK CANCEL");
}
//只要实现此方法就有手势拖拽删除按钮
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle==UITableViewCellEditingStyleDelete)
    {
        NSLog(@"Delete");
        [self.heros removeObjectAtIndex:indexPath.row];
       // [self.tableView reloadData];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
    else if(editingStyle==UITableViewCellEditingStyleInsert)
    {
        NSLog(@"Insert");
        HeroModel *model=[[HeroModel alloc]init];
        model.name=@"曾勇华";
        model.icon=@"xjd";
        model.intro=@"真英雄";
        [self.heros insertObject:model atIndex:indexPath.row+1];
        NSIndexPath *path=[NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
        [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationRight];
    }
}
//返回编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row%2)
    return UITableViewCellEditingStyleInsert;
    else
        return UITableViewCellEditingStyleDelete;
}
//此方法，就可以拖动控件移动
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    id source=self.heros[sourceIndexPath.row];
    [self.heros removeObjectAtIndex:sourceIndexPath.row];
    [self.heros  insertObject:source atIndex:destinationIndexPath.row];
   // [self.heros exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
}
@end





