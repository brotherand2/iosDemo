//
//  ZYHAppCell.h
//  微博
//
//  Created by Apple on 15/12/17.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYHAppModal;
@interface ZYHAppCell : UITableViewCell
@property(nonatomic,strong)ZYHAppModal *appModal;

+ (instancetype)cellWithTableView:(UITableView*)tableView;
@end
