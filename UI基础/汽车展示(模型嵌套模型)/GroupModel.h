//
//  GroupModel.h
//  helloworld
//
//  Created by Apple on 15/11/28.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupModel : NSObject
@property (nonatomic,copy) NSString *title;
@property(nonatomic,strong)NSArray *cars;
- (instancetype)initWithDict:(NSDictionary*)dict;
+ (instancetype)groupWithDict:(NSDictionary*)dict;
@end
