//
//  ZYHMicroBlogCell.m
//  helloworld
//
//  Created by Apple on 15/12/1.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ZYHMicroBlogCell.h"
#include "ZYHMicroBlogData.h"
@implementation ZYHMicroBlogCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *idetifier=@"blog";
    ZYHMicroBlogCell *cell=[tableView dequeueReusableCellWithIdentifier:idetifier];
    if(cell==nil)
        cell=[[ZYHMicroBlogCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idetifier];
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UIImageView *headView=[[UIImageView alloc]init];
        [self.contentView addSubview:headView];
        self.headView=headView;
        
        UILabel *nameView=[[UILabel alloc]init];
        [self.contentView addSubview:nameView];
        self.nameView=nameView;
        
        UIImageView *vipView=[[UIImageView alloc]init];
        [self.contentView addSubview:vipView];
        self.vipView=vipView;
        
        UILabel *textView=[[UILabel alloc]init];
        [self.contentView addSubview:textView];
        self.textView=textView;
        self.textView.numberOfLines=0;//可以显示多行
        
        UIImageView *pictureView=[[UIImageView alloc]init];
        [self.contentView addSubview:pictureView];
        self.pictureView=pictureView;
     
    }
    return self;
}

- (void)setMicroBlogData:(ZYHMicroBlogData *)data
{
    self.headView.image=[UIImage imageNamed:data.icon];
    self.headView.frame=data.headViewFrame;
    
    self.nameView.text=data.name;
    self.nameView.frame=data.nameViewFrame;
    
    if(data.isVip)
    {
        self.vipView.image=[UIImage imageNamed:@"vip"];
        self.vipView.frame=data.vipViewFrame;
        self.vipView.hidden=NO;
    }
    else
        self.vipView.hidden=YES;
    
    
    self.textView.text=data.text;
    self.textView.frame=data.textViewFrame;
    
    if(data.picture)
    {
        self.pictureView.image=[UIImage imageNamed:data.picture];
        self.pictureView.frame=data.pictureViewFrame;
        self.pictureView.hidden=NO;
    }
    else
        self.pictureView.hidden=YES;
}
@end
