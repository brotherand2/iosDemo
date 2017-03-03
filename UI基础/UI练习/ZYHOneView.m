//
//  ZYHOneView.m
//  helloworld
//
//  Created by Apple on 16/2/1.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHOneView.h"

@interface ZYHOneView()
@property (weak, nonatomic) IBOutlet UISlider *sliderView;
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic)UIButton *lastBtn;
@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@end

@implementation ZYHOneView
- (IBAction)valueChange:(UISlider*)sender
{
    [_lastBtn setSelected:NO];
    int minus=sender.value-sender.minimumValue;
    if (minus%2==0&&minus/2<_buttons.count) {
        UIButton *btn=_buttons[minus/2];
        [btn setSelected:YES];
        _lastBtn=btn;
    }
    _titleView.font=[UIFont systemFontOfSize:sender.value];
}
- (IBAction)btnClick:(UIButton*)sender
{
    [_lastBtn setSelected:NO];
   
    [sender setSelected:YES];
    _lastBtn=sender;
    _sliderView.value=sender.tag*2+_sliderView.minimumValue;
     _titleView.font=[UIFont systemFontOfSize: _sliderView.value];
//    for(UIButton *btn  in _buttons)
//        NSLog(@"tag=%ld",btn.tag);
}
+ (instancetype)oneView
{
    return [[NSBundle mainBundle]loadNibNamed:@"ZYHOneView" owner:self options:nil][0];
}
- (void)awakeFromNib
{
    [_buttons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:60 leadSpacing:15 tailSpacing:15];
    [_buttons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_sliderView).offset(-30);
        make.height.equalTo(@(50));
    }];
    [_blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@100);
        make.center.left.right.equalTo(self);
    }];
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(_blueView.mas_top).offset(-30);
        make.height.equalTo(@64);
    }];
    [_sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_blueView).offset(15);
        make.bottom.right.equalTo(_blueView).offset(-15);
    }];
    [_sliderView setThumbImage:[UIImage imageNamed:@"正文字号-滑块"] forState:UIControlStateNormal];
    [_sliderView setMaximumTrackImage:[UIImage imageNamed:@"正文字号-滑条"] forState:UIControlStateNormal];
    [_sliderView setMinimumTrackImage:[UIImage imageNamed:@"正文字号-滑条红"] forState:UIControlStateNormal];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
