//
//  ZYHContactTableViewController.m
//  helloworld
//
//  Created by Apple on 16/1/20.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHContactTableViewController.h"
#include "ZYHContactModal.h"
#import "ZYHAddContactViewController.h"
#import "ZYHEditViewController.h"
@interface ZYHContactTableViewController ()<UIActionSheetDelegate>
@property(nonatomic,strong) NSMutableArray *contacts;

@end

@implementation ZYHContactTableViewController
- (NSMutableArray *)contacts
{
    if(_contacts==nil)
    {
        _contacts=[NSMutableArray array];
    }
    return _contacts;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self readData];
    //NSLog(@"TABLE VIEW 要");
    UIBarButtonItem *delete=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(delete)];
    self.navigationItem.rightBarButtonItems=@[delete,self.navigationItem.rightBarButtonItem];
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2) {
        return UITableViewCellEditingStyleInsert;
    }
    else
        return UITableViewCellEditingStyleDelete;
}
- (void)delete
{
    self.tableView.editing=!self.tableView.editing;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[ZYHAddContactViewController class]]) {
        ZYHAddContactViewController *destinVC=segue.destinationViewController;
        __weak __typeof(self) vc=self;
        destinVC.addContact=^(ZYHContactModal *modal)
        {
            [vc.contacts addObject:modal];
            //[vc.tableView reloadData];
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:vc.contacts.count-1 inSection:0];
            [vc.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            [vc saveData];
        };
    }
    else
    {
        ZYHEditViewController *destinVC=segue.destinationViewController;
        
        NSInteger selectRow=[self.tableView indexPathForSelectedRow].row;
        destinVC.modal=self.contacts[selectRow];
        __weak __typeof(self) vc=self;
        destinVC.editContact=^(ZYHContactModal *modal)
        {
            //[vc.tableView reloadData];
            NSInteger row=[self.contacts indexOfObject:modal];
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:row inSection:0];
            [vc.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            [vc saveData];
        };
    }
}
- (void)saveData
{
    NSString *docPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *path=[docPath stringByAppendingPathComponent:@"contact.data"];
    //[self.contacts writeToFile:path atomically:YES];
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:path];
}
- (void)readData
{
    NSString *docPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *path=[docPath stringByAppendingPathComponent:@"contact.data"];
    self.contacts=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
}
- (IBAction)logout:(id)sender
{
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"是否注销账户" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"注销" otherButtonTitles:nil, nil ];
    [action showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)addContacts:(id)sender
{
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.contacts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contact" forIndexPath:indexPath];
    
    ZYHContactModal *modal=self.contacts[indexPath.row];
    cell.textLabel.text=modal.name;
    cell.detailTextLabel.text=modal.phone;
    return cell;
}
//有删除功能
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        [self.contacts removeObjectAtIndex:indexPath.row];
        NSIndexPath *deleteindexPath=[NSIndexPath indexPathForRow:indexPath.row inSection:0];
        
        [self. tableView deleteRowsAtIndexPaths:@[deleteindexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [self saveData];
    }
    else
    {
        u_int32_t phoneNumber=arc4random()%13750528276;
        //NSLog(@"phonenumber=%u",phoneNumber);
        ZYHContactModal *modal=[ZYHContactModal contactWithName:@"zyh" andPhone:[NSString stringWithFormat:@"%u",phoneNumber]];
        NSIndexPath *insertIndexPath=[NSIndexPath indexPathForRow:indexPath.row+1 inSection:0];
        [self.contacts insertObject:modal atIndex:indexPath.row+1];
        //NSLog(@"phonenumber=%u,row=%d",phoneNumber,indexPath.row);
        [self.tableView insertRowsAtIndexPaths:@[insertIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [self saveData];
    }
}

@end
