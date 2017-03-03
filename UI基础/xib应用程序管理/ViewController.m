//
//  ViewController.m
//  xib应用程序管理
//
//  Created by Apple on 16/1/7.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "ZYHAppModal.h"
#import "ZYHAppView.h"
#define row 4
#define colum 3
@interface ViewController ()
@property(nonatomic,strong) NSArray *appModals;
@property(nonatomic,strong) UILabel *tipLabel;
@end

@implementation ViewController
- (UILabel *)tipLabel
{
    if(nil==_tipLabel)
    {
        CGFloat width=160;
        CGFloat height=40;
        CGFloat x=(self.view.bounds.size.width-width)*0.5;
        CGFloat y=self.view.bounds.size.height*0.75;
        _tipLabel=[[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_tipLabel setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.2]];
        _tipLabel.textAlignment=NSTextAlignmentCenter;
        [self.view addSubview:_tipLabel];
    }
    return _tipLabel;
}
//懒加载
- (NSArray *)appModals
{
    if(_appModals==nil)
    {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"app.plist" ofType:nil];
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArray=[NSMutableArray array];
        for(NSDictionary *dict in dictArray)
        {
            ZYHAppModal *modal=[ZYHAppModal appWithDict:dict];
            [tempArray addObject:modal];
        }
        _appModals=tempArray;
    }
    return _appModals;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if(self.appModals==nil)
        return;
    ZYHAppView *appView=[ZYHAppView appView];
   
    CGFloat viewW=appView.bounds.size.width;
    CGFloat viewH=appView.bounds.size.height;
    CGFloat marginX=(self.view.bounds.size.width-colum*viewW)/(colum+1);
     CGFloat marginY=(self.view.bounds.size.height-row*viewH)/(row+1);
    __weak ViewController *controller=self;
    for (NSInteger i=0; i<self.appModals.count; i++) {
        NSInteger x=i/colum;//第几行
        NSInteger y=i%colum;
        CGFloat viewX=marginX+y*(viewW+marginX);
        CGFloat viewY=marginY+x*(viewH+marginY);
        ZYHAppView *appView=[ZYHAppView appViewWithAppModal:self.appModals[i]];
        appView.frame=CGRectMake(viewX, viewY, viewW, viewH);
        appView.click=^(ZYHAppView*view){
            [controller DidClickDownloadBtn:view];
        };
        [self.view addSubview:appView];
    }
}
- (void)DidClickDownloadBtn:(ZYHAppView*)view
{
    //NSLog(@"CLICK");
    [self.tipLabel setText:view.appModal.name];
    [UIView animateWithDuration:1.0 animations:^{
        self.tipLabel.alpha=1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            self.tipLabel.alpha=0.0;
        }];
        
    }];
}
@end
