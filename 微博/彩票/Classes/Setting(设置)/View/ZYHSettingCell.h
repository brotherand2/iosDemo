//
//  ZYHSettingCell.h
//  微博
//
//  Created by Apple on 16/2/5.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYHSettingItem.h"
@interface ZYHSettingCell : UITableViewCell
@property(nonatomic,strong) ZYHSettingItem *item;

+ (instancetype)cellWithTableView:(UITableView *)cell andItem:(ZYHSettingItem*)item;
@end
