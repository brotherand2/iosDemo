//
//  ViewController.m
//  抽屉效果
//
//  Created by Apple on 16/1/25.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic)UIView *mainView;
@property (weak, nonatomic)UIView *leftView;
@property (weak, nonatomic)UIView *rightView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addCildController];
    [self.mainView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (_mainView.frame.origin.x<0) {
        _leftView.hidden=YES;
        _rightView.hidden=NO;
    }
     else if(_mainView.frame.origin.x>0)
    {
        _leftView.hidden=NO;
        _rightView.hidden=YES;
    }
}
- (void)addCildController
{
    UIView *mainView=[[UIView alloc]initWithFrame:self.view.bounds];
    [mainView setBackgroundColor:[UIColor redColor]];
    self.mainView=mainView;
    UIView *leftView=[[UIView alloc]initWithFrame:self.view.bounds];
    [leftView setBackgroundColor:[UIColor greenColor]];
    self.leftView=leftView;
    UIView *rightView=[[UIView alloc]initWithFrame:self.view.bounds];
    [rightView setBackgroundColor:[UIColor blueColor]];
    self.rightView=rightView;
    
    [self.view addSubview:leftView];
    [self.view addSubview:rightView];
    [self.view addSubview:mainView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    CGPoint current=[touch locationInView:nil];
    CGPoint previous=[touch previousLocationInView:nil];
    CGFloat offsetX=current.x-previous.x;
    //NSLog(@"%ld",(long)offsetX);
    self.mainView.frame=[self getCurrentFrameWithOffsetX:offsetX];
}
#define maxY 60
- (CGRect)getCurrentFrameWithOffsetX:(CGFloat)offsetX
{
    CGRect frame=self.mainView.frame;
    CGFloat screenX=[UIScreen mainScreen].bounds.size.width;
    CGFloat offsetY=offsetX*60/screenX;
    CGFloat scale;
    if (frame.origin.x>=0) {
        scale=(frame.size.height-2*offsetY)/frame.size.height;
        frame.origin.y+=offsetY;
        frame.size.height-=offsetY*2;
    }
    else
    {
        scale=(frame.size.height+2*offsetY)/frame.size.height;
       frame.origin.y-=offsetY;
        frame.size.height+=offsetY*2;
    }
    frame.origin.x+=offsetX;
    
    frame.size.width*=scale;
    
    return frame;
}
#define padding 80
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGFloat screenW=[UIScreen mainScreen].bounds.size.width;
    BOOL isMove=NO;
    CGFloat frameX = 0.0;
    if (_mainView.frame.origin.x>=screenW*0.5) {
        isMove=YES;
        frameX=screenW-padding;
    }
    else if (CGRectGetMaxX(_mainView.frame)<screenW*0.5)
    {
            isMove=YES;
            frameX=padding-_mainView.frame.size.width;
           NSLog(@"frame=%@",NSStringFromCGRect(_mainView.frame));
    }
    [UIView animateWithDuration:0.25 animations:^{
        if (isMove) {
            CGFloat offsetX=frameX-_mainView.frame.origin.x;
            NSLog(@"%ld",(long)offsetX);
            _mainView.frame=[self getCurrentFrameWithOffsetX:offsetX];
        }
        else
            _mainView.frame=[UIScreen mainScreen].bounds;
    }];
   
}
@end
