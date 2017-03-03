//
//  ZYHFootView.m
//  helloworld
//
//  Created by Apple on 15/11/29.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ZYHFootView.h"
@interface ZYHFootView()
@property (weak, nonatomic) IBOutlet UIView *loadingView;

- (IBAction)loadMoreData:(UIButton *)btn;

@end
@implementation ZYHFootView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)loadMoreData:(UIButton *)btn
{
    btn.hidden=YES;
    self.loadingView.hidden=NO;
#pragma mark 延迟多长时间执行block代码
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                   {
                   if([self.delegate respondsToSelector:@selector(footerViewLoadDidClick:)])
                       [self.delegate footerViewLoadDidClick:self];
                       btn.hidden=NO;
                       self.loadingView.hidden=YES;
                   });
}
@end
