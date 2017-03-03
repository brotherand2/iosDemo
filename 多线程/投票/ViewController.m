//
//  ViewController.m
//  投票
//
//  Created by Apple on 2016/11/24.
//  Copyright © 2016年 Apple. All rights reserved.
//
#import "AFNetworking.h"
#import "ViewController.h"
#import "UIView+Extension.h"
#import "constant.h"
#import "UIColor+extention.h"
@interface ViewController ()
@property(nonatomic,strong) UILabel *succeeLabel;//显示成功
@property(nonatomic,assign) NSInteger successNum;


@property(nonatomic,strong) UILabel *failLabel;//显示成功
@property(nonatomic,assign) NSInteger failNum;


@property(nonatomic,strong) UILabel *votedLabel;//显示成功
@property(nonatomic,assign) NSInteger votedNum;

@property(nonatomic,strong) UIButton *voteBtn;
@property(nonatomic,strong) UITextView*textView;
@property(nonatomic,strong) NSString*chars;
@property(nonatomic,assign) NSInteger total;
@property(nonatomic,strong) NSMutableDictionary *result;
@property(nonatomic,assign) NSInteger currnetIndex;
@property(nonatomic,assign) NSInteger voteNum;
@property(nonatomic,assign) NSInteger lastIndex;
@property(nonatomic,copy)NSString *oid;
@end
@interface ViewController ()
@property(nonatomic,strong) AFHTTPRequestOperationManager *manager;

@end
NSTimer *timer;//进度条定时器
@implementation ViewController
- (AFHTTPRequestOperationManager *)manager
{
    if(nil==_manager)
        _manager=[AFHTTPRequestOperationManager manager];
    return _manager;
    
}
-(NSString*)currentDate
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYYMMdd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    voteFileName=[[NSUserDefaults standardUserDefaults] objectForKey:self.title];
    if(voteFileName==nil)
        voteFileName=@"new";
    companys= @{@"本公司":@"1417",@"7":@"1382",@"10":@"1385",@"28":@"1403",@"40":@"1415",@"44":@"1419"};
    _result=[NSMutableDictionary dictionary];
    self.chars=@"0123456789abcdef";
    timeIndex=[[NSUserDefaults standardUserDefaults] integerForKey:self.title];
    
    
    self.view.backgroundColor=[UIColor randomColor];
    NSString *path=[[NSBundle mainBundle]pathForResource:voteFileName ofType:@"json"];
    NSData *JSONData = [NSData dataWithContentsOfFile:path];
    NSDictionary *vote=[NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    phonenumbers=[NSMutableDictionary dictionaryWithDictionary:vote];
    keyIndex=[NSMutableArray array];
    [phonenumbers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [keyIndex addObject:key];
    }];
    groupNum=(phonenumbers.count+VotePerNum-1)/VotePerNum;
    [self read];
    //NSLog(@"votes=%@",phonenumbers);
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor=[UIColor grayColor];
    [self.view addSubview:btn];
    btn.center=CGPointMake(self.view.width*0.5, 20);
    
    [btn setTitle:@"开始投票" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:0];
    [btn addTarget:self action:@selector(beginVote) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
      _voteBtn=btn;
    
    UILabel *label=[[UILabel alloc]init];
    
    _succeeLabel=label;
    label.textAlignment=NSTextAlignmentLeft;
    label.textColor=[UIColor randomColor];
    [self.view addSubview:label];
    
    label=[[UILabel alloc]init];
    
    _failLabel=label;
    label.textAlignment=NSTextAlignmentLeft;
    label.textColor=[UIColor randomColor];
    [self.view addSubview:label];
    
    label=[[UILabel alloc]init];
    
    _votedLabel=label;
    label.textAlignment=NSTextAlignmentLeft;
    label.textColor=[UIColor randomColor];
    [self.view addSubview:label];
  
    
    _textView=[[UITextView alloc]init];
    _textView.text=@"此处显示投票信息";
    [self.view addSubview:_textView];
    
        _succeeLabel.x=_failLabel.x=_votedLabel.x=10;
    _succeeLabel.y=btn.y;
    [self initLabelInfo];
    [self adjustLabel];
    CGFloat textViewY=CGRectGetMaxY(_votedLabel.frame);
    _textView.frame=CGRectMake(10, textViewY+10, self.view.width-20, self.view.height-textViewY-10-64);

    // Do any additional setup after loading the view, typically from a nib.
}
- (void)initLabelInfo
{
    _succeeLabel.text=@"投票成功数:";
    _failLabel.text=@"投票失败数:";
    _votedLabel.text=@"已投数:";
     _successNum=0;
    _failNum=0;
    _votedNum=0;
    [_result removeAllObjects];
    _currnetIndex=rangeIndex*VotePerNum;
    if(rangeIndex==groupNum-1)
        _voteNum= phonenumbers.count-rangeIndex*VotePerNum;
    else
        _voteNum= VotePerNum;
    _lastIndex=_currnetIndex+_voteNum;
}
-(void)beginVote
{
    self.oid=companys[companyIndex];
    self.textView.text=[NSString stringWithFormat:@"公司 ID:%@,第%ld组开始投票中....",companyIndex, rangeIndex+1];
    //NSLog(@"%@",self.textView.text);
    //return;
    [self initLabelInfo];
    if(timeIndex==0)
    {
        for(int i=0;i<_voteNum;i++)
        {
            NSString *key=keyIndex[_currnetIndex];
            [self requestWithcookie:phonenumbers[key] userInfo:key];
            _currnetIndex++;
            
        }
    }
    else
        [self scheduleToVote];
   

}
-(void)scheduleToVote
{
    NSString *key=keyIndex[_currnetIndex];
    [self requestWithcookie:phonenumbers[key] userInfo:key];
    _currnetIndex++;
    [timer invalidate];
    NSInteger randomTime=[self getRandomTime];
    if(_currnetIndex<_lastIndex)
    {
        timer = [NSTimer timerWithTimeInterval:randomTime target:self selector:@selector(scheduleToVote) userInfo:nil repeats:NO];
         [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
    }
    self.textView.text=[NSString stringWithFormat:@"\%@\r\n%ld 秒后开始投票",self.textView.text,randomTime];
}
-(NSInteger)getRandomTime
{
    NSInteger time=3;
    switch (timeIndex)
    {
        case 1:
            time= 3+arc4random()%7;
            break;
        case 2:
            time= 5+arc4random()%25;
            break;
        case 3:
            time= 10+arc4random()%50;
            break;
        case 4:
            time= 30+arc4random()%90;
            break;
        case 5:
            time= 60+arc4random()%120;
            break;
    }
    
    return time;

}
- (NSString*)randomString
{
    NSMutableString *deviceID=[NSMutableString string];
    for(int i=0;i<32;i++)
    {
        [deviceID appendString:[self.chars substringWithRange:NSMakeRange(arc4random()%16, 1)]];
        
        
    }
    //NSLog(@"%@",deviceID);
    return deviceID;
}
- (void)requestWithcookie:(NSString*)cookie userInfo:(NSString*)userInfo
{//我上次注册要短信验证吗,现在
    NSString *urlStr = @"http://huodong.chinacici.com/m/vote/v1/user_add_option";
    NSDictionary *params = @{@"oid" : _oid, @"vid" : @"89",@"city_id":@"514000"};
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
      //[self.manager.requestSerializer setValue:@"Mozilla/5.0 (iPhone; CPU iPhone OS 10_0_1 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) Mobile/14A403iPhone_OS_10.0.1    WiseCICI00005140000000938c665b6c6e95f5fa6c0ebccfa1f67d010702" forHTTPHeaderField:@"User-Agent"];
    NSString *userAgent=[NSString stringWithFormat:@"Mozilla/5.0 (iPhone; CPU iPhone OS 10_0_1 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) Mobile/14A403iPhone_OS_10.0.1 WiseCICI00005140000000%@010702",[self randomString]];
     [self.manager.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    
     [self.manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    NSMutableURLRequest *request = [self.manager.requestSerializer requestWithMethod:@"POST" URLString:urlStr parameters:params error:nil];
    AFHTTPRequestOperation *operation = [self.manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        
        _result[operation.userInfo[@"user"]]=@"投票成功";
        NSInteger code=[responseObject[@"code"] integerValue];
        NSString *info=code==0?@"投票成功":responseObject[@"msg"];
        
        self.textView.text=[NSString stringWithFormat:@"\%@\r\n%@:%@",self.textView.text,operation.userInfo[@"user"],info];
        if(code==0)
        {
          _successNum++;
           _succeeLabel.text=[NSString stringWithFormat:@"投票成功票数:%ld",_successNum];
            _result[operation.userInfo[@"user"]]=@"投票成功";
        }
        else  if(code==2)
        {
            _votedNum++;
            _votedLabel.text=[NSString stringWithFormat:@"已投票数:%ld",_votedNum];
            _result[operation.userInfo[@"user"]]=@"已投票";
        }
        else
        {
            _failNum++;
            _failLabel.text=[NSString stringWithFormat:@"投票失败票数:%ld",_failNum];
            _result[operation.userInfo[@"user"]]=@"投票失败";
        }
        [self adjustLabel];
        [self hasRequestOne];
        NSLog(@"%@",operation.userInfo[@"user"]);
        //NSLog(@"%@===%@",responseObject,operation.userInfo);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        _result[operation.userInfo[@"user"]]=@"投票失败";
        NSLog(@"%@",error);//
        _failNum++;
        _failLabel.text=[NSString stringWithFormat:@"投票失败票数:%ld",_failNum];
        [self adjustLabel];
        self.textView.text=[NSString stringWithFormat:@"%@\r\n%@:投票失败%ld,错误码:%ld",self.textView.text,operation.userInfo[@"user"], (long)error.code];
        [self hasRequestOne];
    }];
    operation.userInfo=@{@"user":userInfo};
    [self.manager.operationQueue addOperation:operation];
    
 
}
- (void)hasRequestOne
{
    _total++;
    if(_total==VotePerNum)
    {
         voteds[@(rangeIndex)]=_result;
         [NSKeyedArchiver archiveRootObject:voteds toFile:[self savedatapath]];//先显示本地缓存的数据
        self.textView.text=[NSString stringWithFormat:@"\%@\r\n投票完毕,可查看投票状态",self.textView.text];
        
    }
}
-(NSString*)savedatapath
{
    NSString *fileName=[NSString stringWithFormat:@"%@.plist",[self currentDate]];
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSAllDomainsMask, YES) firstObject];
    libraryPath = [libraryPath stringByAppendingPathComponent:fileName];
    return libraryPath;
}

-(void)read
{
    NSDictionary *vote=[NSKeyedUnarchiver unarchiveObjectWithFile:[self savedatapath]];//先显示本地缓存的数据
    voteds=[NSMutableDictionary dictionary];
    if(vote)
        [ voteds setDictionary:vote];
}

- (void)adjustLabel
{
    [_succeeLabel sizeToFit];
    [_failLabel sizeToFit];
    [_votedLabel sizeToFit];
    _failLabel.y=CGRectGetMaxY(_succeeLabel.frame);
    _votedLabel.y=CGRectGetMaxY(_failLabel.frame);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
