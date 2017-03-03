//
//  constant.h
//  多线程
//
//  Created by Apple on 2016/11/26.
//  Copyright © 2016年 Apple. All rights reserved.
//
#import <Foundation/Foundation.h>
extern  NSMutableDictionary *phonenumbers;//号码
extern NSInteger timeIndex;//投票时间索引,如3-60,1表示30-180
extern NSInteger rangeIndex;//投票时间索引,如0表示1-20,1表示21-40
extern NSInteger groupNum;
extern  NSMutableDictionary *voteds;// 已投票的数据
extern NSMutableArray *keyIndex;
extern NSString *companyIndex;
extern NSInteger voteFileIndex;
extern NSDictionary *companys;
extern NSString *voteFileName;
#define VotePerNum   40
