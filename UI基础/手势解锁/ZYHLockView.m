//
//  ZYHLockView.m
//  helloworld
//
//  Created by Apple on 16/1/28.
//  Copyright © 2016年 Apple. All rights reserved.
//
//测试当前线是否三点一线,是的话添加中间按钮
#define TestIsCanAddCenterBtn(firstTag,anotherTag,centerTag)  \
if ((firstTag==firstBtn.tag&&anotherTag==secondBtn.tag)||(anotherTag==firstBtn.tag&&firstTag==secondBtn.tag)) \
{ \
    UIButton *btn=self.subviews[centerTag]; \
    if (!btn.selected) { \
        btn.selected=YES; \
        [_selectedBtns addObject:btn]; \
    } \
} ;\


#import "ZYHLockView.h"
static int count;
@interface ZYHLockView()
@property(nonatomic,strong) NSMutableArray *selectedBtns;
@property(nonatomic,assign) CGPoint lastPoint;
@property(nonatomic,strong) UIColor *routeColor;
@end

@implementation ZYHLockView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        _selectedBtns=[NSMutableArray array];
        _routeColor=[UIColor greenColor];
        count=5;
        [self addBtns];
    }
    return self;
}


//所有的三点一线情况测试，测试每条线
- (void)testAllLinesisThreePointInALineWithFirstBtn:(UIButton*)firstBtn andSecondBtn:(UIButton*)secondBtn
{

    TestIsCanAddCenterBtn(0,2,1);//第1条横线
    TestIsCanAddCenterBtn(3,5,4);//第2条横线
    TestIsCanAddCenterBtn(6,8,7);//第3条横线
    TestIsCanAddCenterBtn(0,6,3);//第1条竖线
    TestIsCanAddCenterBtn(1,7,4);//第2条竖线
    TestIsCanAddCenterBtn(2,8,5);//第3条竖线
    TestIsCanAddCenterBtn(0,8,4);//左下斜线
    TestIsCanAddCenterBtn(2,6,4)//;右上斜线
}
- (void)addBtns
{
   
    for (NSInteger i=0; i<9; i++)
    {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag=i;
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        btn.userInteractionEnabled=NO;
        [self addSubview:btn];
    }
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=touches.anyObject;
    _lastPoint=[touch locationInView:self];
    CGFloat range=30;
    for(UIButton *btn in self.subviews)
    {
        CGRect rect=CGRectMake(btn.center.x-range/2, btn.center.y-range/2, range, range);
        if (CGRectContainsPoint(rect, _lastPoint)&&!btn.selected)
        {
            btn.selected=YES;
            UIButton *lastBtn=[_selectedBtns lastObject];
            if (lastBtn)
            {
                [self testAllLinesisThreePointInALineWithFirstBtn:lastBtn andSecondBtn:btn];//判断与上1个点是否三点一线，是的话添加中间点
            }
            [_selectedBtns addObject:btn];
            break;
        }
    }
    [self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSString *firstPwd=_pwd;
    NSMutableString *password=[NSMutableString string];
    for(UIButton *btn in _selectedBtns)
        [password appendString:[NSString stringWithFormat:@"%ld",btn.tag]] ;
    if (_showMessage)
    {
        if (_selectedBtns.count<4)
            _showMessage(@"最小连接4个点，请重新输入",NO);
        else
        {
            _pwd=password;//保存密码
            if (firstPwd)
            {
                if (![firstPwd isEqualToString:password])//密码不相等
                {
                    _pwd=firstPwd;//密码错误，恢复
                    if(_pwdState==ZYHStateSetPwd)
                      _showMessage(@"与上次绘制不一致，请重新绘制",NO);
                    else
                    {
                        count--;
                        if (count==0&&_finish)
                        {
                            _pwdState=ZYHStateError;
                            _finish(_pwd,_pwdState);
                            return;
                        }
                        NSString *tip=[NSString stringWithFormat:@"密码错了，还可输入%d次",count];
                        _showMessage(tip,NO);
                    }
                    _routeColor=[UIColor redColor];
                    [self setNeedsDisplay];//绘制错误路径
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        _routeColor=[UIColor greenColor];//恢复原来
                         [self recover];
                     });
                    return;
                }
                else
                {
                    if(_finish)
                     _finish(password,_pwdState);//二次密码一致，进行保存
                }
            }
            else
                _showMessage(@"再次绘制解锁图案",YES);
        }
    }
    
    [self recover];
}
//恢复，初始化
- (void)recover
{
    for(UIButton *btn in _selectedBtns)
        btn.selected=NO;
    [_selectedBtns removeAllObjects];
    [self setNeedsDisplay];

}
- (void)drawRect:(CGRect)rect
{
    if (_selectedBtns.count<=0) {
        return;
    }
    NSInteger i=0;
    UIBezierPath *path=[UIBezierPath bezierPath];
    for(UIButton *btn in _selectedBtns)
    {
        if (0==i) {
            [path moveToPoint:btn.center];
        }
        else
            [path addLineToPoint:btn.center];
        i++;
    }
    [path addLineToPoint:_lastPoint];
    path.lineWidth=8;
    path.lineCapStyle=kCGLineCapRound;
    path.lineJoinStyle=kCGLineJoinRound;
    [_routeColor set];
    [path stroke];
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat btnW=77;
    CGFloat screenW=[UIScreen mainScreen].bounds.size.width;
    CGFloat paddind=(screenW-3*btnW)/4;
    for (NSInteger i=0; i<self.subviews.count; i++) {
        UIButton *btn=self.subviews[i];
        NSInteger row=i/3;
        NSInteger column=i%3;
        CGFloat btnX=paddind+(paddind+btnW)*column;
        CGFloat btnY=paddind+(paddind+btnW)*row;
        btn.frame=CGRectMake(btnX, btnY, btnW, btnW);
        btn.userInteractionEnabled=NO;
    }
}
@end
