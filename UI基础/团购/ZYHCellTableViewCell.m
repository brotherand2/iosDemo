//
//  ZYHCellTableViewCell.m
//  helloworld
//
//  Created by Apple on 15/11/29.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ZYHCellTableViewCell.h"
#include "GroupBuy.h"
@interface ZYHCellTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *priceView;
@property (weak, nonatomic) IBOutlet UILabel *buyCountView;

@end
@implementation ZYHCellTableViewCell

- (void)setGroup:(GroupBuy *)group
{
    _group=group;
    self.headView.image=[UIImage imageNamed:group.icon];
    self.priceView.text=[NSString stringWithFormat:@"$%@",group.price];
    self.nameView.text=group.title;
    self.buyCountView.text=[NSString stringWithFormat:@"已经购买了%@",group.buyCount] ;
}
@end
