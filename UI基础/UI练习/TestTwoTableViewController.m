//
//  TestTwoTableViewController.m
//  helloworld
//
//  Created by Apple on 16/2/1.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "TestTwoTableViewController.h"
#import "GirlModal.h"

#import "ZYHFootView.h"
@interface TestTwoTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSArray *girls;

@end

@implementation TestTwoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.rowHeight=100;
    self.tableView.sectionHeaderHeight=60;//头部视图高度
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//懒加载
- (NSArray *)girls
{
    if(_girls==nil)
    {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"Data.plist" ofType:nil];
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArray=[NSMutableArray array];
        for(NSDictionary *dict in dictArray)
        {
            GirlModal *girl=[GirlModal girlWithDict:dict];
            [tempArray addObject:girl];
        }
        _girls=tempArray;
    }
    return _girls;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
   

    return self.girls.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
     GirlModal *modal= self.girls[section];
    return modal.isOpen?1:0;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GirlModal *modal= self.girls[indexPath.section];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier=@"friend";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil)
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.textLabel.text=@"hello zyh!!!";
    cell.imageView.image=[UIImage imageNamed:@"泡妞宝典"];
    return  cell;

}
//- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"ss";
//}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    ZYHFootView *cell=[ZYHFootView headViewWithTableView:tableView];
    GirlModal *modal= self.girls[section];
    cell.modal=modal;
    __weak typeof(self) selfVc=self;
    cell.btnClick=^()
    {
        modal.isOpen=!modal.isOpen;
        [selfVc.tableView reloadData];
    };
    return cell;

}
- (void)btnClick
{
    NSLog(@"click");
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
