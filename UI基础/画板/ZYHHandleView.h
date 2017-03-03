//
//  ZYHHandleView.h
//  helloworld
//
//  Created by Apple on 16/1/28.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ZYHHandleViewBlock)(UIImage *imageName) ;
@interface ZYHHandleView : UIView<UIGestureRecognizerDelegate>
@property(nonatomic,strong) UIImage *image;
@property (weak, nonatomic)UIImageView*imageView;
@property(nonatomic,copy) ZYHHandleViewBlock handleBlock;
@end
