//
//  CarGroup.h
//  helloworld
//
//  Created by Apple on 15/11/28.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarGroup : NSObject
@property(nonatomic,strong)NSArray *cars;
@property(nonatomic,copy)NSString* title;
@property(nonatomic,copy)NSString*desc;
-(instancetype)initWithDict:(NSDictionary*)dict;
+(instancetype)carGroupWithDict:(NSDictionary*)dict;
@end
