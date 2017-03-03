

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (void)setMaxX:(CGFloat)maxX
{
    self.x = maxX - self.width;
}

- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

- (void)setMaxY:(CGFloat)maxY
{
    self.y = maxY - self.height;
}

- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}
- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}
- (CGSize)size
{
    return self.bounds.size;
}
- (void)setSize:(CGSize)size
{
    CGRect bounds=self.bounds;
    bounds.size=size;
    self.bounds=bounds;
    
}
- (CGPoint)origin
{
    return self.frame.origin;
}
- (void)setOrigin:(CGPoint)origin
{
    CGRect frame=self.frame;
    frame.origin=origin;
    self.frame=frame;
}
- (CGFloat)centerX
{
    return self.center.x;
}
 - (CGFloat)centerY
{
    return self.center.y;
}
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center=self.center;
    center.x=centerX;
    self.center=center;
}
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center=self.center;
    center.y=centerY;
    self.center=center;
}

- (BOOL)isShowingOnKeyWindow
{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}
+ (instancetype)viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
-(void)setBottomBorder
{
    [self setBottomBorder:[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1]];
}

-(void)setBottomBorder:(UIColor*)borderColor
{
    CALayer *borderLayerBottom = [CALayer layer];
    borderLayerBottom.frame = CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1);
    borderLayerBottom.backgroundColor = borderColor.CGColor;
    [self.layer addSublayer: borderLayerBottom];
}

-(void)setTopBorder:(UIColor*)borderColor
{
    CALayer *borderLayerBottom = [CALayer layer];
    borderLayerBottom.frame = CGRectMake(0, 0, self.frame.size.width, 1);
    borderLayerBottom.backgroundColor =borderColor.CGColor;
    [self.layer addSublayer: borderLayerBottom];

}

-(void)setTopBoder
{
    [self setTopBorder:[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1]];
}

-(void)setCornerRadius
{
    self.layer.cornerRadius=5;
    self.layer.masksToBounds=YES;
}
-(void)setCornerWithRadius:(NSInteger)radius
{
    self.layer.cornerRadius=radius;
    self.layer.masksToBounds=YES;
}
- (void)shakeStatus:(BOOL)enabled
{
    if (enabled)
    {
        CGFloat rotation = 0.03;//旋转弧度
        
        CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform"];
        shake.duration = 0.13;
        shake.autoreverses = YES;//动画结束时是执行逆动画
        shake.repeatCount  = MAXFLOAT;
        //用CABasicAnimation执行动画，在动画结束后会回归动画开始前的状态
        shake.removedOnCompletion = NO;// 动画终了后不返回初始状态
        shake.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform,-rotation, 0.0 ,0.0 ,1.0)];//绕 Z 轴旋转
        shake.toValue   = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, rotation, 0.0 ,0.0 ,1.0)];
        
        [self.layer addAnimation:shake forKey:@"shakeAnimation"];
    }
    else
    {
        [self.layer removeAnimationForKey:@"shakeAnimation"];
    }
}

@end
