//
//  ZYHDrawView.m
//  UIWindow
//
//  Created by Apple on 16/1/27.
//  Copyright © 2016年 Apple. All rights reserved.
//
#import "ZYHLayer.h"
#import "ZYHDrawView.h"
#import "UIColor+extention.h"
#import "ZYHCircleImageView.h"
#import "UIImage+Extention.h"
@interface ZYHDrawView()
@property(nonatomic,assign) CGPoint firstPoint,lastPoint;
@end

@implementation ZYHDrawView
#define leftMargin 40
#define ballonDelta 50

- (UIImage *)image
{
    if (_image==nil) {
        _image=[UIImage imageNamed:@"sandyBalloon"];
    }
    return _image;
}
- (NSMutableArray *)locations
{
    if (nil==_locations) {
        _locations=[NSMutableArray array];
        NSInteger count=6;
       
        for (NSInteger i=0; i<count; i++) {
            CGPoint pt=CGPointMake(leftMargin+ballonDelta*i, self.frame.size.height);
            [_locations addObject:[NSValue valueWithCGPoint:pt]];
        }
    }
    return _locations;
}
- (void)drawRect:(CGRect)rect
{
    context=UIGraphicsGetCurrentContext();
    switch (self.tag) {
        case 0:
            [self rectangleOperation];
            break;
        case 1:
            [self clipImage];
            break;
        case 2:
            [self drawBallon];
            break;
        case 3:
            [self uikitTest];
            break;
        case 4:
            [self imitateUIImageView];
            break;
        case 5:
            [self drawWaterImage];
            break;
        case 6:
            [self clip];
            break;
        case 7:
            [self drawPillar];
            break;
        case 8:
            [self backgroundPattern];
            break;
        case 9:
            //[self systemInfo];
            [self clipImage2];
            break;
        case 10:
            [self drawShadow];
            break;
        case 11:
            [self layerTest];
            break;
        case 13:
            [self myLayer];
            break;
//        case 23:
//            [self drawBack:rect];
//            break;
        default:
            break;
    }
}
//矩阵变换
- (void)rectangleOperation
{
    NSLog(@"TEST");
    
    [[UIColor randomColor]set];
    CGContextSaveGState(context);
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 200, 200);//设置坐标原点
    CGContextAddEllipseInRect(context, CGRectMake(-100, -100, 200, 200));
    
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    CGContextScaleCTM(context, 2, 2);//设置缩放比例
    CGContextAddRect(context, CGRectMake(100, 200, 100, 100));
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGPoint point[3]={{50,200},{300,200},{175,400}};
    
    CGContextAddLines(context, point, 2);
    CGContextStrokePath(context);
    //旋转
    // 负数 逆时针/ 正数 顺时针
    // 围绕左上角(0,0) 旋转
    CGContextRotateCTM(context, -M_PI_4);
    CGContextAddLines(context, point, 3);
    CGContextClosePath(context);
    CGContextAddRect(context, CGRectMake(50, 200, 250,30));
    CGContextStrokePath(context);
}
//裁剪图片
- (void)clipImage
{
    CGRect rect=CGRectMake(100, 100, 200, 200);
    //self.frame=rect;
    UIBezierPath *path=[UIBezierPath bezierPathWithOvalInRect:rect];
    
    //[path setLineWidth:13];
    [[UIColor blueColor]set];
    //[path add]
    CGContextSetLineWidth(context, 4);
    CGContextAddPath(context, path.CGPath);
    CGContextClip(context);
    CGContextStrokePath(context);
    UIImage *image=[UIImage imageNamed:@"489101"];
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
   }


- (void)clip
{
    UIImageView *imageView=[[UIImageView alloc]init];
    CGRect frame=imageView.frame;
    frame.origin=CGPointMake(100, 110);
    imageView.frame=frame;
    imageView.image=[UIImage circleImageWithImageName:@"scene" borderWidth:4 borderColor:[UIColor randomColor]];
    [imageView sizeToFit];
    [self addSubview:imageView];

}
//绘制气球

- (void)drawBallon
{
    if (_timer==nil) {
        _timer=[CADisplayLink displayLinkWithTarget:self selector:@selector(setNeedsDisplay)];
        [_timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        //// CADisplayLink 定时器 一秒执行60次
    }
    for (NSInteger i=0; i<self.locations.count; i++) {
        CGPoint point=[self.locations[i] CGPointValue];
        point.y-=(arc4random_uniform(10)+1)*0.5;
        if (point.y+[self.image size].height<0) {
            point.y=self.frame.size.height;
        }
        [self.locations replaceObjectAtIndex:i withObject:[NSValue valueWithCGPoint:point]];
        [_image drawAtPoint:point];
    }
}
- (void)uikitTest
{
    NSString *text=@"Hello world what i do for you";
    NSDictionary *dict=@{NSFontAttributeName:[UIFont systemFontOfSize:22],
                         NSForegroundColorAttributeName:[UIColor randomColor],
                         NSStrokeWidthAttributeName:@5,
                         NSStrokeColorAttributeName:[UIColor randomColor]
                         };
    
    UIRectFill(CGRectMake(50, 80, 100, 100));
    UIRectFrame(CGRectMake(200, 80, 100, 100));
    CGMutablePathRef path=CGPathCreateMutable();
    [text drawInRect:CGRectMake(50, 80, 100, 100) withAttributes:dict];
    CGPathAddRect(path, nil, CGRectMake(50, 200, 100, 100));
    CGPathAddArc(path, nil, 250, 300, 80, -M_PI_4, -3*M_PI_4, 1);
    CGPoint pt[3]={{50,400},{100,400},{75,500}};
    CGPathAddLines(path, nil, pt, 3);
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    //开发过程中，ARC环境 C语言的资源是不会自动释放
    // 什么情况下创建的C语言资源，需要释放 以create，retain,copy创建的数据要释放
    //CGPathRelease(path);
    // 能用

    CFRelease(path);
}
- (void)imitateUIImageView
{
    ZYHCircleImageView *circleImage=[[ZYHCircleImageView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    circleImage.imageName=@"489101";
    circleImage.borderColor=[UIColor randomColor];
    circleImage.borderWidth=7;
    circleImage.backgroundColor=[UIColor randomColor];
    [self addSubview:circleImage];
    
}
//绘制水印图片
- (void)drawWaterImage
{
    UIImageView *imageView=[[UIImageView alloc]init];
    UIImage *waterImage=[UIImage waterImageNameWithBgImageName:@"scene" waterImageName:@"logo" scale:2];
    imageView.image=waterImage;
    [imageView sizeToFit];
    CGRect frame=imageView.frame;
    frame.origin=CGPointMake(50, 100);
    imageView.frame=frame;
    [self addSubview:imageView];
}
//画柱状图
- (void)drawPillar
{
    NSArray *data=@[@20,@25,@50,@60];
    NSInteger count=data.count;
    CGFloat sum=0.0;
    for(NSNumber *value in data)
        sum+=[value intValue];
    CGFloat viewHeight=self.bounds.size.height;
    CGFloat height=viewHeight-80;
    CGFloat widht=self.bounds.size.width/(2*count-1);
    for (NSInteger i=0; i<count; i++) {
        CGFloat scale=[data[i] integerValue]/sum;
        CGFloat h=height*scale;
        CGFloat x=2*widht*i;
        CGFloat y=viewHeight-h;
        [[UIColor randomColor] set];
        CGContextAddRect(context, CGRectMake(x, y, widht, h));
        CGContextFillPath(context);
    }
    
}
//背景平铺
- (void)backgroundPattern
{
    UITextView *textView=[[UITextView alloc]initWithFrame:self.bounds];
    NSString *path=[[NSBundle mainBundle]pathForResource:@"news" ofType:@"txt"];
    
    NSString *text=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    textView.text=text;
    textView.backgroundColor=[UIColor clearColor];
   // NSLog(@"%@",[UIFont familyNames]);
    // 当前系统可用的字体
    textView.alpha=0.5;
    textView.editable=NO;
    
    //textView.userInteractionEnabled=NO;
    textView.font=[UIFont fontWithName:@"Zapfino" size:20];
   // textView.backgroundColor=[UIColor colorWithPatternImage:[UIImage dashBgImageWithColor:[UIColor redColor]]];
    UIImageView *imageView=[[UIImageView alloc]init];
    CGFloat screenW=[UIScreen mainScreen].bounds.size.width;
    CGSize textNeedSize=[text boundingRectWithSize:CGSizeMake(screenW, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:textView.font} context:nil].size;
    imageView.frame=CGRectMake(0, 0, textNeedSize.width, textNeedSize.height);
    imageView.backgroundColor=[UIColor colorWithPatternImage:[UIImage dashBgImageWithColor:[UIColor redColor]]];
    [textView insertSubview:imageView atIndex:0];
    [self addSubview:textView];
}
- (void)systemInfo
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
    NSString *name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app名称
    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // aapp名称
    NSString *build = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSString *text=[NSString stringWithFormat:@"app名称%@\napp Short版本:%@\napp版本:%@",name,version,build];
    NSDictionary *dict=@{NSFontAttributeName:[UIFont systemFontOfSize:22],
                         NSForegroundColorAttributeName:[UIColor randomColor],
                         };
    CGRect rect=self.bounds;
    rect.origin.y=100;
    [text drawInRect:rect withAttributes:dict];
}
- (void)clipImage2
{
    UIImage *image=[UIImage imageNamed:@"489101"];
    [image drawInRect:self.bounds];
    CGRect rect=CGRectMake(_firstPoint.x, _firstPoint.y, _lastPoint.x-_firstPoint.x, _lastPoint.y-_firstPoint.y);
    [[UIColor randomColor]set];
    UIRectFrame(rect);
}
#pragma mark --绘制阴影
- (void)drawShadow
{
    
    CGSize   myShadowOffset = CGSizeMake(-15,  -20);

    CGContextSetShadowWithColor (context,myShadowOffset, 5, [UIColor randomColor].CGColor);

    
    [[UIColor randomColor]set];
    UIRectFill(CGRectMake(100, 100, 100, 100));
}
- (void)layerTest
{
    [[UIColor randomColor]set];
    UIRectFill(CGRectMake(100, 300, 100, 100));
}
- (void)myLayer
{
    ZYHLayer *layer=[[ZYHLayer alloc]init];
    layer.bounds=CGRectMake(0, 0, 200, 200);
    layer.position=CGPointMake(100, 100);
    layer.anchorPoint=CGPointMake(0, 0);
    layer.backgroundColor=[[UIColor randomColor]CGColor];
    // 如果自定义的图层，在drawInContext绘制的东西，如果要显示，必须手动调用一个方法，才能显示
    [layer setNeedsDisplay];
    [self.layer addSublayer:layer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (2==self.tag) {
        CGPoint pt=[[self.locations lastObject] CGPointValue];
        CGFloat newX=(pt.x+ballonDelta)>self.frame.size.width?0:(pt.x+arc4random_uniform(ballonDelta)+1);
        
        CGPoint newPt=CGPointMake(newX, self.frame.size.height);
        [self.locations addObject:[NSValue valueWithCGPoint:newPt]];
    }
    if (7==self.tag) {
        [self setNeedsDisplay];
    }
    if (9==self.tag) {
        UITouch *touch=touches.anyObject;
        _firstPoint=[touch locationInView:self];
    }
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (9==self.tag) {
        UITouch *touch=touches.anyObject;
        _lastPoint=[touch locationInView:self];
        [self setNeedsDisplay];
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (9==self.tag) {
        UITouch *touch=touches.anyObject;
        _lastPoint=[touch locationInView:self];
        CGRect rect=CGRectMake(_firstPoint.x, _firstPoint.y, _lastPoint.x-_firstPoint.x, _lastPoint.y-_firstPoint.y);
        UIImage *image=[UIImage getImageFromImage:[UIImage clipScreenImageWithView:self] withRect:rect];
        [UIImagePNGRepresentation(image) writeToFile:@"/Users/apple/Desktop/save.png" atomically:YES];
        [self setNeedsDisplay];
    }
}
@end
