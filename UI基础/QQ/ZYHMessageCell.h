//
//  ZYHMessageCell.h
//  helloworld
//
//  Created by Apple on 15/12/15.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "ZYHMessage.h"

@interface ZYHMessageCell : UITableViewCell
@property(nonatomic,weak)UILabel *timeView;
@property(nonatomic,weak)UIImageView *headView;
@property(nonatomic,weak)UIButton *textView;
@property(nonatomic,strong)ZYHMessage *message;
+(instancetype)cellWithTableView:(UITableView*)tableView;
@end
