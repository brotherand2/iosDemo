//
//  ZYHContactModal.h
//  helloworld
//
//  Created by Apple on 16/1/20.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYHContactModal : NSObject<NSCoding>
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *phone;
+ (instancetype)contactWithName:(NSString*)name andPhone:(NSString*)phone;
@end
