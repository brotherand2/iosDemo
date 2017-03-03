//
//  ScoreNoticeViewController.m
//  微博
//
//  Created by Apple on 16/2/5.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ScoreNoticeViewController.h"
#import "ZYHItemGroup.h"
#import "ZYHSettingItem.h"
@interface ScoreNoticeViewController ()
@property (weak, nonatomic)UITextField *textField;
@property(nonatomic,assign) BOOL isFirstTime;
@property (weak, nonatomic)UIDatePicker *datePicker;
@end

@implementation ScoreNoticeViewController
- (void)addGroupOne
{
    ZYHSettingItem *item1=[ZYHSettingItem settingItemWithTitle:@"提醒我关注比赛"];
    item1.itemType=ZYHItemSwitch;
    ZYHItemGroup *group=[[ZYHItemGroup alloc]init];
    group.items=@[item1];
    group.footTitle=@"当我关注的比赛比分发生变化时，通过小弹窗或推送进行提醒";
    [self.data addObject:group];

}
- (void)addGroupTwo
{
       __weak typeof(self) selfObj=self;
    ZYHSettingItem *item1=[ZYHSettingItem settingItemWithTitle:@"起始时间"];
    item1.itemType=ZYHItemLabel;
    item1.operation=^{
        selfObj.isFirstTime=YES;
        [selfObj.textField becomeFirstResponder];
    };
    ZYHSettingItem *item2=[ZYHSettingItem settingItemWithTitle:@"结束时间"];
    item2.itemType=ZYHItemLabel;
    item2.operation=^{
        selfObj.isFirstTime=NO;
        [selfObj.textField becomeFirstResponder];
        [UIView animateWithDuration:0.25 animations:^{
            selfObj.tableView.contentOffset=CGPointMake(0, 60);
        }];
    };
    ZYHItemGroup *group=[[ZYHItemGroup alloc]init];
    group.items=@[item1,item2];
    group.headTitle=@"只在以下时间接受比分直播";
    [self.data addObject:group];
}
- (void)setDateInput
{
    UITextField *field=[[UITextField alloc]init];
    _textField=field;
    UIDatePicker *datePicker=[[UIDatePicker alloc]init];
    _datePicker=datePicker;
    datePicker.datePickerMode=UIDatePickerModeTime;
    datePicker.locale=[NSLocale localeWithLocaleIdentifier:@"zh"];
    
    UIToolbar *toobar=[[UIToolbar alloc]init];
    toobar.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    UIBarButtonItem *tanhuang= [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *finish=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(valueChange)];
    toobar.backgroundColor=[UIColor grayColor];
    
    toobar.items=@[tanhuang, finish];
    field.inputAccessoryView=toobar;
    
    field.inputView=datePicker;
    [self.view addSubview:field];
    
}
- (void)valueChange
{
    NSDate *date=_datePicker.date;
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    format.dateFormat=@"HH:mm";
    NSString *newTime=[format stringFromDate:date];
    ZYHItemGroup *group=self.data[1];
    ZYHSettingItem *item=nil;
    NSIndexPath *indexPath=nil;
    if(self.isFirstTime)
    {
        item=group.items[0];
        indexPath=[NSIndexPath indexPathForRow:0 inSection:1];
    }
    else
    {
        item=group.items[1];
        indexPath=[NSIndexPath indexPathForRow:1 inSection:1];
        
    }

    item.labelText=newTime;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    [self.view endEditing:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addGroupOne];
    [self addGroupTwo];
    [self setDateInput];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

@end
