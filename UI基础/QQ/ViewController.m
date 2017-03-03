//
//  ViewController.m
//  QQ
//
//  Created by Apple on 15/12/15.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"
#include "ZYHMessage.h"
#include "ZYHMessageCell.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *inputView;
@property (nonatomic,strong) NSMutableArray *messages;
@property(nonatomic,strong)NSDictionary *replyDict;//自动回复的存档
@end

@implementation ViewController
//懒加载
- (NSArray *)messages
{
    if(_messages==nil)
    {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"messages.plist" ofType:nil];
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArray=[NSMutableArray array];
        for(NSDictionary *dict in dictArray)
        {
            ZYHMessage *message=[ZYHMessage messageWithDict:dict];
            ZYHMessage *lastMessage=[tempArray lastObject];
            if([lastMessage.time isEqualToString:message.time])
                message.hiddenTime=YES;
            [message calculateFrame];//计算消息占用的空间
            [tempArray addObject:message];
        }
        _messages=tempArray;
    }
    return _messages;
}
- (NSDictionary *)replyDict
{
    if(_replyDict==nil)
    {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"autoreply.plist" ofType:nil];
        _replyDict=[NSDictionary dictionaryWithContentsOfFile:path];
    }
    return _replyDict;
}
- (void)viewDidLoad {
 
    [super viewDidLoad];
    self.tableView.dataSource=self;//设置数据源，返回多少行、高度等
    self.tableView.delegate=self;//设置代理，即动作的处理
    self.tableView.backgroundColor=[UIColor colorWithRed:223.0/255.0 green:223.0/255.0 blue:223.0/255.0 alpha:1];//设置背景颜色,以显示白色的图片
    self.tableView.separatorStyle=UITableViewCellSelectionStyleNone;//去掉分割线
    self.tableView.allowsSelection=NO;//不能被选中
    // Do any additional setup after loading the view, typically from a nib.
    self.inputView.delegate=self;//编辑框的代理
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(KeyBoradFrameChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];//添加观察者，对任何编辑框的大小发生改变调用指定方法
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;//返回多少行信息
}
//格子的高度是多少
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYHMessage *message=self.messages[indexPath.row];
    return message.cellHeight;
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
//每个格子应该怎样返回
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYHMessageCell *cell=[ZYHMessageCell cellWithTableView:tableView];
    ZYHMessage *message=self.messages[indexPath.row];
    cell.message=message;
    return cell;
}
//监听到键盘变化调用的方法
-(void)KeyBoradFrameChanged:(NSNotification*)userInfo
{
    NSDictionary *keyBoardDict=userInfo.userInfo;//获取键盘信息
    CGRect keyBoardFrame=[keyBoardDict[UIKeyboardFrameEndUserInfoKey]CGRectValue];//返回键盘大小使用变化后的大小
    CGFloat change=keyBoardFrame.origin.y-[UIScreen mainScreen].bounds.size.height;//高度的变化值
    //设定tableview跟随键盘大小变化的动画
    CGFloat duration=[keyBoardDict[UIKeyboardAnimationDurationUserInfoKey]doubleValue];//获取键盘出现消失的动画时间
    [UIView animateWithDuration:duration animations:^{
        self.view.transform=CGAffineTransformMakeTranslation(0, change);//设置视图原点
    }];
}
//当开始挺拽时退出键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
//当键盘回车Return键被按下时
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self sendMessageWithText:textField.text andType:ZYHMessageTypeMe];//自己发生一条信息
    BOOL autoReply;//是否自动回复
    for(int i=0;i<textField.text.length;i++)
    {
        NSString *word=[textField.text substringWithRange:NSMakeRange(i, 1)];//取出每一个字
        if(self.replyDict[word])//如果字典中有对应的记录
        {
            autoReply=YES;
            [self sendMessageWithText:self.replyDict[word] andType:ZYHMessageTypeOther];//自动回复
            break;
        }
    }
    if(autoReply==NO)
        [self sendMessageWithText:@"滚" andType:ZYHMessageTypeOther];
    textField.text=nil;//清空文本框文字
    return YES;
}
- (void)sendMessageWithText:(NSString*)text andType:(ZYHMessageType)type
{
    ZYHMessage *message=[[ZYHMessage alloc]init];//增加的一条消息
    message.type=type;
    message.text=text;
    
    NSDate *now=[[NSDate alloc]init];//现在时间
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];//时间格式
    formatter.dateFormat=@"HH:mm";//设置时间格式
    message.time=[formatter stringFromDate:now];//返回格式化后的时间
    
    ZYHMessage *lastMessage=[self.messages lastObject];//返回上一条消息
    if([lastMessage.time isEqualToString:message.time])
        message.hiddenTime=YES;//时间相同不用显示
    [message calculateFrame];//计算消息的大小
    [self.messages addObject:message];//添加消息
    [self.tableView reloadData];//刷新数据，umberOfRowsInSection行数会增加，不刷新，消息增加返回行数不变，无法显示新数据
    NSIndexPath *lastIndex=[NSIndexPath indexPathForItem:self.messages.count-1 inSection:0];//返回最后一行索引
    [self.tableView scrollToRowAtIndexPath:lastIndex atScrollPosition:UITableViewScrollPositionBottom animated:YES];//滚动到最后一行
}
@end
