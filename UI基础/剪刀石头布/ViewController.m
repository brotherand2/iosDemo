//
//  ViewController.m
//  剪刀石头布
//
//  Created by Apple on 16/1/6.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *computerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *playerImageView;
@property (weak, nonatomic) IBOutlet UILabel *computerScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIView *actionView;
@property (weak, nonatomic) IBOutlet UIButton *resumeBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;


//播放背景音乐
@property(nonatomic,strong) AVAudioPlayer *backMusicPlayer;


@property(nonatomic,strong) NSArray *imageList;
@property(nonatomic,assign) SystemSoundID  winSound;
@property(nonatomic,assign) SystemSoundID faildSound;
@property(nonatomic,assign) SystemSoundID darwnSound;
@property(nonatomic,assign) SystemSoundID clickSound;
- (SystemSoundID)loadSounds:(NSString*)soundFileName;
@end

@implementation ViewController
- (AVAudioPlayer *)backMusicPlayer
{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"背景音乐" ofType:@"caf"];
    NSURL *url=[NSURL fileURLWithPath:path];
    NSError *error;
    _backMusicPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    [_backMusicPlayer setNumberOfLoops:-1];//无限播放
    // 5 准备播放
    //[_backMusicPlayer prepareToPlay];
    return _backMusicPlayer;
}
//加载音效
- (SystemSoundID)loadSounds:(NSString *)soundFileName
{
    NSString *path=[[NSBundle mainBundle]pathForResource:soundFileName ofType:nil];
    NSURL *url=[NSURL fileURLWithPath:path];
    SystemSoundID soundId;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundId);
    return soundId;

}
- (NSArray *)imageList
{
    if(_imageList==nil)
    {
        _imageList=@[[UIImage imageNamed:@"石头"],
                         [UIImage imageNamed:@"剪刀"],
                         [UIImage imageNamed:@"布"],];
    }
    return _imageList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.computerImageView setAnimationImages:self.imageList];
    [self.playerImageView setAnimationImages:self.imageList];
    
    [self.computerImageView setAnimationDuration:1.0];
    [self.playerImageView setAnimationDuration:1.0];
    
    [self.computerImageView startAnimating];
    [self.playerImageView startAnimating];
    [self.backMusicPlayer play];
    self.winSound=[self loadSounds:@"胜利.aiff"];
    self.faildSound=[self loadSounds:@"失败.aiff"];
    self.darwnSound=[self loadSounds:@"和局.aiff"];
    self.clickSound=[self loadSounds:@"点击按钮.aiff"];
  }
- (IBAction)resumeGame:(id)sender
{
    AudioServicesPlaySystemSound(self.clickSound);
    self.resumeBtn.hidden=YES;
    [UIView animateWithDuration:0.5 animations:^{
        //[self.actionView setCenter:CGPointMake(self.actionView.center.x, self.actionView.center.y-self.actionView.bounds.size.height)];
        self.bottomConstraint.constant=0;
    }];
    [self.computerImageView startAnimating];
    [self.playerImageView startAnimating];
    self.resumeBtn.userInteractionEnabled=NO;
    self.messageLabel.text=nil;
}
- (IBAction)playAction:(UIButton*)sender
{
    [self.computerImageView stopAnimating];
    [self.playerImageView stopAnimating];
    //
    
    AudioServicesPlaySystemSound(self.clickSound);
    NSInteger playSelect=sender.tag;
    NSInteger computerSelect=arc4random()%3;
    NSInteger result=playSelect-computerSelect;
    NSString *message=nil;
    if(0==result)
    {
        message=@"和局";
        AudioServicesPlaySystemSound(self.darwnSound);
    }
    else
    {
        if(result==-1||result==2)
        {
             NSInteger score=[self.playerScoreLabel.text integerValue];
            score++;
            self.playerScoreLabel.text=[NSString stringWithFormat:@"%ld",score];
            AudioServicesPlaySystemSound(self.winSound);
            message=@"哦也，你赢了！";
        }
        else
        {
            NSInteger score=[self.computerScoreLabel.text integerValue];
            score++;
            self.computerScoreLabel.text=[NSString stringWithFormat:@"%ld",score];
            message=@"真可惜，你输了";
            AudioServicesPlaySystemSound(self.faildSound);
        }
    }
    self.messageLabel.text=message;
    self.computerImageView.image=self.imageList[computerSelect];
    self.playerImageView.image=self.imageList[playSelect];
    self.resumeBtn.hidden=NO;
    self.resumeBtn.userInteractionEnabled=YES;
    [UIView animateWithDuration:0.5 animations:^{
       // NSLog(@"%f %f",self.actionView.center.y,self.actionView.bounds.size.height);
        self.bottomConstraint.constant=self.actionView.bounds.size.height;
        //[self.actionView setCenter:CGPointMake(self.actionView.center.x, self.actionView.center.y+self.actionView.bounds.size.height)];
    }];
}
@end
