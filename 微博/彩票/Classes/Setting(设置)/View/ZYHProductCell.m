//
//  ZYHProductCell.m
//  微博
//
//  Created by Apple on 16/2/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHProductCell.h"
@interface ZYHProductCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *labelView;

@end

@implementation ZYHProductCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    _imageView.layer.cornerRadius=10;
    _imageView.layer.masksToBounds=YES;
}
- (void)setModal:(ZYHProductModal *)modal
{
    _modal=modal;
    modal.icon=[modal.icon stringByReplacingOccurrencesOfString:@"@2x.png" withString:@""];

    _imageView.image=[UIImage imageNamed:modal.icon];
    _labelView.text=modal.title;
}
@end
