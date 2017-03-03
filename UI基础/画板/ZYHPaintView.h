//
//  ZYHPaintView.h
//  helloworld
//
//  Created by Apple on 16/1/28.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYHPaintView : UIView
@property(nonatomic,assign) NSInteger width;
@property(nonatomic,strong) UIColor *color;
@property(nonatomic,strong) UIImage *image;

- (void)undo;
- (void)clearScreen;
- (void)erase;
- (void)photo;
- (void)save;
@end
