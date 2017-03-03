//
//  ZYHFlagView.h
//  helloworld
//
//  Created by Apple on 16/1/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYHFlagModal;
@interface ZYHFlagView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property(nonatomic,strong) ZYHFlagModal *flagModal;
+ (instancetype)flagView:(UIView*)reuseView;
+ (CGFloat)viewHeigh;
@end
