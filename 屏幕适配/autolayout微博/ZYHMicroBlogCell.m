//
//  ZYHMicroBlogCell.m
//  微博
//
//  Created by Apple on 15/12/19.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ZYHMicroBlogCell.h"
#import "HMMicroBlog.h"
@implementation ZYHMicroBlogCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setMicroBlog:(HMMicroBlog *)microBlog
{
    _microBlog=microBlog;
    self.image.image=[UIImage imageNamed:microBlog.icon];
    self.name.text=microBlog.name;
    self.text.text=microBlog.text;
    if(microBlog.picture)
    {
        self.picture.image=[UIImage imageNamed:microBlog.picture];
        self.picture.hidden=NO;
        self.pictureViewHLc.constant=50;
    }
    else
    {
        self.picture.hidden=YES;
        self.pictureViewHLc.constant=0;
    }
    
}
@end
