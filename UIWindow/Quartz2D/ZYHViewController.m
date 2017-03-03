//
//  ZYHViewController.m
//  UIWindow
//
//  Created by Apple on 16/1/27.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHViewController.h"
#import "ZYHDrawView.h"
#import "UIImage+Extention.h"
#import "OBShapedButton.h"
#import "ZYHView.h"
@interface ZYHViewController ()
{
    @public
    CGFloat screenw;
    CGFloat screenH;
}

@property (weak, nonatomic)ZYHDrawView *childView;
@property (weak, nonatomic)UIImageView *imageView;
@property (weak, nonatomic)CALayer *layer;
@property(nonatomic,strong) NSMutableArray *images;
@property(nonatomic,assign) NSInteger currentIndex;
@property (weak, nonatomic)UIView *bottomView;
@end

@implementation ZYHViewController
- (NSMutableArray *)images
{
    if (_images==nil) {
        _images=[NSMutableArray array];
        for (NSInteger i=1; i<10; i++) {
           
            UIImage *image=[UIImage imageNamed: [NSString stringWithFormat:@"%ld",i]];
            [_images addObject:image];
        }
    }
    return _images;
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
    switch (toInterfaceOrientation)
    {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            _childView.frame=CGRectMake(0, 0, screenH, screenw);
            NSLog(@"left %@",NSStringFromCGRect(_childView.frame));

            break;
        case UIInterfaceOrientationPortrait:
 
        case UIInterfaceOrientationPortraitUpsideDown:
            _childView.frame=CGRectMake(0, 0,screenw , screenH);
            break;
        case UIInterfaceOrientationUnknown:
            NSLog(@"Unknown");
            
            break;
     }

    NSLog(@"rotate %@",NSStringFromCGRect(self.view.frame));
    //_childView.frame=self.view.frame;
    
}
//- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//     NSLog(@"animate");
//}
//- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
//{
//    NSLog(@"Transition");
//}
//- (void)willMoveToParentViewController:(UIViewController *)parent
//{
//    NSLog(@"Move");
//}
//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
//{
//    NSLog(@"did rotate");
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGSize size=[UIScreen mainScreen].bounds.size;
    screenw=size.width;
    screenH=size.height;
    UIBarButtonItem *over=[[UIBarButtonItem alloc]initWithTitle:@"终止" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem=over;
    ZYHDrawView *view=[[ZYHDrawView alloc]init];
    self.childView=view;
    view.tag=self.tag;
    //NSLog(@"%ld",self.view.tag);
    [view setBackgroundColor:[UIColor grayColor]];
    [self.view setBackgroundColor:[UIColor grayColor]];
    view.frame=self.view.frame;
    [self myViewInit];
    [self.view addSubview:view];
}
- (void)myViewInit
{
    if (3==self.tag)
    {
        NSDictionary *dict=@{NSFontAttributeName:[UIFont systemFontOfSize:22],
                             NSForegroundColorAttributeName:[UIColor redColor]             };
        
        [self.navigationItem.rightBarButtonItem setTitle:@"截图"];
        [self.navigationItem.rightBarButtonItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    }
    if (8==self.tag) {
        UIColor *bkgColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"textBg"]];
        _childView.backgroundColor=bkgColor;
        [self.navigationItem.rightBarButtonItem setTitle:@"dash截图"];
    }
    if (11==self.tag) {
        //UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"489101"]];
        //imageView.frame=_childView.bounds;
        UIView *redView=[[UIView alloc]initWithFrame:CGRectMake(100, 300, 100, 100)];
        [redView setBackgroundColor:[UIColor redColor]];
        [_childView addSubview:redView];
        redView.layer.bounds=CGRectMake(0, 0, 200, 200);
        redView.layer.anchorPoint=CGPointMake(0, 0);
        redView.layer.cornerRadius=15;
        redView.layer.backgroundColor=[[UIColor greenColor]CGColor];
        redView.layer.borderWidth=20;
        redView.layer.borderColor=[[UIColor purpleColor]CGColor];
        redView.layer.shadowColor=[[UIColor blackColor]CGColor];
        redView.layer.shadowOffset=CGSizeMake(-50, 50);
        redView.layer.shadowOpacity=0.3;
        /*
         *1.如果你设置了masksToBounds为YES,阴影是不出，原因，阴影也被切掉了
         *2.如果你想有圆角的效果，又想有阴影，图片本来就有圆角效果
         *3.获取话说：自己把图片转换成有圆角的图片，再显示
         */
        //redView.layer.contents=(id)[UIImage imageNamed:@"489101"].CGImage;
        
        //redView.layer.masksToBounds=YES;
        UIView *secondView=[[UIView alloc]init];
        UIImage *image=[UIImage cornerImageWithImageName:@"489101" cornerRadius:25 borderWidth:30 borderColor:[UIColor purpleColor]];
        secondView.layer.bounds=CGRectMake(0, 0, 150, 150);
        secondView.layer.position=CGPointMake(50, 100);
        secondView.layer.contents=(id)[image CGImage];
        secondView.layer.shadowOpacity=0.2;
        secondView.layer.anchorPoint=CGPointMake(0, 0);
        secondView.layer.shadowColor=[[UIColor blackColor]CGColor];
        secondView.layer.shadowOffset=CGSizeMake(50, 50);
        [_childView addSubview:secondView];
        //创建一个图层
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = [UIColor redColor].CGColor;
        layer.bounds = CGRectMake(0, 0, 100, 100);
        
        // 设置位置
        layer.position = CGPointMake(300, 100);
        
        //图层的透明度
        layer.opacity = 0.5;
        
        
        // 设置锚点
        layer.anchorPoint = CGPointMake(0.5, 0.5);
        
        
        //然后添加到控制器的view的图层
        [_childView.layer addSublayer:layer];

    }
    if (14==self.tag) {
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
        imageView.image=[UIImage imageNamed:@"1166593"];
        [self.navigationItem.rightBarButtonItem setTitle:@"隐式动画"];
        [_childView addSubview:imageView];
        CALayer * layer=[[CALayer alloc]init];
        layer.bounds=CGRectMake(0, 0, 200, 200);
        layer.position=CGPointMake(100, 300);
        layer.anchorPoint=CGPointMake(0, 0);
        layer.contents=(id)[[UIImage imageNamed:@"489101"]CGImage];
        [_childView.layer addSublayer:layer];
        _layer=layer;
        _imageView=imageView;
    }
    #pragma mark keyframe
    if (16==self.tag) {
        UIView *view=[[UIView alloc]init];
        view.bounds=CGRectMake(0, 0, screenw, screenw);
        view.center=_childView.center;
        view.backgroundColor=[UIColor yellowColor];
        view.layer.cornerRadius=screenw*0.5;
        [_childView addSubview:view];
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, (screenH-100)*0.5, 100, 100)];
        imageView.image=[UIImage imageNamed:@"1166593"];
        [self.navigationItem.rightBarButtonItem setTitle:@"旋转"];
        [_childView addSubview:imageView];
        _imageView=imageView;

    }
#pragma mark 图片抖动
    if(17==self.tag)
    {
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake((screenw-100)*0.5, 100, 100, 100)];
        imageView.image=[UIImage imageNamed:@"1166593"];
        [_childView addSubview:imageView];
        _imageView=imageView;
    }
#pragma mark--图片浏览
    if(18==self.tag)
    {
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:_childView.bounds];
        imageView.userInteractionEnabled=YES;
       
        imageView.image=[UIImage imageNamed:@"1"];
        
        [_childView addSubview:imageView];
        
        _imageView=imageView;
        [self addTap];
        [self addRotate];
        [self addPinch];
        [self addPan];
    }
#pragma mark --组动画
    if (19==self.tag)
    {
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
        imageView.image=[UIImage imageNamed:@"3"];
        [self.navigationItem.rightBarButtonItem setTitle:@"开始组动画"];
        [_childView addSubview:imageView];
        _imageView=imageView;
    }
#pragma mark--车小弟模仿
    if(20==self.tag)
    {
        CGFloat imageW=306;
        CGFloat imageH=imageW;
        CGFloat imageX=(screenw-imageW)*0.5;
        CGFloat imageY=(screenH-imageH)*0.5;
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
        imageView.userInteractionEnabled=YES;
        imageView.image=[UIImage imageNamed:@"home_yuanpan_bg"];
        for(NSInteger i=0;i<3;i++)
        {
            UIButton *btn=[OBShapedButton buttonWithType:UIButtonTypeCustom];
            btn.frame=imageView.bounds;
            
            [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"circle%ld",i+1]] forState:UIControlStateNormal];
            [imageView addSubview:btn];
            
        }
        UIButton *centerBtn=[OBShapedButton buttonWithType:UIButtonTypeCustom];
        centerBtn.bounds=CGRectMake(0, 0, 117, 117);
        centerBtn.center=imageView.center;
        [centerBtn setBackgroundImage:[UIImage imageNamed:@"home_btn_dealer_had_bind"] forState:UIControlStateNormal];
        [centerBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
       
        _imageView=imageView;
        [_childView addSubview:imageView];
        [_childView addSubview:centerBtn];
        [self addSimpleReflectionToView:imageView];
    }
#pragma mark--底部旋转菜单
    if(21==self.tag)
    {
        CGFloat bottomH=50;
        UIView *bottomMenu=[[UIView alloc]initWithFrame:CGRectMake(0, screenH-bottomH, screenw, bottomH)];
        [bottomMenu setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"822726"]]];
        _bottomView=bottomMenu;
        [self addBtnWithImageName:@"menu_btn_call" andTag:0];
        [self addBtnWithImageName:@"menu_btn_cheyou" andTag:1];
        [self addBtnWithImageName:@"menu_btn_tixing" andTag:2];
        [self addBtnWithImageName:@"small_main_menu" andTag:3];
        
        [_childView addSubview:bottomMenu];
    }
    if(22==self.tag)
    {
        
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 200, 200)];
        imageView.userInteractionEnabled=YES;
        
        imageView.image=[UIImage imageNamed:@"papa"];
        
        [_childView addSubview:imageView];
        
        _imageView=imageView;

        [self addSimpleReflectionToView:imageView];
    }
#pragma mark--核心动画旋转
    if(23==self.tag)
    {
        ZYHView *view=[[ZYHView alloc]initWithFrame:CGRectMake(100, 300, 150, 40)];
        view.backgroundColor=[UIColor yellowColor];
        view.alpha=0.3;
        [_childView addSubview:view];
        CABasicAnimation *animation=[CABasicAnimation animation];
        animation.duration=2;
        animation.keyPath=@"transform.rotation";
        animation.toValue=@(2*M_PI);
        animation.repeatCount=MAXFLOAT;
        [view.layer addAnimation:animation forKey:nil];
    }

}
#define btnWH 48
#define padding 10
- (void)addBtnWithImageName:(NSString*)imageName andTag:(NSInteger)tag
{
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(padding, (_bottomView.bounds.size.height-btnWH)*0.5, btnWH, btnWH)];
    btn.tag=tag;
    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:btn];
}
- (void)bottomBtnClick:(UIButton*)btn
{
    //NSLog(@"%ld",btn.tag);
    if(btn.tag==3)
    {
        //红色加号按钮是否旋转过
        BOOL isIdentity=CGAffineTransformIsIdentity(btn.transform);
        NSInteger animationTime=5;
        [UIView animateWithDuration:animationTime animations:^{
            btn.transform=isIdentity? CGAffineTransformMakeRotation(M_PI_4):CGAffineTransformIdentity;//如果没有旋转向右旋转45度,旋转了则恢复
        }];
        CGFloat delta=(screenw-padding)/4;//按钮与按钮的距离
        
        for(UIButton *button in _bottomView.subviews)
        {
            if(button.tag!=3)
            {
                CGPoint showPosition=CGPointMake(btn.center.x+(button.tag+1)*delta, btn.center.y);
                CAAnimationGroup *group=[CAAnimationGroup animation];
                CAKeyframeAnimation *positionAni=[CAKeyframeAnimation animation];
                positionAni.keyPath=@"position";
                CAKeyframeAnimation *rotationAni=[CAKeyframeAnimation animation];
                rotationAni.keyPath=@"transform.rotation";
                NSValue *value1=[NSValue valueWithCGPoint:btn.center];
                NSValue *value2=[NSValue valueWithCGPoint:CGPointMake(showPosition.x*0.5, showPosition.y)];
                NSValue *value3=[NSValue valueWithCGPoint:CGPointMake(showPosition.x*1.1, showPosition.y)];
                NSValue *value4=[NSValue valueWithCGPoint:showPosition];
                if(isIdentity)
                {
                    positionAni.values=@[value1,value2,value3,value4];
                    button.center=showPosition;
                    rotationAni.values=@[@0,@(M_PI * 2),@(M_PI_4),@(2*M_PI)];
                }
                else
                {
                    positionAni.values=@[value4,value3,value2,value1];
                    button.center=btn.center;
                    rotationAni.values=@[@0,@(M_PI * 2),@(0),@(-2*M_PI)];
                }
                group.animations=@[positionAni,rotationAni];
                group.duration=animationTime;
                [button.layer addAnimation:group forKey:nil];
            }
        }
    }

}
- (void)btnClick:(UIButton*)btn
{
    NSInteger currentAlpha=_imageView.alpha;
    // 1.先实现隐藏和显示,防止隐式动画完后反弹
    //hidden alpha
    if (currentAlpha == 1) {//隐藏
        _imageView.alpha = 0;
    }else{//显示
        
        _imageView.alpha = 1;
    }

    CAAnimationGroup *group=[CAAnimationGroup animation];
    CABasicAnimation *opacityAni=[CABasicAnimation animation];
    opacityAni.keyPath = @"opacity";
    CAKeyframeAnimation *scaleAni=[CAKeyframeAnimation animation];
     scaleAni.keyPath=@"transform.scale";
    CABasicAnimation *rotationAni=[CABasicAnimation animation];
   
    rotationAni.keyPath=@"transform.rotation";
    if(currentAlpha==1)
    {
        opacityAni.fromValue=@1;
        opacityAni.toValue=@0;
        scaleAni.values=@[@1,@1.2,@0];
        rotationAni.fromValue=@0;
        rotationAni.toValue=@(-M_PI_4);
    }
    else
    {
        opacityAni.fromValue=@0;
        opacityAni.toValue=@1;
        scaleAni.values=@[@0,@1.2,@1];
        rotationAni.toValue=@0;
        rotationAni.fromValue=@(-M_PI_4);

    }
    group.animations=@[opacityAni,scaleAni,rotationAni];
    group.duration=2;
    [_imageView.layer addAnimation:group forKey:nil];
}
/**
 * 提示:转场的动画的类型（type）和子头型(subtype) 能用字符串常量就用字符常量
 */


/**
 *******************************************************
 type:动画类型(比如：滴水效果，翻转效果...)
 -------------------------------------------------------
 fade kCATransitionFade 交叉淡化过渡
 moveIn kCATransitionMoveIn 新视图移到旧视图上面
 push kCATransitionPush 新视图把旧视图推出去
 reveal kCATransitionReveal 将旧视图移开,显示下面的新视图
 pageCurl               向上翻一页
 pageUnCurl             向下翻一页
 rippleEffect             滴水效果
 suckEffect 收缩效果，如一块布被抽走
 cube                   立方体效果
 oglFlip              上下左右翻转效果
 rotate     旋转效果
 cameraIrisHollowClose 相机镜头关上效果(不支持过渡方向)
 cameraIrisHollowOpen 相机镜头打开效果(不支持过渡方向)
 
 *******************************************************
 subtype: 动画方向(比如说是从左边进入，还是从右边进入...)
 ------------------------------------------------------
 kCATransitionFromRight;
 kCATransitionFromLeft;
 kCATransitionFromTop;
 kCATransitionFromBottom;
 
 当 type 为@"rotate"(旋转)的时候,它也有几个对应的 subtype,分别为:
 90cw 逆时针旋转 90°
 90ccw 顺时针旋转 90°
 180cw 逆时针旋转 180°
 180ccw  顺时针旋转 180°
 **/

- (void)tapGesture:(UITapGestureRecognizer*)tap
{
    CGPoint point=[tap locationInView:_childView];
    
    if(point.x<_childView.bounds.size.width*0.5)
    {
        if(_currentIndex<=0)
            _currentIndex=self.images.count;
        _currentIndex--;
    }
    else
    {
        if(_currentIndex>=self.images.count-1)
            _currentIndex=-1;
        _currentIndex++;
    }
    NSArray *types=@[@"fade",@"moveIn",@"push",@"reveal",@"pageCurl",
                     @"pageUnCurl",@"rippleEffect",@"suckEffect",@"cube",@"oglFlip ",@"rotate",@"cameraIrisHollowClose",@"cameraIrisHollowOpen"];//动画类型
    NSArray *subTypes=@[@"kCATransitionFromRight",@"kCATransitionFromLeft",
                        @"kCATransitionFromTop",@" kCATransitionFromBottom"];
    NSArray *rotateSubTypes=@[@"90cw",@"90ccw",@"180cw",@"180ccw"];
    //切换图片的时候，使用转场动画
    CATransition *animation=[CATransition animation];
    animation.type=types[arc4random()%types.count];
    if ([animation.type isEqualToString:@"rotate"]) {
        animation.subtype=rotateSubTypes[arc4random()%rotateSubTypes.count];
    }
    else
        animation.subtype=subTypes[arc4random_uniform(subTypes.count)];
    _imageView.image=_images[_currentIndex];
    animation.duration=2;
    [_imageView.layer addAnimation:animation forKey:nil];
}
//添加敲击手势
- (void)addTap
{
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    
    [_childView addGestureRecognizer:tapGesture];
}
//添加旋转手势
- (void)addRotate
{
    UIRotationGestureRecognizer *rotate=[[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotate:)];
    [_imageView addGestureRecognizer:rotate];
    rotate.delegate=self;
}
//添加缩放手势
- (void)addPinch
{
    UIPinchGestureRecognizer *pinch=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
    [_imageView addGestureRecognizer:pinch];
    
}
//添加拖拽手势
- (void)addPan
{
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [_imageView addGestureRecognizer:pan];
}
- (void)pan:(UIPanGestureRecognizer*)pan
{
    CGPoint point=[pan translationInView:_imageView];
    _imageView.transform=CGAffineTransformTranslate(_imageView.transform, point.x, point.y);
    
    //复位
    [pan setTranslation:CGPointZero inView:_imageView];
}
- (void)pinch:(UIPinchGestureRecognizer*)pinch
{
    _imageView.transform=CGAffineTransformScale(_imageView.transform, pinch.scale, pinch.scale);
    
    pinch.scale=1;//比例不累加
    
}
- (void)rotate:(UIRotationGestureRecognizer*)rotate
{
    //每次旋转的方向都是基于第1次
    //_imageView.transform=CGAffineTransformMakeRotation(rotate.rotation);
    _imageView.transform=CGAffineTransformRotate(_imageView.transform, rotate.rotation);//继于上一次的方向旋转
    
    rotate.rotation=0;//方向不累加
    
    
}
//支持多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)cancel
{
    //NSLog(@"cancel");
    if (2==self.tag) {
        [self.childView.timer invalidate];
    }
    if (3==self.tag)
    {
        UIImage *clipImage=[UIImage clipScreenImageWithView:self.view.window];
        NSData *data=UIImagePNGRepresentation(clipImage);
        [data writeToFile:@"/Users/apple/Desktop/clip.png" atomically:YES];
    }
    
    if (5==self.tag)
    {
        UIImage *waterImage=[UIImage waterImageNameWithBgImageName:@"scene" waterImageName:@"logo" scale:2];
        NSData *data=UIImagePNGRepresentation(waterImage);
        [data writeToFile:@"/Users/apple/Desktop/water.png" atomically:YES];
        data=UIImageJPEGRepresentation(waterImage, 0.7);
        //compressionQuality 压缩质量 值的范围(0-1)
         [data writeToFile:@"/Users/apple/Desktop/compressionQuality.png" atomically:YES];
    }
    if (8==self.tag) {
        UIImage *image=[UIImage dashBgImageWithColor:[UIColor purpleColor]];
        NSData *data=UIImagePNGRepresentation(image);
        [data writeToFile:@"/Users/apple/Desktop/dash.png" atomically:YES];

    }
    if (14==self.tag)
    {
        //self.imageView.layer 它是根层
#warning 根层改变属性是没有动画，只有非根层改变属性就有默认的动画
        //设置根层的大小

        self.imageView.layer.bounds=CGRectMake(0, 0, 200, 200);
        CABasicAnimation *basic=[CABasicAnimation animation];
        basic.keyPath=@"bounds";
        basic.toValue=[NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
         basic.removedOnCompletion=NO;
        basic.fillMode=kCAFillModeForwards;

        [self.imageView.layer addAnimation:basic forKey:nil];
        /*
         *解决方案1：如果想控件的大小真实改变，要在动画结束之后设置控件的尺寸
         *解决方案2：使动画保存执行之后的状态，默认动画执行完后，会返回原来的状态
         */
               
        [CATransaction begin];
        //[CATransaction setDisableActions:YES];
        [CATransaction setAnimationDuration:5.0];
        self.imageView.layer.bounds=CGRectMake(0, 0, 150, 150);
 
        self.layer.transform=CATransform3DMakeRotation(M_PI_4, 1, 1, 1);
        [CATransaction commit];
    }
    if (16==self.tag) {
        CAKeyframeAnimation *animation=[CAKeyframeAnimation animation];
        NSValue *value1=[NSValue valueWithCGPoint:CGPointMake(0, screenH*0.5)];
        NSValue *value2=[NSValue valueWithCGPoint:CGPointMake(screenw*0.5, screenH*0.5-screenw)];
        NSValue *value3=[NSValue valueWithCGPoint:CGPointMake(screenw, screenH*0.5)];
        NSValue *value4=[NSValue valueWithCGPoint:CGPointMake(screenw*0.5, screenH*0.5+screenw)];
        animation.values=@[value1,value2,value3,value4];
        animation.duration=5;
        animation.keyPath=@"position";
        animation.removedOnCompletion=NO;
        animation.fillMode=kCAFillModeForwards;
        //设置动画节奏
        //kCAMediaTimingFunctionEaseIn 先慢后快
        //kCAMediaTimingFunctionEaseOut 先快后慢
        //kCAMediaTimingFunctionLinear 线性匀速
        //kCAMediaTimingFunctionEaseInEaseOut 中间快两边慢
        animation.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        #warning 内部的path的优级大小values优先级
        CGMutablePathRef path=CGPathCreateMutable();
        CGPathAddEllipseInRect(path, 0, CGRectMake(0, (screenH-screenw)*0.5, screenw, screenw));
        animation.path=path;
        CFRelease(path);
        [_imageView.layer addAnimation:animation forKey:nil];
        
    }
    if(17==self.tag)
       [_imageView.layer removeAnimationForKey:@"shake"];
    if(19==self.tag)
    {
        CAAnimationGroup *group=[CAAnimationGroup animation];
        CABasicAnimation *scaleAni=[CABasicAnimation animation];
        scaleAni.keyPath=@"transform.scale";
        scaleAni.toValue=@0.5;
        CABasicAnimation *rotationAni=[CABasicAnimation animation];
        rotationAni.keyPath=@"transform.rotation";
        rotationAni.toValue=@(M_2_PI);
        group.duration=5.0;
        CAKeyframeAnimation *positionAni=[CAKeyframeAnimation animation];
        positionAni.keyPath=@"position";
        NSValue *value=[NSValue valueWithCGPoint:_imageView.center];
         NSValue *value1=[NSValue valueWithCGPoint:CGPointMake(screenw, screenH*0.5)];
        NSValue *value2=[NSValue valueWithCGPoint:CGPointMake(0, screenH-100)];
        positionAni.values=@[value,value1,value2,value];
        group.animations=@[positionAni,scaleAni,rotationAni];
        group.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [_imageView.layer addAnimation:group forKey:nil];
    }

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (17==self.tag)
    {
        CAKeyframeAnimation *animation=[CAKeyframeAnimation animation];
        animation.keyPath=@"transform.rotation";
        CGFloat angle=M_PI_4;
        animation.values=@[@(-angle),@(0),@(angle),@(-angle)];
        animation.repeatCount=MAXFLOAT;
        [_imageView.layer addAnimation:animation forKey:@"shake"];
    }

}


#pragma mark--视图添加倒影效果
- (void)addSimpleReflectionToView:(UIView *)theView
{
    const CGFloat kReflectPercent = -0.25f;
    const CGFloat kReflectOpacity = 0.3f;
    const CGFloat kReflectDistance = 10.0f;

    CALayer *reflectionLayer = [CALayer layer];
    reflectionLayer.contents = [theView layer].contents;
    reflectionLayer.opacity = kReflectOpacity;
    reflectionLayer.frame = CGRectMake(0.0f,0.0f,theView.frame.size.width,theView.frame.size.height*kReflectPercent);//窗口在原视图上面
    //倒影层框架设置，其中高度是原视图的百分比
    //将图片倒立
    CATransform3D stransform = CATransform3DMakeScale(1.0f,-1.0f,1.0f);
    CATransform3D transform = CATransform3DTranslate(stransform,0.0f,-(kReflectDistance + theView.frame.size.height),0.0f);//移到原视图下面10
    reflectionLayer.transform = transform;
    reflectionLayer.sublayerTransform = reflectionLayer.transform;
    [[theView layer] addSublayer:reflectionLayer];
}
@end
