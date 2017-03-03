//
//  ViewController.m
//  汤姆猫
// 未适配
//  Created by Apple on 15/11/25.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *tomImage;
@property(nonatomic,strong) AVAudioPlayer *sound;
@property(nonatomic,strong) NSMutableDictionary *tomcatDict;
@property(nonatomic,strong) NSArray*tomcatSound;
@property(nonatomic,assign) BOOL lastActionisBTN;
//- (IBAction)drink;
//- (IBAction)knoutOut;//昏迷
@end
typedef enum
{
    TomCatFart=0,//放屁
    TomcatCymbal,//打叉
    TomCatDrink,//喝牛奶
    TomCatEat,//吃鸟
    TomCatPie,//拍饼
    TomCatScratch,//玻璃
    TomCatKnockout,        // 打脸
    TomCatStomach,         // 肚皮
    TomCatFootRight,       // 右脚
    TomCatFootLeft,        // 左脚
    TomCatAngryTail,       // 尾巴
    TomcatBlink=11,
    TomcatHappy,
    TomcatLappySimple,
    TomCatListen,
    TomCatSneeze,
    TomCatTalk,
    TomCatFartSingle
}TomCatAnimationType;
@implementation ViewController
- (NSMutableDictionary *)tomcatDict
{
    if (_tomcatDict==nil) {
      NSString *path=[[NSBundle mainBundle]pathForResource:@"Tomcat" ofType:@"plist"];
    _tomcatDict=[NSMutableDictionary dictionaryWithContentsOfFile:path];
      
    }
    return _tomcatDict;
}
- (NSArray *)tomcatSound
{
    if (_tomcatSound==nil) {
        _tomcatSound=[NSArray array];
    }
    return _tomcatSound;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
        [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(animationAction:) userInfo:nil repeats:YES];
}
- (IBAction)animationAction:(UIButton*)sender
{
    NSDictionary *dict;
    NSInteger animate;
    if(self.tomImage.isAnimating)//如果正在动画
     {
         if(self.lastActionisBTN)
             return;
         else
             [self.tomImage stopAnimating];
     }

    if([sender isKindOfClass:[UIButton class]])
    {
        self.lastActionisBTN=YES;
        animate=sender.tag;
    }
    else
    {
        animate=TomcatBlink+arc4random()%7;
        self.lastActionisBTN=NO;
    }
     
    switch (animate) {
        case TomCatAngryTail:
            dict=self.tomcatDict[@"angry-tail"];
            break;
        case TomcatCymbal:
            dict=self.tomcatDict[@"cymbal"];
            break;
        case TomCatEat:
            dict=self.tomcatDict[@"eat"];
            break;
        case TomCatFart:
            dict=self.tomcatDict[@"fart"];
            break;
        case TomCatDrink:
            dict = _tomcatDict[@"drink"];
            break;
        case TomCatPie:
            dict = _tomcatDict[@"pie"];
            break;
        case TomCatScratch:
            dict = _tomcatDict[@"scratch"];
            break;
        case TomCatFootLeft:
            dict=self.tomcatDict[@"foot-left"];
            break;
        case TomCatFootRight:
            dict = _tomcatDict[@"foot-right"];
            break;
        case TomCatKnockout:
            dict = _tomcatDict[@"knockout"];
            break;
        case TomCatStomach:
            dict = _tomcatDict[@"stomach"];
            break;
        case TomCatTalk:
            dict = _tomcatDict[@"talk"];
            break;
        case TomcatBlink:
            dict = _tomcatDict[@"blink"];
            break;
        case TomcatHappy:
            dict=self.tomcatDict[@"happy"];
            break;
        case TomcatLappySimple:
            dict = _tomcatDict[@"happy-simple"];
            break;
        case TomCatListen:
            dict = _tomcatDict[@"listen"];
            break;
        case TomCatSneeze:
            dict = _tomcatDict[@"sneeze"];
            break;
        case TomCatFartSingle:
            dict=_tomcatDict[@"upgrade"];
            break;
        default:
            break;
    }
    NSMutableArray *imageList=[NSMutableArray array];
    for (NSInteger i=0; i<[dict[@"frames"] integerValue]; i++) {
        NSString *imageFile=[NSString stringWithFormat:dict[@"imageFormat"],i];
         NSString *imagePath=[[NSBundle mainBundle]pathForResource:imageFile ofType:nil];
        UIImage *image=[UIImage imageWithContentsOfFile:imagePath];//这种方法加载图片不会驻入内存,imagenamed加载完图片后不会释放
        [imageList addObject:image];
       /*
        .为什么尽量避免使用imageNamed？
        使用这种方式生成的对象被autorelease之后，图片依然存在于内存，并不会及时回收，并且没有明确的释放方法。如果图像比较大，或者图像比较多，用这种方式会消耗很大的内存。
        这是为什么？如果对于大量同一图片的复，使用这个方法可行。以这种方式加载的图片会缓存一份在内存中，以后如果发现有同名的图片，则不会再次加载。缺点是这份缓存无法预知释放时间与条件。
        2.最好使用方式：imageWithContentsOfFile，根据文件路径加载图片。这种方式加载的图片不会缓存在内存中，当对象被释放之后，图片也会被释放。
        */
    }
    NSString *soundPath;
    self.tomcatSound=dict[@"soundFiles"];
    if(self.tomcatSound.count>0)
    {
        NSInteger index=arc4random()%self.tomcatSound.count;
        soundPath=self.tomcatSound[index];
    }
    
    CGFloat delay;
    if (animate==TomCatListen||animate==TomCatFartSingle)
        delay=2.0;//这2个情况是只有一张图片，时间久一点
    else
         delay=[dict[@"frames"] integerValue]*0.06;
    [self.tomImage setAnimationImages:imageList];
    [self.tomImage setAnimationRepeatCount:1];
    [self.tomImage setAnimationDuration:delay];
    [self.tomImage startAnimating];
    if(soundPath!=nil)
        //[self playSound:soundPath];
    [self performSelector:@selector(playSound:) withObject:soundPath afterDelay:0.5];//0.5秒后再播放声音
    [self.tomImage performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:delay];//因为setAnimationImages:是copy属性会拷贝一份，不能被释放，需置nil来释放内存
}
//- (void)drink
//{
//    
//    if(self.tomImage.isAnimating)
//        return;
//    //运行动画，异步调用，即动画函数调用后不等动画播完，立即返回，执行下一条语句
//
//    [self runAnimationWithName:@"cat_drink" andwithCount:81];    //[self playSound:@"p_drink_milk"];
//    [self performSelector:@selector(playSound:) withObject:@"p_drink_milk" afterDelay:1.0];//动画播放1秒后再播放声音
//}
//-(void)knoutOut
//{
//    if(self.tomImage.isAnimating)
//        return;
//
//    [self runAnimationWithName:@"cat_knockout" andwithCount:81];
//    //[self playSound:@"fall"];
//    [self performSelector:@selector(playSound:) withObject:@"fall" afterDelay:1.0];
//}
////运行动画
//- (void)runAnimationWithName:(NSString*)imageName andwithCount:(int)count
//{
//    NSMutableArray *images=[NSMutableArray array];
//    for(int i=0;i<count;i++)
//    {
//        NSString *fileName=[NSString stringWithFormat:@"%@%04d.jpg",imageName,i];
//        //UIImage *image=[UIImage imageNamed:fileName];
//        NSString *imagePath=[[NSBundle mainBundle]pathForResource:fileName ofType:nil];
//        UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
//        [images addObject:image];
//    }
//    self.tomImage.animationImages=images;//播放动画的图片
//    self.tomImage.animationRepeatCount=1;//重复的的次数
//    self.tomImage.animationDuration=count*0.05;//播放时间
//    [self.tomImage startAnimating];//开始播放
//    [self.tomImage performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:count*0.05];
//}
- (void)playSound:(NSString *)soundName
{
    NSString *path=[[NSBundle mainBundle] pathForResource:soundName ofType:nil];
    NSURL *url=[NSURL fileURLWithPath:path];
    NSError *error;
    self.sound=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    //[self.sound prepareToPlay];
    [self.sound play];
}

@end
