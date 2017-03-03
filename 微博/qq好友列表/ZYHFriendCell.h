//
//  ZYHFriendCell.h
//  微博
//
//  Created by Apple on 15/12/17.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYHFriendModel;
@interface ZYHFriendCell : UITableViewCell
@property(nonatomic,strong)ZYHFriendModel *friendModel;
+ (instancetype)cellWithTableView:(UITableView*)tableView;
@end
