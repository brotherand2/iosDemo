//
//  ZYHKeyboardTool.m
//  UIWindow
//
//  Created by Apple on 16/1/17.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHKeyboardTool.h"

@implementation ZYHKeyboardTool
+ (instancetype)keyboard
{
    return [[[NSBundle mainBundle]loadNibNamed:@"ZYHKeyboardTool" owner:nil options:nil]lastObject];
}
- (IBAction)previousField:(id)sender
{
    if(self.clickItem)
    self.clickItem(ZYHKeyboardPrevious);
}
- (IBAction)nextField:(id)sender
{
    if(self.clickItem)
    self.clickItem(ZYHKeyboardNext);
}
- (IBAction)finish:(id)sender
{
    if(self.clickItem)
    self.clickItem(ZYHKeyboardFinish);
}
@end
