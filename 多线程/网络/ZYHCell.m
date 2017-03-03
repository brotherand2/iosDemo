//
// 文件名： ZYHCell.m
// 项目名： 多线程
// 创建者：Apple
// 日期时间 :16/2/18 21:18
// 版权：  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHCell.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
@interface ZYHCell()
@property (weak, nonatomic)UIView *slider;
@end

@implementation ZYHCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier=@"video";
    ZYHCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil)
        cell=[[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UIView *slider=[[UIView alloc]init];
        slider.backgroundColor=[UIColor lightGrayColor];
        slider.alpha=0.4;
        self.slider=slider;

        [self addSubview:slider];

    }
    return self;
}
- (void)setModal:(VideoModal *)modal
{
    _modal=modal;
    self.textLabel.text=modal.name;
    self.detailTextLabel.text=[NSString stringWithFormat:@"时长：%ld分钟",modal.length];
    NSString *urlStr=[NSString stringWithFormat:@"http://%@:8080/MJServer/%@",IPAdd, modal.imageName];
    [self.imageView setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"placeholder"]];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat padding=10;
    CGFloat imageH=self.height-padding*2;
    CGFloat imageW=imageH*200/112;
    self.imageView.frame=CGRectMake(padding, padding, imageW, imageH);
    self.textLabel.x=CGRectGetMaxX(self.imageView.frame)+20;
    self.detailTextLabel.x=self.textLabel.x;
    self.slider.frame=CGRectMake(0, self.height-1, self.width, 1);
}
@end
