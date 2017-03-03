//
//  UIBarButtonItem+extention.h
//  兔小贝儿歌
//
//  Created by Apple on 16/3/28.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (extention)

/**
 *  通过图片创建item
 *
 *  @param image     图片
 *  @param highImage 高亮图片
 *  @param action    点击后调用的方法
 */
+ (instancetype)itemWithImageName:(NSString*)imageName highlightImageName:(NSString*)highlightName
                           target:(id)target action:(SEL)action;
/**
 *  通过图片创建item
 *
 *  @param image     图片
 *  @param highImage 高亮图片
    @param dotImageName   右上角的红点图片
 *  @param action    点击后调用的方法
 */
+ (instancetype)itemWithImageName:(NSString*)imageName highlightImageName:(NSString*)highlightName
                         dotImage:(NSString*)dotImageName
                           target:(id)target action:(SEL)action;


@end
@interface DotButton : UIButton
@property (weak, nonatomic)UIImageView *dotView;
@end
