//
// 文件名： ZYHCell.h
// 项目名： 多线程
// 创建者：Apple
// 日期时间 :16/2/18 21:18
//  版权：  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModal.h"
@interface ZYHCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView*)tableView;
@property(nonatomic,strong) VideoModal *modal;
@end
