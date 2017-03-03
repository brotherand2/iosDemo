//
//  HMMicroBlogCell.m
//  13-autolayout实现微博
//
//  Created by itheima on 15/9/26.
//  Copyright (c) 2015年 heima. All rights reserved.
//

#import "HMMicroBlogCell.h"
#import "HMMicroBlog.h"
@interface HMMicroBlogCell()
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *textView;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pictureViewHlc;

@end

@implementation HMMicroBlogCell

-(void)setMicroBlog:(HMMicroBlog *)microBlog{
    
    _microBlog = microBlog;
    
    self.headView.image = [UIImage imageNamed:microBlog.icon];
    self.nameView.text = microBlog.name;
    self.textView.text = microBlog.text;
    
    if (microBlog.picture) {
        self.pictureView.image = [UIImage imageNamed:microBlog.picture];
        self.pictureView.hidden = NO;
        self.pictureViewHlc.constant = 50;
    }else{
        
        self.pictureView.hidden = YES;
        self.pictureViewHlc.constant = 0;
    }
}

@end
