//
//  ZYHAppCell.m
//  微博
//
//  Created by Apple on 15/12/17.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ZYHAppCell.h"
#import "ZYHAppModal.h"
@interface ZYHAppCell()
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *downSizeView;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;

@property (weak, nonatomic) IBOutlet UILabel *nameView;

- (IBAction)downBtnClick:(UIButton *)btn;

@end
@implementation ZYHAppCell
//获取cell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier=@"app";
    ZYHAppCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil)
        cell=[[ZYHAppCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    return  cell;
}
- (void)setAppModal:(ZYHAppModal *)appModal
{
    _appModal=appModal;
    self.headView.image= [UIImage imageNamed:appModal.icon];
    self.nameView.text=appModal.name;
    self.downSizeView.text=[NSString stringWithFormat:@"大小%@|下载量%@",appModal.size,appModal.download];
    self.downBtn.enabled=!appModal.isDownLoaded;
    if(self.downBtn.enabled==NO)
        [self.downBtn  setTitle:@"已下载" forState:UIControlStateNormal];
    else
    {
        if(appModal.isDownLoaded)
            [self.downBtn  setTitle:@"正在下载" forState:UIControlStateNormal];
         else
             [self.downBtn  setTitle:@"下载" forState:UIControlStateNormal];
    }
}

- (void)downBtnClick:(UIButton *)btn
{
    if (self.appModal.isDownLoaded)//已在下载中，退出
    {
        return;
    }
    self.appModal.downloaded=YES;
    [btn setTitle:@"正在下载" forState:UIControlStateNormal];
    CGSize screenSize=[UIScreen mainScreen].bounds.size;
    UILabel *msgLabel=[[UILabel alloc]init];//创建一个标签，显示消息
    //设置frame
    CGFloat labelW=180;
    CGFloat labelH=30;
    CGFloat labelX=(screenSize.width-labelW)*0.5;
    CGFloat lavelY=(screenSize.height-labelH)*0.5;
    msgLabel.frame=CGRectMake(labelX, lavelY, labelW, labelH);
    msgLabel.text=[NSString stringWithFormat:@"正在下载%@",self.nameView.text];
    //NSLog(@"LABEL=%@",msgLabel.text);
    msgLabel.backgroundColor=[UIColor blackColor];
    [msgLabel setTextColor:[UIColor redColor]];
    msgLabel.alpha=0.0;

    msgLabel.textAlignment=NSTextAlignmentCenter;
    msgLabel.layer.cornerRadius=8;//圆角距离
    msgLabel.layer.masksToBounds=YES;//切掉多余部分,即圆角
    [self.superview.superview.superview addSubview:msgLabel];
     //superview第1个是contentview，第2个是tableview，第3个是主窗口
    /**
     *  animateWithDuration动画执行时间，animations执行动画操作，completion动画执行完成后操作
     */
    [UIView animateWithDuration:2 animations:^{
        msgLabel.alpha=0.6;
           }completion:^(BOOL finished)
    {//delay完成后多长时间开始新动画,UIViewAnimationOptionCurveLinear匀速
        [UIView animateWithDuration:2 delay:2 options:UIViewAnimationOptionCurveLinear animations:^{
            msgLabel.alpha=0;
        } completion:^(BOOL finished) {
            [msgLabel removeFromSuperview];
            self.downBtn.enabled=NO;
        }];
    }];
   
}
@end
