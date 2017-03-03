//
//  ZYHHeadView.m
//  helloworld
//
//  Created by Apple on 15/11/29.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ZYHHeadView.h"
@interface ZYHHeadView()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *imageScroll;
@property (weak, nonatomic) IBOutlet UIPageControl *imageControl;
@property(strong,nonatomic)NSTimer *timer;



@end

@implementation ZYHHeadView
int photoCount=5;//图片个数
//NIB加载时被调用，用于初始化数据
- (void)awakeFromNib
{
    CGFloat imageViewY=0;
    CGFloat imageViewW=self.imageScroll.frame.size.width;
    CGFloat imageViewH=self.imageScroll.frame.size.height;
    for(int i=0;i<photoCount;i++)
    {
        UIImageView *imageView=[[UIImageView alloc]init];
        CGFloat imageViewX=i*imageViewW;
        imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
        [self.imageScroll addSubview:imageView];
        //[self.imageScroll insertSubview:imageView atIndex:0];
        NSString *imageName=[NSString stringWithFormat:@"ad_%02d",i];
        imageView.image=[UIImage imageNamed:imageName];
    }
    self.imageScroll.contentSize=CGSizeMake(imageViewW*photoCount, 0);//滚动视图大小
    self.imageScroll.pagingEnabled=YES;//允许分页
    self.imageControl.numberOfPages=photoCount;//页数
    self.imageScroll.delegate=self;
    self.imageScroll.showsHorizontalScrollIndicator=NO;
    self.imageScroll.showsVerticalScrollIndicator=NO;
    [self addTimer];

}
- (void)addTimer
{
    //1.5秒重复调用当前对象的nextImage方法
    self.timer=[NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    //消息循环中添加定时器消息
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}
- (void)nextImage
{
    NSInteger page=self.imageControl.currentPage;//页文件的当前页号
    page++;
    page%=photoCount;
    CGFloat scrollW=self.imageScroll.frame.size.width;
    
    CGPoint offset=CGPointMake(scrollW*page, 0);
    [self.imageScroll setContentOffset:offset];
     //[self.imageScroll setContentOffset:offset animated:YES];//设置偏移量，进行滚动
}
//滚动视图被拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
    self.timer=nil;//结束定时器
}
//滚动视图被拖拽结束
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];//重新添加定时器
}
//滚动视图被拖拽过程中
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset=scrollView.contentOffset;//获得滚动视图的偏移量
    CGFloat offsetX=offset.x;
    CGFloat scrollW=scrollView.frame.size.width;
    int page=(offsetX+0.5*scrollW)/scrollW;//当前页是否过半
    self.imageControl.currentPage=page;
    
}

@end
