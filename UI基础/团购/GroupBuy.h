//
//  GroupBuy.h
//  helloworld
//
//  Created by Apple on 15/11/28.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupBuy : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *buyCount;
- (instancetype)initWithDict:(NSDictionary*)dict;
+ (instancetype)groupWithDict:(NSDictionary*)dict;

@end
