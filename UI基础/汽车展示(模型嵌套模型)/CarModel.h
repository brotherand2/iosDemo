//
//  CarModel.h
//  helloworld
//
//  Created by Apple on 15/11/28.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *icon;
- (instancetype)initWithDict:(NSDictionary*)dict;
+ (instancetype)carWithDict:(NSDictionary*)dict;
@end
