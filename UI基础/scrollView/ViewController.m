//
//  ViewController.m
//  scrollView
//
//  Created by Apple on 15/11/26.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) UIImageView *imageView;
@property(nonatomic,strong)UIImage *image;
@property (weak, nonatomic) IBOutlet UIScrollView *imageScroll;
@end

@implementation ViewController
- (void)setImage:(UIImage *)image
{
    _image=image;
    self.imageView.image=image;//设置图像视图内容
    [self.imageView sizeToFit];//让图像视图根据图像自己调整大小
    self.imageScroll.contentSize=image.size;//告诉scrollview内部内容的实际大小
}
- (UIImageView *)imageView
{
    if(_imageView==nil)
    {
        _imageView=[[UIImageView alloc]init];
        [self.imageScroll addSubview:_imageView];
    }
    return _imageView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.image=[UIImage imageNamed:@"547115"];
    self.imageScroll.contentInset=UIEdgeInsetsMake(20,20,20,20);//设置边距
    
    self.imageScroll.showsHorizontalScrollIndicator=NO;
    self.imageScroll.showsVerticalScrollIndicator=NO;//不显示滚动条
    self.imageScroll.bounces=NO;//取消弹簧效果
    //偏移位置
    self.imageScroll.contentOffset=CGPointMake(220,200);
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.center=self.view.center;
    [self.imageScroll addSubview:btn];
    
    //self.imageScroll.contentSize=self.imageView.frame.size;
    self.imageScroll.delegate=self;
    self.imageScroll.maximumZoomScale=2;//最大的放大倍数
    
    
    
    self.imageScroll.minimumZoomScale=0.5;//最小的缩小倍数
}
/**
 *  返回被缩放的控件
 *
 *  @param scrollView <#scrollView description#>
 *
 *  @return <#return value description#>
 */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
@end
