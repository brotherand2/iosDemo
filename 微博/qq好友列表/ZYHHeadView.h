//
//  ZYHHeadView.h
//  微博
//
//  Created by Apple on 15/12/17.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYHHeadView,ZYHGroupFriend;
@protocol ZYHHeadViewDelegate<NSObject>
//头部视图代理，使用代理是因为可能有多个tableView要使用这个头部视力，使头部视力不依赖于任何一个tableView而存在，每一个tableview都可作为代理重写通知操作的方法，进行定制
@optional
-  (void)headViewNameViewDidClik:(ZYHHeadView*)headView;//头部视图中名字视图被点击
@end
@interface ZYHHeadView : UITableViewHeaderFooterView
@property(nonatomic,strong)ZYHGroupFriend *groupFriend;
@property(nonatomic,weak)id <ZYHHeadViewDelegate>delegate;

@property(nonatomic,weak)UILabel  *onlineView;
@property(nonatomic,weak)UIButton *nameView;
+ (instancetype)headViewWithTableView:(UITableView*)tableview;
@end
