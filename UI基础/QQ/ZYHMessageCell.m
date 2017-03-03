//
//  ZYHMessageCell.m
//  helloworld
//
//  Created by Apple on 15/12/15.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ZYHMessageCell.h"
#import "UIImage+Extention.h"
@implementation ZYHMessageCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *idetifier=@"message";
    ZYHMessageCell *cell=[tableView dequeueReusableCellWithIdentifier:idetifier];//在回收队列中取回
    if(cell==nil)
        cell=[[ZYHMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idetifier];
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //添加时间标签
        UILabel *timeView=[[UILabel alloc]init];
        [self.contentView addSubview:timeView];
        self.timeView=timeView;
        timeView.textAlignment=NSTextAlignmentCenter;//文字居中
        
        //添加头像
        UIImageView *headView=[[UIImageView alloc]init];
        [self.contentView addSubview:headView];
        self.headView=headView;
        
        //添加正文
        UIButton *textView=[[UIButton alloc]init];
        [self.contentView addSubview:textView];
        self.textView=textView;
        textView.titleLabel.numberOfLines=0;//多行显示
        self.backgroundColor=[UIColor clearColor];//清空cell颜色，因为cell默认颜色为白色，会使白色图片看不到，tableview的背景色也被白色背景遮盖，clearcolor使cell透明，显示 出tableview颜色
        [textView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//设置文字颜色，因为默认颜色是白色，背景图片也是白色的，会使文字看不到
        textView.contentEdgeInsets=UIEdgeInsetsMake(textPadding, textPadding, textPadding, textPadding);//按钮的内容距离上左下右的边距
        textView.titleLabel.font=ZYHFONT;//设置字体大小，否则默认字体为17，用17号字体在按16号字体大小计算的空间显示，会增大垂直距离
    }
    return  self;
}
- (void)setMessage:(ZYHMessage *)message
{
    _message=message;
    //设置时间
    self.timeView.frame=message.timeF;
    self.timeView.text=message.time;
    //设置头像
    self.headView.frame=message.headF;
    self.headView.image=[UIImage imageNamed:(message.type==ZYHMessageTypeMe)?@"me":@"other"] ;
    //设置正文背景图片
    self.textView.frame=message.textF;
   [self.textView setTitle:message.text forState:UIControlStateNormal];
    UIImage *newImage=[UIImage resizableWithName:(message.type==ZYHMessageTypeMe)?@"chat_send_nor":@"chat_recive_nor"];
    
    [self.textView setBackgroundImage:newImage forState:UIControlStateNormal];

}

@end
