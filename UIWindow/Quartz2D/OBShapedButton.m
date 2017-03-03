/*
 Copyright (c) 2009 Ole Begemann
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

/*
 OBShapedButton.m
 
 Created by Ole Begemann
 October, 2009
 */

#import "OBShapedButton.h"
#import "UIImage+Extention.h"

/**
 *  按钮只在图片可见范围才可响应
 */
@interface OBShapedButton ()

@property (nonatomic, assign) CGPoint previousTouchPoint;//上一个触摸点
@property (nonatomic, assign) BOOL previousTouchHitTestResponse;//上一个触摸点是否可响应

- (void)resetHitTestCache;

@end


@implementation OBShapedButton

@synthesize previousTouchPoint = _previousTouchPoint;
@synthesize previousTouchHitTestResponse = _previousTouchHitTestResponse;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self resetHitTestCache];
    }
    return self;
}




- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        [self resetHitTestCache];
    }
    return self;
}


#pragma mark - Hit testing
////判断当前点在图片上是否可见
- (BOOL)isAlphaVisibleAtPoint:(CGPoint)point forImage:(UIImage *)image
{
    // Correct point to take into account that the image does not have to be the same size
    // as the button. See https://github.com/ole/OBShapedButton/issues/1
    CGSize iSize = image.size;//真实图片大小
    CGSize bSize = self.bounds.size;//缩放后的图片大小
    point.x *= (bSize.width != 0) ? (iSize.width / bSize.width) : 1;
    point.y *= (bSize.height != 0) ? (iSize.height / bSize.height) : 1;
    //根据缩放后的位置，按比例计算出点在原图像的位置
    //返回当前点上的像素颜色
    CGColorRef pixelColor = [[image colorAtPixel:point] CGColor];
    CGFloat alpha = CGColorGetAlpha(pixelColor);//返回指定颜色的alpha值
    return alpha >= kAlphaVisibleThreshold;//如果透明度大于0.1说明可见，让按钮可响应
}


// UIView uses this method in hitTest:withEvent: to determine which subview should receive a touch event.
// If pointInside:withEvent: returns YES, then the subview’s hierarchy is traversed; otherwise, its branch
// of the view hierarchy is ignored.
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event 
{
    // Return NO if even super returns NO (i.e., if point lies outside our bounds)
    BOOL superResult = [super pointInside:point withEvent:event];
    if (!superResult) {//判断当前点是否在自己窗口上
        return superResult;
    }

    // Don't check again if we just queried the same point
    // (because pointInside:withEvent: gets often called multiple times)
    if (CGPointEqualToPoint(point, self.previousTouchPoint))
    {//如果多次点击同一个位置，不处理，返回上一次的响应状态
        return self.previousTouchHitTestResponse;
    } else {
        self.previousTouchPoint = point;//保存当前点
    }
    
    // We can't test the image's alpha channel if the button has no image. Fall back to super.
    UIImage *buttonImage = [self imageForState:UIControlStateNormal];
    UIImage *buttonBackground = [self backgroundImageForState:UIControlStateNormal];

    BOOL response = NO;
    
    if (buttonImage == nil && buttonBackground == nil) {
        response = YES;//没有图片，进行响应
    }
    else if (buttonImage != nil && buttonBackground == nil)
    {//判断当前点在前景图片上是否可见，可见则响应
        response = [self isAlphaVisibleAtPoint:point forImage:buttonImage];
    }
    else if (buttonImage == nil && buttonBackground != nil)
    {//判断当前点在背景图片上是否可见，可见则响应
        response = [self isAlphaVisibleAtPoint:point forImage:buttonBackground];
    }
    else
    {//先判断当前点在前景图片上是否可见，可见则响应，不可见再判断背景图片
        if ([self isAlphaVisibleAtPoint:point forImage:buttonImage]) {
            response = YES;
        } else {
            response = [self isAlphaVisibleAtPoint:point forImage:buttonBackground];
        }
    }
    
    self.previousTouchHitTestResponse = response;//保存响应状态
    return response;
}


// Reset the Hit Test Cache when a new image is assigned to the button
- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self resetHitTestCache];
}

- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state
{
    [super setBackgroundImage:image forState:state];
    [self resetHitTestCache];
}
/**
 *  初始化
 */
- (void)resetHitTestCache
{
    //上一个触摸初始化为非常小的数 1.17549435e-38F.
    self.previousTouchPoint = CGPointMake(CGFLOAT_MIN, CGFLOAT_MIN);
    self.previousTouchHitTestResponse = NO;//上一个触摸点不响应
}

@end
