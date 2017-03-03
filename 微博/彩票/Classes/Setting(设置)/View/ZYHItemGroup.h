//
//  ZYHItemGroup.h
//  微博
//
//  Created by Apple on 16/2/5.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYHItemGroup : NSObject
@property(nonatomic,copy)NSString *headTitle;
@property(nonatomic,copy)NSString *footTitle;
@property(nonatomic,strong) NSArray *items;
@end
