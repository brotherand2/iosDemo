//
//  ZYHMicroBlogCell.h
//  微博
//
//  Created by Apple on 15/12/19.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMMicroBlog;
@interface ZYHMicroBlogCell : UITableViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pictureViewHLc;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UIImageView*image;
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property(nonatomic,strong)HMMicroBlog*microBlog;
@end
