//
//  ZYHFootView.m
//  helloworld
//
//  Created by Apple on 16/2/2.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHFootView.h"

@implementation ZYHFootView
//创建头部视图
+ (instancetype)headViewWithTableView:(UITableView *)tableView
{
    static NSString *identifier=@"headview";
    ZYHFootView *headView=[tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if(headView==nil)
        headView=[[ZYHFootView alloc]initWithReuseIdentifier:identifier];
    return  headView;
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if(self =[super initWithReuseIdentifier:reuseIdentifier])
    {
        //添加名称按钮
        ZYHButton *nameView=[[ZYHButton alloc]init];
        [self.contentView addSubview:nameView];
        //self.nameView.contentEdgeInsets=UIEdgeInsetsMake(0, 20, 0, 0);//设置图片的边距
        //设置标题的边距
        //nameView.titleEdgeInsets=UIEdgeInsetsMake(-60, -20, 0, 0);
        self.nameView=nameView;
        [nameView addTarget:self action:@selector(BtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.nameView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//设置颜色
        //self.nameView.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;//左对齐
//        self.nameView.imageView.contentMode=UIViewContentModeCenter;//设置图片居中显示，不拉伸
//        
//        self.nameView.imageView.clipsToBounds=NO;//图片边缘不切割
    }
    return self;
}
- (void)BtnClick
{
    if (self.btnClick) {
        _btnClick();
    }
}
//当当前视图的大小值发生时候就会调用这个方法
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat nameViewX=0;
    CGFloat nameViewY=0;
    CGFloat nameViewW=self.frame.size.width;
    CGFloat nameViewH=self.frame.size.height;
    self.nameView.frame=CGRectMake(nameViewX, nameViewY, nameViewW, nameViewH);
}
- (void)setModal:(GirlModal *)modal
{
    _modal=modal;
    [self.nameView setTitle:modal.titileName forState:UIControlStateNormal];
    [self.nameView setImage:[UIImage imageNamed:modal.imageName] forState:UIControlStateNormal];
}
@end
