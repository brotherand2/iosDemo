//
//  HeroModel.h
//  helloworld
//
//  Created by Apple on 15/11/28.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeroModel : NSObject
@property(nonatomic,copy)NSString *icon;

@property(nonatomic,copy)NSString*name;
@property(nonatomic,copy)NSString*intro;
- (instancetype)initWithDict:(NSDictionary*)dict;
+(instancetype)heroWithDict:(NSDictionary*)dict;
@end
