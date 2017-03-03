//
//  ZYHFriendCell.m
//  微博
//
//  Created by Apple on 15/12/17.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ZYHFriendCell.h"
#import "ZYHFriendModel.h"
@implementation ZYHFriendCell
//获取cell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
     static NSString *identifier=@"friend";
    ZYHFriendCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil)
        cell=[[ZYHFriendCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    return  cell;
}
- (void)setFriendModel:(ZYHFriendModel *)friendModel
{
    _friendModel=friendModel;
    self.textLabel.text=friendModel.name;
    self.detailTextLabel.text=friendModel.intro;
    self.imageView.image=[UIImage imageNamed:friendModel.icon];
    self.textLabel.textColor=friendModel.isVip?[UIColor redColor]:[UIColor   
                                                            blackColor];
}
@end
