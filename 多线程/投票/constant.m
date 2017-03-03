//
//  constant.m
//  多线程
//
//  Created by Apple on 2016/11/26.
//  Copyright © 2016年 Apple. All rights reserved.
//
#import "constant.h"

NSInteger groupNum;
NSMutableDictionary *phonenumbers;
NSInteger timeIndex=0;//投票时间索引,如3-60,1表示30-180
NSInteger rangeIndex=0;//投票时间索引,如0表示1-20,1表示21-40
NSMutableDictionary *voteds;// 已投票的数据
NSMutableArray *keyIndex;
NSString *companyIndex=@"本公司";
NSString *voteFileName=@"new";
NSInteger voteFileIndex=0;
NSDictionary *companys;
