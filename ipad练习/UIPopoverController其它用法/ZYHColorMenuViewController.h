//
//  ZYHColorMenuViewController.h
//  ipad练习
//
//  Created by Apple on 16/3/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Action)(UIColor *color);
@interface ZYHColorMenuViewController : UITableViewController

@property(nonatomic,copy)Action selectRow;
@end
