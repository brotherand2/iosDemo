//
//  ZYHMicroBlogCell.h
//  helloworld
//
//  Created by Apple on 15/12/1.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYHMicroBlogData;
@interface ZYHMicroBlogCell : UITableViewCell
@property(nonatomic,weak)UIImageView *headView;
@property(nonatomic,weak)UILabel *nameView;
@property(nonatomic,weak)UIImageView*vipView;
@property(nonatomic,weak)UILabel*textView;
@property(nonatomic,weak)UIImageView*pictureView;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setMicroBlogData:(ZYHMicroBlogData*)data;
@end
