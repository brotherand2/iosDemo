//
//  ViewController.m
//  超极猜图
//
//  Created by Apple on 16/1/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "ZYHQuestionModal.h"
#define btnWidth 33
#define  btnHeight 33
#define column 7
@interface ViewController ()<UIAlertViewDelegate>
{
    CGFloat screenw,screenH;
}
@property (weak, nonatomic) IBOutlet UILabel *countView;
@property (weak, nonatomic) IBOutlet UIButton *coinView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UIButton *iconView;
@property (weak, nonatomic) IBOutlet UIView *answerView;
@property (weak, nonatomic) IBOutlet UIView *optionView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (weak, nonatomic) IBOutlet UIView *pannelView;

@property (weak, nonatomic) UIView *coverView;
@property(nonatomic,strong)  NSArray *questions;
@property(nonatomic,assign) NSInteger index;
@property(nonatomic,assign) NSInteger correctCount;
@property (weak, nonatomic) IBOutlet UIButton *nextView;
@property(nonatomic,assign) CGRect originRect;
@property(nonatomic,assign) CGRect biggerRect;
@end

@implementation ViewController
- (UIView *)coverView
{
    if(_coverView==nil)
    {
        
        UIButton *btn=[[UIButton alloc]init];
        btn.frame=self.view.frame;
        [btn setBackgroundColor:[UIColor blackColor]];
        btn.alpha=0.0;
        [btn addTarget:self action:@selector(restorePicture) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [self.view bringSubviewToFront:self.iconView];
        _coverView=btn;
    }
    return _coverView;
}
//懒加载
- (NSArray *)questions
{
    if(_questions==nil)
    {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"questions.plist" ofType:nil];
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArray=[NSMutableArray array];
        for(NSDictionary *dict in dictArray)
        {
            ZYHQuestionModal *question=[ZYHQuestionModal questionWithDict:dict];
            [tempArray addObject:question];
        }
        _questions=tempArray;
    }
    return _questions;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    screenw=[UIScreen mainScreen].bounds.size.width;
    screenH=[UIScreen mainScreen].bounds.size.height;
    self.index--;
    self.backgroundView.frame=self.view.frame;
    self.pannelView.center=self.view.center;
    self.originRect=self.iconView.frame;
    [self clickNextQuestion:nil];
}
//- (void)layoutSublayersOfLayer:(CALayer *)layer
//{
//    [super layoutSublayersOfLayer:layer];
//    NSLog(@"layout");
//}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
    switch (toInterfaceOrientation)
    {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            _backgroundView.frame=CGRectMake(0, 0, screenH, screenw);
            
            NSLog(@"left %@",NSStringFromCGRect(_backgroundView.frame));
            
            break;
        case UIInterfaceOrientationPortrait:
            
        case UIInterfaceOrientationPortraitUpsideDown:
            _backgroundView.frame=CGRectMake(0, 0,screenw , screenH);
            NSLog(@"up %@",NSStringFromCGRect(_backgroundView.frame));
            break;
        case UIInterfaceOrientationUnknown:
            NSLog(@"Unknown");
            
            break;
    }
    _coverView.frame=_backgroundView.frame;
    self.pannelView.center=_backgroundView.center;
    NSLog(@"rotate %@",NSStringFromCGRect(self.view.frame));
    //_childView.frame=self.view.frame;
    
}

- (IBAction)clickTip:(UIButton*)sender
{
    ZYHQuestionModal *question=self.questions[self.index];
    for(UIButton *btn in self.answerView.subviews)
    {
        [self answerBtnDidClick:btn];
    }
    NSString *firstWord=[question.answer substringToIndex:1];
    for (UIButton*btn in self.optionView.subviews) {
        if([firstWord isEqualToString:btn.currentTitle])
        {
            [self optionBtnDidClick:btn];
            break;
        }
    }
    [self changeScore:-100];
}
- (IBAction)clickHelp:(UIButton*)sender
{
    
}
- (IBAction)clickBigPicture:(UIButton*)sender
{
    
     static BOOL isBigger=YES;
    if(isBigger)
        [self biggerPicture];
    else
        [self restorePicture];
     //NSLog(@"isBigger=%d",isBigger);
    isBigger=!isBigger;
   

}

- (IBAction)biggerPicture
{
    self.coverView.hidden=NO;
    CGFloat coverViewW=self.pannelView.frame.size.width;
    CGFloat coverViewH=coverViewW;
    CGFloat coverViewX=0;
    CGFloat coverViewY=(self.pannelView.frame.size.height-coverViewH)*0.5;
    self.biggerRect=CGRectMake(coverViewX, coverViewY, coverViewW, coverViewH);

    //[self.view bringSubviewToFront:self.iconView];
    //NSLog(@"BIG");
    [UIView animateWithDuration:1.5 animations:^{
        self.coverView.alpha=0.5;
        self.iconView.frame=self.biggerRect;
    }];
}
- (void)restorePicture
{
     //NSLog(@"SMALL");
    [UIView animateWithDuration:1.5 animations:^{
        self.coverView.alpha=0.0;
        self.iconView.frame=self.originRect;

    } completion:^(BOOL finished) {
        self.coverView.hidden=YES;
    }];
    //NSLog(@"SMALL END");
}
- (IBAction)clickNextQuestion:(UIButton*)sender
{
    self.index++;
    if(self.index==self.questions.count)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"恭喜完成回答" delegate:self cancelButtonTitle:@"结束程序" otherButtonTitles:@"回到开头",@"2", nil];
        [alert show];
        return;
    }
    ZYHQuestionModal *question=self.questions[self.index];
    self.nameView.text=question.title;
    self.countView.text=[NSString stringWithFormat:@"%ld/%ld",self.index+1,self.questions.count];
    self.optionView.userInteractionEnabled=YES;
    [self.iconView setImage:[UIImage imageNamed:question.icon] forState:UIControlStateNormal];
    self.nextView.enabled=self.index!=self.questions.count-1;
    [self addAnswers];
    [self addOptions];
}

- (void)addAnswers//添加答案
{
    [self.answerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    ZYHQuestionModal *question=self.questions[self.index];
    CGFloat padding=20;
    NSInteger answerCount=question.answer.length;
    CGFloat marginX=(self.answerView.bounds.size.width-answerCount*btnWidth-(answerCount-1)*padding)/2;
    CGFloat marginY=(self.answerView.bounds.size.height-btnHeight)/2;
    for (NSInteger i=0; i<answerCount; i++)
    {
        CGFloat btnX=marginX+(padding+btnWidth)*i;
        CGRect rect= CGRectMake(btnX, marginY, btnWidth, btnHeight);
        UIButton *btn=[self addButtion:self.answerView withRect:rect];
        [btn addTarget:self action:@selector(answerBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}
-(void)answerBtnDidClick:(UIButton*)btn
{
    if([btn currentTitle]==nil)
        return;
    [self setAnswerViewBtnColor:[UIColor blackColor]];
    for(UIButton *optionBtn in self.optionView.subviews)
    {
        if(optionBtn.tag==btn.tag)
        {
            self.optionView.userInteractionEnabled=YES;
            [btn setTitle:nil forState:UIControlStateNormal];
            
            optionBtn.hidden=NO;
            break;;
        }
    }
}
-(void)optionBtnDidClick:(UIButton*)btn
{
    BOOL isFull=YES;
    for(UIButton *answerBtn in self.answerView.subviews)
    {
        if(answerBtn.currentTitle==nil)
        {
            btn.hidden=YES;
            [answerBtn setTitle:btn.currentTitle forState:UIControlStateNormal];
            answerBtn.tag=btn.tag;
            break;
        }
    }
    NSMutableString *userAnswer=[NSMutableString string];
    for(UIButton *answerBtn in self.answerView.subviews)
    {
        if(answerBtn.currentTitle==nil)
        {
            isFull=NO;
            break;
        }
        [userAnswer appendString:answerBtn.currentTitle];
    }

    if (isFull) {
        self.optionView.userInteractionEnabled=NO;
        ZYHQuestionModal *question=self.questions[self.index];
        if([userAnswer isEqualToString:question.answer])
        {
            [self setAnswerViewBtnColor:[UIColor blueColor]];
            [self changeScore:500];
            self.correctCount++;
            if (self.correctCount==self.questions.count) {
                UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"BINGO!!!全部回答正确" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"哈哈" otherButtonTitles:@"1",@"2", nil];
                [action showInView:self.view];
                return;
            }
            [self performSelector:@selector(clickNextQuestion:) withObject:nil afterDelay:1.0];
            //[self clickNextQuestion:nil];
        }
        else
            [self setAnswerViewBtnColor:[UIColor redColor]];
    }
}
- (void)changeScore:(NSInteger)delta
{
    NSInteger score=[self.coinView.currentTitle intValue];
    score+=delta;
    [self.coinView setTitle:[NSString stringWithFormat:@"%ld",score] forState:UIControlStateNormal];
}
- (void)setAnswerViewBtnColor:(UIColor*)color
{
    for(UIButton *btn in self.answerView.subviews)
    {
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
}
- (UIButton *)addButtion:(UIView *)superView withRect:(CGRect)rect
{
     UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
     [button setBackgroundImage:[UIImage imageNamed:@"btn_answer"] forState:UIControlStateNormal];
     [button setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"] forState:UIControlStateHighlighted];
     button.frame=rect;
     [superView addSubview:button];
    return button;
}
- (void)addOptions//添加选项
{
    [self.optionView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    ZYHQuestionModal *question=self.questions[self.index];
    CGFloat padding=15;
    NSInteger optionCount=question.options.count;
    CGFloat marginX=(self.optionView.bounds.size.width-column*btnWidth-(column-1)*padding)/2;
    
    for (NSInteger i=0; i<optionCount; i++) {
        NSInteger x=i/column;
        NSInteger y=i%column;
        CGFloat btnX=marginX+(padding+btnWidth)*y;
        CGFloat btnY=(padding+btnHeight)*x;
        CGRect rect= CGRectMake(btnX, btnY, btnWidth, btnHeight);
        UIButton *btn=[self addButtion:self.optionView withRect:rect];
        [btn setTitle:question.options[i] forState:UIControlStateNormal];
        btn.tag=i;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(optionBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    }

}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        self.index=-1;
        [self clickNextQuestion:nil];
    }
    else
        exit(0);
}
@end
