//
//  ViewController.m
//  图片轮播器
//
//  Created by Apple on 15/11/27.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *imageControl;
@property(strong,nonatomic)NSTimer *timer;

- (IBAction)resumeGame:(UIButton *)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat imageViewY=0;
    CGFloat imageViewW=self.scrollView.frame.size.width;
    CGFloat imageViewH=self.scrollView.frame.size.height;
    for(int i=0;i<5;i++)
    {
        UIImageView *imageView=[[UIImageView alloc]init];
        CGFloat imageViewX=i*imageViewW;
        imageView.frame=CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
       [self.scrollView addSubview:imageView];
         //[self.scrollView insertSubview:imageView atIndex:0];
        NSString *imageName=[NSString stringWithFormat:@"img_%02d",i+1];
        imageView.image=[UIImage imageNamed:imageName];
    }
    self.scrollView.contentSize=CGSizeMake(imageViewW*5, 0);
    self.scrollView.pagingEnabled=YES;//设置分页，不能停在一半
    self.imageControl.numberOfPages=5;
    self.scrollView.delegate=self;
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.showsVerticalScrollIndicator=NO;//取消滚动条
    self.scrollView.bounces=NO;//取消弹簧效果
    [self.imageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];//分页控件值发生变化时调用
    [self addTimer];
 }
- (void)pageChanged:(UIPageControl*)page
{
   // NSLog(@"page=%ld",page.currentPage);
    CGFloat x=page.currentPage*self.scrollView.bounds.size.width;
    [self.scrollView setContentOffset:CGPointMake(x, 0) ];
    //[self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}
- (void)addTimer
{
       self.timer=[NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];

}
- (void)nextImage
{
    NSInteger page=(self.imageControl.currentPage+1)%5;
    self.imageControl.currentPage=page;
    [self pageChanged:self.imageControl];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
    self.timer=nil;
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}
//正在滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset=scrollView.contentOffset;
    CGFloat offsetX=offset.x;
    CGFloat scrollW=scrollView.frame.size.width;
    int page=(offsetX+0.5*scrollW)/scrollW;
    self.imageControl.currentPage=page;
    
}

- (IBAction)resumeGame:(UIButton *)sender {
}
@end
