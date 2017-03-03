//
//  ZYHWheelView.h
//  微博
//
//  Created by Apple on 16/2/4.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYHWheelView : UIView
+ (instancetype)wheel;
- (IBAction)start:(id)sender;
-  (void)startRotate;
-  (void)stopRotate;
@end
