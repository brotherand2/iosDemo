//
//  ZYHAppView.m
//  helloworld
//
//  Created by Apple on 16/1/7.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHAppView.h"
#import "ZYHAppModal.h"
@interface ZYHAppView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *labelView;

@end
@implementation ZYHAppView

+ (instancetype)appView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZYHApp" owner:nil options:nil] lastObject];
}
+ (instancetype)appViewWithAppModal:(ZYHAppModal *)modal
{
    ZYHAppView *appView=[ZYHAppView appView];
    appView.appModal=modal;
    return appView;
}
- (void)setAppModal:(ZYHAppModal *)appModal
{
    _appModal=appModal;
    self.imageView.image=[UIImage imageNamed:appModal.icon];
    self.labelView.text=appModal.name;
}
- (IBAction)clickBTN:(UIButton*)sender
{
    sender.enabled=NO;
    if(self.click)
        self.click(self);
}
@end
