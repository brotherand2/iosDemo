//
//  ZYHHeadView.m
//  微博
//
//  Created by Apple on 15/12/17.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ZYHHeadView.h"
#import "ZYHGroupFriend.h"
@implementation ZYHHeadView
//创建头部视图
+ (instancetype)headViewWithTableView:(UITableView *)tableView
{
    static NSString *identifier=@"headview";
    ZYHHeadView *headView=[tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if(headView==nil)
        headView=[[ZYHHeadView alloc]initWithReuseIdentifier:identifier];
    return  headView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if(self =[super initWithReuseIdentifier:reuseIdentifier])
    {
       //添加名称按钮
        UIButton *nameView=[[UIButton alloc]init];
        [self.contentView addSubview:nameView];
        self.nameView=nameView;
        [nameView setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];//设置按钮图片
        [self.nameView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//设置颜色
        self.nameView.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;//左对齐
        
        self.nameView.contentEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);//设置图片的边距
        //设置标题的边距
        self.nameView.titleEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
        self.nameView.imageView.contentMode=UIViewContentModeCenter;//设置图片居中显示，不拉伸
        
        self.nameView.imageView.clipsToBounds=NO;//图片边缘不切割
        [self.nameView addTarget:self action:@selector(nameViewClick) forControlEvents:UIControlEventTouchUpInside];//按钮被点击时，调用那个对象的那个方法
        
        //添加在线人数视图
        UILabel *onlineView=[[UILabel alloc]init];
        [self.contentView addSubview:onlineView];
        self.onlineView=onlineView;
       
    }
    return self;
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
    
    CGFloat onlineViewW=60;
    CGFloat onlineViewH=30;
    CGFloat onlineViewX=self.frame.size.width-10-onlineViewW;
    CGFloat onlineViewY=(self.frame.size.height-onlineViewH)*0.5;
    self.onlineView.frame=CGRectMake(onlineViewX, onlineViewY, onlineViewW, onlineViewH);
}
- (void)setGroupFriend:(ZYHGroupFriend *)groupFriend
{
    _groupFriend=groupFriend;
    [self.nameView setTitle:groupFriend.name forState:UIControlStateNormal];
    self.onlineView.text=[NSString stringWithFormat:@"%d/%ld",groupFriend.online,groupFriend.friends.count];
    if(self.groupFriend.isOpenGroup)//组是否展开
        self.nameView.imageView.transform=CGAffineTransformMakeRotation(M_PI_2);//设置旋转角度为90
    else
        self.nameView.imageView.transform=CGAffineTransformMakeRotation(0);
}

//图片视图被点击
- (void)nameViewClick
{
    //是否展开
    self.groupFriend.openGrup=!self.groupFriend.isOpenGroup;
    if([self.delegate respondsToSelector:@selector(headViewNameViewDidClik:)])//如果代理实现了这个方法
        [self.delegate headViewNameViewDidClik:self];
}


@end
