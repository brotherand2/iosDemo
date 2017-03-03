//
//  ViewController.m
//  手势Touch
//
//  Created by Apple on 16/2/3.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CGFloat screenW,screenH;
}
@property (weak, nonatomic)UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGSize rect=[UIScreen mainScreen].bounds.size;
    screenW=rect.width;
    screenH=rect.height;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 80, 80)];
    _imageView=imageView;
    imageView.userInteractionEnabled=YES;
    imageView.image=[UIImage imageNamed:@"2.Assistive Touch"];
    [self.view addSubview:imageView];
    UIPanGestureRecognizer *panGesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGetsture:)];
    [imageView addGestureRecognizer:panGesture];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)panGetsture:(UIPanGestureRecognizer*)pan
{
    CGPoint movePoint=[pan translationInView:_imageView];
    _imageView.transform=CGAffineTransformTranslate(_imageView.transform, movePoint.x, movePoint.y);
    [pan setTranslation:CGPointZero inView:_imageView];
    if(pan.state==UIGestureRecognizerStateEnded)
    {
        CGFloat padding=10;
        CGFloat orginX=_imageView.frame.origin.x;
        CGFloat orginY=_imageView.frame.origin.y;
        CGFloat imageW=_imageView.bounds.size.width;
        CGFloat imageH=_imageView.bounds.size.height;
        CGFloat imageNewX,imageNewY;
        imageNewY=orginY;
        if(orginY<60)
        {
            if(orginX<screenW*0.5)
            {
                imageNewX=orginX<padding?padding:orginX;
            }
            else
                imageNewX=orginX>screenW-padding-imageW?screenW-padding-imageW:orginX;
            imageNewY=padding;

        }
        else if(orginY+imageH>screenH-60)
        {
            if(orginX<screenW*0.5)
            {
                imageNewX=orginX<padding?padding:orginX;
            }
            else
                imageNewX=orginX>screenW-padding-imageW?screenW-padding-imageW:orginX;
            imageNewY=screenH-padding-imageH;
        }
        else
        {
            imageNewX=orginX<screenW*0.5?padding:screenW-padding-imageW;
        }
        _imageView.frame=CGRectMake(imageNewX, imageNewY, imageW, imageH);

    }

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
