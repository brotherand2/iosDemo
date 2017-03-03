//
//  ZYHFootView.h
//  helloworld
//
//  Created by Apple on 15/11/29.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYHFootView;
@protocol ZYHFootViewDelegate<NSObject>
@optional
- (void)footerViewLoadDidClick:(ZYHFootView*)footerView;
@end
@interface ZYHFootView : UIView
@property(nonatomic,weak)id<ZYHFootViewDelegate>delegate;
@end
