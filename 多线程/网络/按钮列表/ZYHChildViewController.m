//
//  ZYHChildViewController.m
//  多线程
//
//  Created by Apple on 16/2/9.
//  Copyright © 2016年 Apple. All rights reserved.
//
#import "ZYHDownloadViewController.h"
#import "ZYHChildViewController.h"
#import "ZYHView.h"
#import "ViewController.h"
#import "VideoController.h"
#import "NSArray+extention.h"
#import "JSONKit.h"
#import "ZYHVideoModal.h"
#import "GDataXMLNode.h"
#import "NSMutableURLRequest+extention.h"
#import "ZYHVideoController.h"
#import "SSZipArchive.h"
#import "AFNetworking.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ASIDownloadCache.h"
#import "DACircularProgressView.h"
#import "UIColor+extention.h"
#import "ZYHWebViewController.h"
#import "ZYHWebViewTestController.h"
#import "NSArray+extention.h"
@interface ZYHChildViewController ()<ASIHTTPRequestDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
@public
    CGFloat screenw;
    CGFloat screenH;
}
@property (weak, nonatomic)ZYHView *childView;
@property (weak, nonatomic)UIImageView *imageView;
@property(nonatomic,strong) UIWebView *webView;
@property (weak, nonatomic)UILabel *label;
@property (strong, nonatomic)  UIStoryboard *storyBoard;
@property(nonatomic,strong) AFHTTPRequestOperationManager *manager;
@property(nonatomic,strong) ASIHTTPRequest *asiRequest;
@property (weak, nonatomic)DACircularProgressView *progressView;
@end

@implementation ZYHChildViewController
- (AFHTTPRequestOperationManager *)manager
{
    if(nil==_manager)
        _manager=[AFHTTPRequestOperationManager manager];
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];

    CGSize size=[UIScreen mainScreen].bounds.size;
    screenw=size.width;
    screenH=size.height;
    UIBarButtonItem *over=[[UIBarButtonItem alloc]initWithTitle:@"开始" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem=over;
    ZYHView *view=[[ZYHView alloc]init];
    self.childView=view;
    view.tag=self.tag;
    //NSLog(@"%ld",self.view.tag);
    [view setBackgroundColor:[UIColor grayColor]];
    [self.view setBackgroundColor:[UIColor grayColor]];
    view.frame=self.view.frame;
    UILabel *label=[[UILabel alloc]initWithFrame:self.view.bounds];
    label.textAlignment=NSTextAlignmentLeft;
    label.textColor=[UIColor redColor];
    label.numberOfLines=0;
    //label.backgroundColor=[UIColor yellowColor];
    self.label=label;
    
    [_childView addSubview:label];
    [self myViewInit];
    [self.view addSubview:view];

}

- (void)myViewInit
{
    switch (self.tag)
    {
        case 35:
        case 39:
        {
            DACircularProgressView *view=[[DACircularProgressView alloc]init];
            view.bounds=CGRectMake(0, 0, 200, 200);
            view.center=_childView.center;
            view.trackTintColor=[UIColor randomColor];
            view.progressTintColor=[UIColor randomColor];
            [_childView addSubview:view];
            self.progressView=view;
        };
            break;
        default:
        {
            if (10==self.tag)
            {
                NSDictionary *dict=@{NSFontAttributeName:[UIFont systemFontOfSize:22],
                                     NSForegroundColorAttributeName:[UIColor redColor]             };
                
                [self.navigationItem.rightBarButtonItem setTitle:@"开始"];
                [self.navigationItem.rightBarButtonItem setTitleTextAttributes:dict forState:UIControlStateNormal];
            }

        }
            break;
    }

   }
# define  MYcase(i)\
case (i):\
{\
    [self test##i];\
};\
break;

- (void)cancel
{
    switch (self.tag)
    {
        case 0:
        {
            [self test];
        }
            break;
            MYcase(1)
            MYcase(2)
            MYcase(3)
            MYcase(4)
            MYcase(5)
            MYcase(6)
            MYcase(7)
            MYcase(8)
            MYcase(9)
            MYcase(10)
            MYcase(11)
            MYcase(12)
            MYcase(13)
            MYcase(14)
            MYcase(15)
            MYcase(16)
            MYcase(17)
            MYcase(18)
            MYcase(19)
            MYcase(20)
            MYcase(21)
            MYcase(22)
            MYcase(23)
            MYcase(24)
            MYcase(25)
            MYcase(26)
            MYcase(27)
            MYcase(28)
            MYcase(29)
            MYcase(30)
            MYcase(31)
            MYcase(32)
            MYcase(33)
            MYcase(34)
            MYcase(35)
            MYcase(36)
            MYcase(37)
            MYcase(38)
            MYcase(39)
            MYcase(40)
            MYcase(41)
            MYcase(42)
            MYcase(43)
            MYcase(44)
            MYcase(45)
            MYcase(46)
    }

}
#pragma mark--@"最常见网络访问方法"
- (void)test
{
    _webView=[[UIWebView alloc]initWithFrame:_childView.bounds];
    [_childView addSubview:_webView];

    NSURL *url=[NSURL URLWithString:@"http://m.baidu.com"];
    // NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    
    // 告诉服务器一些附加信息，我的手机是iPhone，请给我返回iPhone对应的网页
    [request setValue:@"Mozilla/5.0 (iPhone; CPU iPhone OS 8_1_1 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko)" forHTTPHeaderField:@"User-Agent"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        [data writeToFile:@"/Users/apple/Desktop/123.html" atomically:YES];
        NSString *html=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",html);
        [_webView loadHTMLString:html baseURL:nil];
    }];

}
#pragma mark--,@"网络连接"
- (void)test1
{
    NSString *urlStr=[NSString stringWithFormat:@"http://%@/demo.json",IPAdd];
    NSURL *url=[NSURL URLWithString:urlStr];
    /*
     参数：url：资源路径
     cachePolicy：缓存策略
     NSURLRequestUseProtocolCachePolicy = 0, // 默认缓存策略，会自动缓存
     
     NSURLRequestReload(刷新)Ignoring(忽略)Local(本地)CacheData(缓存数据) = 1, 每次都从服务器去加载数据。忽略本地缓存
     
     **** 底下两个 一般来离线访问。一般配合Reachability(苹果提供的检测网络连接的框架)使用
     // 如果用户使用的wifi，就使用这个策略
     NSURLRequestReturnCacheDataElseLoad = 2, // 如果有缓存，就用缓存。没有就上网加载
     // 如果用户使用的3G，就使用下面的策略
     NSURLRequestReturnCacheDataDontLoad = 3, // 如没有缓存，就用缓存。没有返回空，死活不上网
     
     
     timeoutInterval：超时时间，默认是60秒，一般设置15～20秒。超过这个时间以后，如果服务器还没有相应，就不继续等待了
     SDWebImage超时时长设置的是-->15秒
     AFN超时时长 60秒
     */
    NSURLRequest *request=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError||data==nil) {
            NSLog(@"error=%@",connectionError);
        }
        // NSLog(@"%@",data);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            
            _label.text=str;
           
            NSLog(@"update ui:%@",str);
        });
    }];

}
#pragma mark--,@"json反序列
- (void)test2
{
    NSString *urlStr=[NSString stringWithFormat:@"http://%@/videos.json",IPAdd];
    NSURL *url=[NSURL URLWithString:urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
   NSData *data= [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:NULL];
    /**
     NSJSONReadingMutableContainers = (1UL << 0), 容器是可变的，转成的结果是可变的类型
     NSJSONReadingMutableLeaves = (1UL << 1),     叶子节点是可变的
     NSJSONReadingAllowFragments = (1UL << 2)     允许根节点 可以不是NSArray，NSDictionary
     枚举类型，一般使用位移的，传0，什么事情都不做
     */

    id result=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
    NSLog(@"%@--%@",result,[result class]);
    NSString *str=[NSString stringWithFormat:@"%@--%@",result,[result class]];
    
    _label.text=str;
    
}
#pragma mark--JSONKit解析数据
- (void)test3
{
    NSString *urlStr=[NSString stringWithFormat:@"http://%@/videos.json",IPAdd];
    NSURL *url=[NSURL URLWithString:urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
          if(connectionError||data==nil)
              return ;
        NSLog(@"%@",[[JSONDecoder decoder]objectWithData:data]);
        NSString *str=[NSString stringWithFormat:@"%@",[[JSONDecoder decoder]objectWithData:data]];
        
        _label.text=str;
    }];
}
#pragma mark--Plist反序列化
- (void)test4
{
    NSString *urlStr=[NSString stringWithFormat:@"http://%@/videos.plist",IPAdd];
    NSURL *url=[NSURL URLWithString:urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(connectionError||data==nil)
            return ;
        id result= [ NSPropertyListSerialization propertyListWithData:data options:0 format:NULL error:NULL];
        NSLog(@"%@====%@",result,[result class]);
        NSString *str=[NSString stringWithFormat:@"%@--%@",result,[result class]];
        
        _label.text=str;

    }];

}
#pragma mark--xml解析
- (void)test5
{
    
    VideoController *VC=[_storyBoard instantiateViewControllerWithIdentifier:@"video"];
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark--模型中数值应为NSNumber
- (void)test6
{
    NSString *urlStr=[NSString stringWithFormat:@"http://%@/demo.json",IPAdd];
    NSURL *url=[NSURL URLWithString:urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(connectionError||data==nil)
            return ;
        id result=[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        NSLog(@"result=%@",result);
        ZYHMessageModal *modal=[ZYHMessageModal messageWithDict:result];
        NSLog(@"%@",modal);
        NSString *str=[NSString stringWithFormat:@"%@--%@",result,[result class]];
        
        _label.text=str;

    }];

}
#pragma mark--XML解析（DOM模型）
- (void)test7
{
    NSString *urlStr=[NSString stringWithFormat:@"http://192.168.191.4/videos.xml",IPAdd];
    NSURL *url=[NSURL URLWithString:urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(connectionError||data==nil)
            return ;
        GDataXMLDocument *document=[[GDataXMLDocument alloc]initWithData:data error:NULL];
        NSMutableArray *videos=[NSMutableArray array];
        for(GDataXMLElement *element in document.rootElement.children)
        {
            ZYHVideoModal *modal=[[ZYHVideoModal alloc]init];
            for(GDataXMLNode *node in element.children)
                [modal setValue:node.stringValue forKeyPath:node.name];
            for (GDataXMLNode *attri in element.attributes) {
                [modal setValue:attri.stringValue forKeyPath:attri.name];
            }
            //NSLog(@"%@",modal);
            [videos addObject:modal];
        }
        NSLog(@"%@",videos);
        NSString *str=[NSString stringWithFormat:@"%@",videos];
        
        _label.text=str;

    }];

}
#pragma mark--GET用户登录
- (void)test8
{
    NSString *userName=@"张三";
    NSString *pwd=@"zhang";
    NSString *urlPath=[NSString stringWithFormat:@"http://%@/login.php?username=%@&password=%@",IPAdd, userName,pwd];
    // url里面不能包含中文空格特殊符号
    // 如果有，需要百分号转义
    urlPath=[urlPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlPath];
    NSURLRequest *request=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(connectionError||data==nil)
            return ;
        id returnRusult=[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        NSLog(@"%@",returnRusult);
        NSString *str=[NSString stringWithFormat:@"%@",returnRusult];
        
        _label.text=str;

    }];

}
#pragma mark--POST用户登录
- (void)test9
{
    NSString *userName=@"zhangsan";
    NSString *pwd=@"zhang";
    NSString *urlPath=[NSString stringWithFormat:@"http://%@/login2.php",IPAdd] ;
    NSURL *url=[NSURL URLWithString:urlPath];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15];
    request.HTTPMethod=@"POST";
    //request.HTTPBody=[[NSString stringWithFormat:@"username=%@&password=%@",userName,pwd] dataUsingEncoding:NSUTF8StringEncoding]  ;
    NSLog(@"%@", [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]);

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(connectionError)
            NSLog(@"%@",connectionError);
        if(connectionError||data==nil)
            return ;
        id returnRusult=[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        NSLog(@"%@",returnRusult);
        NSString *str=[NSString stringWithFormat:@"%@",returnRusult];
        
        _label.text=str;
    }];

}
#pragma mark--POST上传
- (void)test10
{
    static NSString *boundary=@"zyhupload";
    NSString *urlStr=[NSString stringWithFormat:@"http://%@/post/upload.php",IPAdd];
    NSURL *url=[NSURL URLWithString:urlStr];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15];
    request.HTTPMethod=@"POST";
    //设置请求头
    NSString *requestHead=[NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request setValue:requestHead forHTTPHeaderField:@"Content-Type"];
    NSMutableData *data=[NSMutableData data];
    /*
     -----------------------------19104593352062037048565570450
     Content-Disposition: form-data; name="userfile"; filename="test.json"
     Content-Type: application/json
     
     {
     "name" : "jack",
     "age"  : 20,
     "height" : 1.85,
     "school" : {
     "name" : "HM",
     "address" : "中关村软件园"
     },
     "photos" : [
     {
     "icon" : "beauty.png",
     "time" : "2014-01-01"
     },
     {
     "icon" : "nice.png",
     "time" : "2014-02-07"
     },
     {
     "icon" : "good.png",
     "time" : "2014-05-06"
     }
     ]
     }
     -----------------------------19104593352062037048565570450--
     */
    //设置请求体
    NSString *fileName=@"test.png";
    NSString *str=[NSString stringWithFormat:@"--%@\r\n",boundary];
    [data appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    str=[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@\"\r\nContent-Type: application/octet-stream\r\n\r\n",fileName];
    [data appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *path=[[NSBundle mainBundle]pathForResource:@"1166593.jpg" ofType:nil];
    [data appendData:[NSData dataWithContentsOfFile:path]];
    str=[NSString stringWithFormat:@"\r\n--%@--",boundary];
    [data appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    request.HTTPBody=data;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"%@",connectionError);
        if(connectionError||data==nil)
            return ;
        id result=[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        NSLog(@"result=%@",result);
        NSString *str=[NSString stringWithFormat:@"%@",result];
        
        _label.text=str;
    }];

}
#pragma mark--POST上传封装
- (void)test11
{
    NSString *path=[[NSBundle mainBundle]pathForResource:@"1166593.jpg" ofType:nil];
    NSString *urlStr=[NSString stringWithFormat:@"http://%@:8080/MJServer/upload",IPAdd];
    [NSMutableURLRequest upload:@"file" fileName:@"zyh.png" urlStr:urlStr data:[NSData dataWithContentsOfFile:path] params:@{@"username":@"zyh"}];
}
#pragma mark--POST上传JSON
- (void)test12
{
    NSDictionary *dict1=@{@"username":@"ZHANGSAN",@"age":@17};
    NSDictionary *dict2=@{@"username":@"lisi",@"age":@12};
    NSArray *array=@[dict1,dict2];
    NSString *urlStr=[NSString stringWithFormat:@"http://%@/post/postjson.php",IPAdd];
    NSURL *url=[NSURL URLWithString:urlStr];
    if(![NSJSONSerialization isValidJSONObject:array])
    {
        NSLog(@"格式不正确，不能被序列化");
        return;
    }
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15];
    request.HTTPMethod=@"POST";
    request.HTTPBody=[NSJSONSerialization dataWithJSONObject:array options:0 error:NULL];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(connectionError||data==nil)
            return ;
        id result=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"result=%@",result);
        NSString *str=[NSString stringWithFormat:@"%@",result];
        
        _label.text=str;
    }];

}
#pragma mark--直接下载
/*
 问题：
 1. 没有办法跟踪到下载的进度
 2. 会出现内存峰值
 
 解决办法
 1. 通过代理方法跟踪下载进度
 2. 每次接收到数据之后拼接数据
*/
- (void)test13
{
    NSString *urlStr=[NSString stringWithFormat: @"http://%@/01-知识点回顾.mp4",IPAdd];
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(connectionError)
            NSLog(@"%@",connectionError);
        if(connectionError||data==nil)
            return ;
        [data writeToFile:@"/Users/apple/Desktop/a.mp4" atomically:YES];
    }];

}
#pragma mark--NSURLConnection-GET请求"
- (void)test14
{
    ViewController *VC=[_storyBoard instantiateViewControllerWithIdentifier:@"loginView"];
    VC.loginType=ZYHLoginGet;
    [self.navigationController pushViewController:VC animated:YES];
    
}
#pragma mark--NSURLConnection-GET请求代理
- (void)test15
{
    ViewController *VC=[_storyBoard instantiateViewControllerWithIdentifier:@"loginView"];
    VC.loginType=ZYHLoginGetWithDelegate;
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark--NSURLConnection-POST请求"
- (void)test16
{
    
    
    ViewController *VC=[_storyBoard instantiateViewControllerWithIdentifier:@"loginView"];
    VC.loginType=ZYHLoginPost;
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark--黑酷
- (void)test17
{
    ZYHVideoController *VC=[[ZYHVideoController alloc]init];
    VC.title=@"视频列表";
     [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark--大文件下载
- (void)test18
{
    
    ZYHDownloadViewController *VC=[_storyBoard instantiateViewControllerWithIdentifier:@"download"];
    VC.action=ZYHDownloadVideo;
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark--压缩与解压缩
- (void)test19
{
    ZYHDownloadViewController *VC=[_storyBoard instantiateViewControllerWithIdentifier:@"download"];
    VC.action=ZYHDownloadZip;
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark--多线程下载
- (void)test20
{
    ZYHDownloadViewController *VC=[_storyBoard instantiateViewControllerWithIdentifier:@"download"];
    VC.action=ZYHDownloadMultiThread;
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark--URLSeccion的使用
- (void)test21
{
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/videos.json",IPAdd]];
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionDataTask *task=[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        id result=[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        NSString *str=[NSString stringWithFormat:@"%@ \r\n%@",result,[NSThread currentThread]];
        NSLog(@"%@",str);
        self.label.text=str;
    }];
    [task resume];
}
#pragma mark--URLSeccion下载
- (void)test22
{
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/videos.zip",IPAdd]];
    [[[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"lacation=%@  %@",location.path,[NSThread currentThread]);
        NSString *cachesPath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        [SSZipArchive unzipFileAtPath:location.path toDestination:cachesPath];
    }] resume];
}
#pragma mark--URLSeccion跟综进度
- (void)test23
{
    ZYHDownloadViewController *VC=[_storyBoard instantiateViewControllerWithIdentifier:@"download"];
    VC.action=ZYHDownloadURLSeccion;
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark--AFN Get登录
- (void)test24
{
     NSString *urlStr = @"http://127.0.0.1:8080/MJServer/login?username=123&pwd=123";
    [self.manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.label.text=[NSString stringWithFormat:@"%@ --%@",responseObject,[NSThread currentThread]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.label.text=[NSString stringWithFormat:@"%@ --%@",error,[NSThread currentThread]];
    }];
    
}
#pragma mark--AFN Get登录2
- (void)test25
{
     NSString *urlStr = @"http://127.0.0.1:8080/MJServer/login";
    NSDictionary *params = @{@"pwd" : @"111", @"username" : @"123"};
    [self.manager GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.label.text=[NSString stringWithFormat:@"%@ --%@",responseObject,[NSThread currentThread]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.label.text=[NSString stringWithFormat:@"%@ --%@",error,[NSThread currentThread]];
    }];
}
#pragma mark--AFN POST登录
- (void)test26
{
    NSString *urlStr = @"http://127.0.0.1:8080/MJServer/login";
    NSDictionary *params = @{@"pwd" : @"123", @"username" : @"123"};
    [self.manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.label.text=[NSString stringWithFormat:@"%@ --%@",responseObject,[NSThread currentThread]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.label.text=[NSString stringWithFormat:@"%@ --%@",error,[NSThread currentThread]];
    }];
}
#pragma mark--AFN XML
- (void)test27
{
    // 指定我们的响应的解析器是解析XML （会返回NSXMLParser:对象）也就是需要SAX方式手动解析
        self.manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
//    AFHTTPResponseSerializer   二进制
//    AFJSONResponseSerializer   JSON  (默认的数据格式)
//    AFXMLParserResponseSerializer  XML的解析器
//    AFImageResponseSerializer  Image

    // 假如想使用DOM进行解析XML，可以指定响应的类型是二进制。拿到二进制数据就可以进行DOM解析
    //self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlStr = @"http://127.0.0.1/videos.xml";
    [self.manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.label.text=[NSString stringWithFormat:@"%@ --%@",responseObject,[NSThread currentThread]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.label.text=[NSString stringWithFormat:@"%@ --%@",error,[NSThread currentThread]];
    }];

}
#pragma mark--AFN 上传
- (void)test28
{
    NSString *urlStr=[NSString stringWithFormat:@"http://%@/post/upload.php",IPAdd];
    [self.manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        /**
         FileURL:要上传的文件的url
         name: 上传到服务器，接受这个图片的字段名
         fileName ：  这个文件在服务器的名称
         mimeType: 表示要上传的文件的类型
         格式： 大类/小类
         JPG image/jpg
         PNG image/png
         JSON application/json
         
         */

        NSURL *url=[[NSBundle mainBundle]URLForResource:@"1037531.png" withExtension:nil];
        [formData appendPartWithFileURL:url name:@"userfile" fileName:@"tes.png" mimeType:@"image/png" error:NULL];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.label.text=[NSString stringWithFormat:@"%@ --%@",responseObject,[NSThread currentThread]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.label.text=[NSString stringWithFormat:@"%@ --%@",error,[NSThread currentThread]];
    }];
}
#pragma mark--AFN(Session的演练)
- (void)test29
{
    AFHTTPSessionManager *manger=[AFHTTPSessionManager manager];
     NSString *urlStr=[NSString stringWithFormat:@"http://%@/videos.json",IPAdd];
    [manger GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        self.label.text=[NSString stringWithFormat:@"%@ --%@",responseObject,[NSThread currentThread]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
         self.label.text=[NSString stringWithFormat:@"%@ --%@",error,[NSThread currentThread]];
    }];
}

#pragma mark--NSURLCache
- (void)test30
{
    NSURL *url=[NSURL URLWithString:@"http://localhost:8080/MJServer/video"];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15];
    request.cachePolicy=NSURLRequestReturnCacheDataElseLoad;
    NSURLCache *cache=[NSURLCache sharedURLCache];
    NSCachedURLResponse *response= [cache cachedResponseForRequest:request];
    if(response)
        NSLog(@"请求已在缓存");
    else
        NSLog(@"这个请求未缓存");
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(connectionError)
            NSLog(@"%@",connectionError);
        if(connectionError||data==nil)
            return ;
        id result=[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        self.label.text=[NSString stringWithFormat:@"%@",result];
    }];

}
#pragma mark--ASI 同步
- (void)test31
{
    
     NSString *urlStr =[NSString stringWithFormat:@"http://%@:8080/MJServer/login?username=123&pwd=123",IPAdd] ;
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    request.timeOutSeconds=10;
    [request startSynchronous];
    if(request.error)
    {
        self.label.text=[NSString stringWithFormat:@"请未出错"];
    }
    else
    {
        id result=[NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:NULL];
        self.label.text=[NSString stringWithFormat:@"%d %@ %@",request.responseStatusCode,request.responseStatusMessage,result];
    }

}
#pragma mark--ASI 代理异步
- (void)test32
{
    NSString *urlStr =[NSString stringWithFormat:@"http://%@:8080/MJServer/login?username=123&pwd=123",IPAdd] ;
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    request.timeOutSeconds=10;
    request.delegate=self;
    [request startAsynchronous];
    [request setDidStartSelector:@selector(asiStart)];
}
- (void)asiStart
{
     NSLog(@"%s",__func__);
}
- (void)requestStarted:(ASIHTTPRequest *)request
{
     NSLog(@"%s",__func__);
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
     NSLog(@"%s",__func__);
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
     NSLog(@"%s",__func__);
}
- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data
{
     NSLog(@"%s",__func__);
    id result=[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    self.label.text=[NSString stringWithFormat:@" %@",result];
}
#pragma mark--ASI block异步
- (void)test33
{
   NSString *urlStr =[NSString stringWithFormat:@"http://%@:8080/MJServer/login?username=123&pwd=123",IPAdd] ;
    self.asiRequest=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    self.asiRequest.timeOutSeconds=10;
    [self.asiRequest setStartedBlock:^{
         NSLog(@"start");
    }];
    [self.asiRequest setFailedBlock:^{
         NSLog(@"fail");
    }];
    [self.asiRequest setCompletionBlock:^{
         NSLog(@"complete");
    }];
    __weak typeof(self)selfObj=self;
    [self.asiRequest setDataReceivedBlock:^(NSData *data) {
        id result=[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        selfObj.label.text=[NSString stringWithFormat:@" %@",result];
    }];
    [self.asiRequest startAsynchronous];
}
- (void)dealloc
{
    //不执行这句，控制器销毁好，请求还会调用控制器方法
    [self.asiRequest clearDelegatesAndCancel];
}
#pragma mark--ASI post
- (void)test34
{
    NSString *urlStr =[NSString stringWithFormat:@"http://%@:8080/MJServer/login",IPAdd] ;
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlStr]];
    request.timeOutSeconds=10;
    [request setPostValue:@"123" forKey:@"username"];
    [request setPostValue:@"abc" forKey:@"pwd"];
    [request setCompletionBlock:^{
        NSLog(@"comlete");
    }];
    [request startAsynchronous];
}
#pragma mark--ASI 下载
- (void)test35
{
     NSString *urlStr =[NSString stringWithFormat:@"http://%@/videos.zip",IPAdd] ;
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    request.timeOutSeconds=10;
     NSString *cachesPath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *destinationPath=[cachesPath stringByAppendingPathComponent:@"b.zip"];
    request.downloadDestinationPath=destinationPath;
    request.allowResumeForFileDownloads=YES;//支持断点下载
    [request startAsynchronous];
    [request setDownloadProgressDelegate:self.progressView];//设置下载代理
}
#pragma mark--ASI 上传
- (void)test36
{
    NSString *urlStr =[NSString stringWithFormat:@"http://%@:8080/MJServer/upload",IPAdd] ;
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlStr]];
    NSString *filePath=[[NSBundle mainBundle]pathForResource:@"itcast.txt" ofType:nil];
    [request setPostValue:@"zyh" forKey:@"username"];
    [request setFile:filePath forKey:@"file"];
    [request startAsynchronous];
    [request setCompletionBlock:^{
        NSLog(@"上传完毕");
    }];
}
#pragma mark--ASI 上传2
- (void)test37
{
    NSString *urlStr =[NSString stringWithFormat:@"http://%@:8080/MJServer/upload",IPAdd] ;
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlStr]];
    NSString *filePath=[[NSBundle mainBundle]pathForResource:@"itcast.txt" ofType:nil];
    [request setPostValue:@"zyh" forKey:@"username"];
    [request setFile:filePath withFileName:@"zyh.txt" andContentType:@"text/plain" forKey:@"file"];
    [request startAsynchronous];
    [request setCompletionBlock:^{
        NSLog(@"上传完毕");
    }];

}
#pragma mark--ASI 上传相册图片
- (void)test38
{
    UIImagePickerController *ipc=[[UIImagePickerController alloc]init];
    ipc.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate=self;
    [self presentViewController:ipc animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self uploadImage:image];
}
- (void)uploadImage:(UIImage *)image
{
    NSString *urlStr =[NSString stringWithFormat:@"http://%@:8080/MJServer/upload",IPAdd] ;
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setPostValue:@"zyh" forKey:@"username"];
    NSData *data=UIImagePNGRepresentation(image);
    [request setData:data withFileName:@"a.png" andContentType:@"image/png" forKey:@"file"];
    [request startAsynchronous];
    [request setCompletionBlock:^{
        NSLog(@"上传完毕");
    }];

}
#pragma mark--ASI 上传大文件
- (void)test39
{
    [ASIHTTPRequest setShouldUpdateNetworkActivityIndicator:YES];
    
    NSString *urlStr =[NSString stringWithFormat:@"http://%@:8080/MJServer/upload",IPAdd] ;
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setPostValue:@"zyh" forKey:@"username"];
    [request setFile:@"/Library/WebServer/Documents/videos.zip" forKey:@"file"];
    request.uploadProgressDelegate=self.progressView;
    request.shouldContinueWhenAppEntersBackground=YES;//进入后台继续上传
    [request startAsynchronous];
    [request setCompletionBlock:^{
        NSLog(@"上传完毕");
    }];

}
#pragma mark--ASI 只使用内存缓存
- (void)test40
{
    NSString *urlStr =[NSString stringWithFormat:@"http://%@:8080/MJServer/video",IPAdd] ;
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    __weak typeof(request)selfObj=request;
    __weak typeof(self)selfVC=self;
    [request setCompletionBlock:^{
        NSLog(@"%@",selfObj.responseString);
        selfVC.label.text=selfObj.responseString;
    }];
    ASIDownloadCache *cache=[ASIDownloadCache sharedCache];
    cache.defaultCachePolicy=ASIOnlyLoadIfNotCachedCachePolicy; // 设置缓存策略(如果有缓存, 就使用缓存,  没有缓存, 才去发送请求)
    request.downloadCache=cache;
    [request startSynchronous];
}
#pragma mark--ASI 内存缓存+硬盘缓存
- (void)test41
{
    NSString *urlStr =[NSString stringWithFormat:@"http://%@:8080/MJServer/video",IPAdd] ;
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    __weak typeof(request)selfObj=request;
    __weak typeof(self)selfVC=self;
    [request setCompletionBlock:^{
        NSLog(@"%@",selfObj.responseString);
        selfVC.label.text=selfObj.responseString;
    }];
    ASIDownloadCache *cache=[ASIDownloadCache sharedCache];
    cache.defaultCachePolicy=ASIOnlyLoadIfNotCachedCachePolicy; // 设置缓存策略(如果有缓存, 就使用缓存,  没有缓存, 才去发送请求)
    request.downloadCache=cache;
    request.cacheStoragePolicy=ASICachePermanentlyCacheStoragePolicy;//永久存存储
    [request startSynchronous];
    // cacheStoragePolicy : 控制缓存的存储时长
}
- (void)cacheAllRequest
{
    // 1.创建请求
    NSURL *url1 = [NSURL URLWithString:@"http://192.168.1.200:8080/MJServer/video"];
    ASIHTTPRequest *request1 = [ASIHTTPRequest requestWithURL:url1];
    request1.cacheStoragePolicy = ASICachePermanentlyCacheStoragePolicy;
    
    NSURL *url2 = [NSURL URLWithString:@"http://192.168.1.200:8080/MJServer/login"];
    ASIHTTPRequest *request2 = [ASIHTTPRequest requestWithURL:url2];
    request1.cacheStoragePolicy = ASICacheForSessionDurationCacheStoragePolicy;
    
    // 2.获得系统默认的缓存管理对象(决定着缓存存储路径)
    ASIDownloadCache *cache = [ASIDownloadCache sharedCache];
    cache.defaultCachePolicy = ASIOnlyLoadIfNotCachedCachePolicy;
    
    // 3.设置cache为全局缓存
    [ASIHTTPRequest setDefaultCache:cache];//所有请求一样的策略
}

- (void)cachePolicyAndCacheStoragePolicy
{
    // 1.创建请求
    NSURL *url1 = [NSURL URLWithString:@"http://192.168.1.200:8080/MJServer/video"];
    ASIHTTPRequest *request1 = [ASIHTTPRequest requestWithURL:url1];
    
    NSURL *url2 = [NSURL URLWithString:@"http://192.168.1.200:8080/MJServer/login"];
    ASIHTTPRequest *request2 = [ASIHTTPRequest requestWithURL:url2];
    
    // 2.获得系统默认的缓存管理对象(决定着缓存存储路径)
    ASIDownloadCache *cache = [ASIDownloadCache sharedCache];
    // 默认的缓存加载策略 : 不读取缓存
    cache.defaultCachePolicy = ASIDoNotReadFromCacheCachePolicy;
    
    // 3.使用缓存
    request1.downloadCache = cache;
    // 缓存加载策略
    request1.cachePolicy = ASIOnlyLoadIfNotCachedCachePolicy;
    // 缓存存储策略
    request1.cacheStoragePolicy = ASICachePermanentlyCacheStoragePolicy;
    
    // 使用缓存
    request2.downloadCache = cache;
    // 缓存加载策略
    request2.cachePolicy = ASIDontLoadCachePolicy;
    // 缓存存储策略
    request2.cacheStoragePolicy = ASICacheForSessionDurationCacheStoragePolicy;
}
#pragma mark--网络状态检测
- (void)checkNetwork
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                NSLog(@"未知网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                NSLog(@"没有网络(断网)");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                NSLog(@"手机自带网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                NSLog(@"WIFI");
                break;
        }
    }];
    
    // 3.开始监控
    [mgr startMonitoring];
    
    //    mgr.isReachableViaWiFi
    //    mgr.isReachableViaWWAN
}
#pragma mark--webView使用1
- (void)test42
{
    ZYHWebViewController *VC=[_storyBoard instantiateViewControllerWithIdentifier:@"webView"];
    
    [self.navigationController pushViewController:VC animated:YES];

}
#pragma mark--webView使用2
- (void)test43
{
    ZYHWebViewTestController *VC=[_storyBoard instantiateViewControllerWithIdentifier:@"webView2"];
    
    [self.navigationController pushViewController:VC animated:YES];

}
#pragma mark--公司API测试
- (void)test44
{
    
    NSString *url=@"http://app.tuxiaobei.com/action/app-txb-getlist.php?typeid=1&pageNo=20&curPage=1&act=1&key=";
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self.manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id result=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
        NSLog(@"%@--%@",result,[result class]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败=%@",error);
    }];
}
- (void)test45
{
  NSLog(@"%s",__func__);
    NSString *urlStr = @"http://huodong.chinacici.com/m/vote/v1/user_add_option";
    NSDictionary *params = @{@"oid" : @"1417", @"vid" : @"89",@"city_id":@"514000"};
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *cookie=@"wisehd_session=9a3b029addb22117335cbde173536854af59b2ae; wisevote_uinfo_89=3c56TP5drc0kjHBeauLdslyOaFWWUzg2q%2FQI50QUON1NXozQk0mFY%2Ff0gaJeh6YapuKAhLt%2Bo2j0WH%2FlV8%2FmNUc";
    [self.manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [self.manager.requestSerializer setValue:@"Mozilla/5.0 (iPhone; CPU iPhone OS 10_0_1 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) Mobile/14A403iPhone_OS_10.0.1 WiseCICI00005140000000938c665b6c6e95f5fa6c0ebccfa1f67d010702" forHTTPHeaderField:@"User-Agent"];
    NSString*refer=@"http://huodong.chinacici.com/m/vote/V2/index/514000/89?authcode=cbf9R3AuqBbTyeqfNMD5oMcFm8gz8GFMsjQsQYVX6nsi1GaQgukuGr3T3aFfzqKEgpc8WknZMF3nETmLDb05BS8hI%2F7Toiy9HZ5IEwpJ%2BxUEDUZzaUsTR42UwLvHUrP%2BWuMPGNxL6NwmAkLm5bKGOLFmIuE1P3Xol84PPmLmgax5NXEXgAPH%2FCY";
    [self.manager.requestSerializer setValue:refer forHTTPHeaderField:@"Referer"];
    [self.manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.label.text=[NSString stringWithFormat:@"%@ --%@",responseObject,[NSThread currentThread]];
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        self.label.text=[NSString stringWithFormat:@"%@ --%@",error,[NSThread currentThread]];
    }];

}
-(void)test46
{
    //self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //[self.manager.requestSerializer setValue:@"10.11.12.13" forHTTPHeaderField:@"X-Forwarded-For"];
    //[self.manager.requestSerializer setValue:@"12.13.14.15" forHTTPHeaderField:@"REMOTE_ADDR"];
    [self.manager GET:@"http://192.168.0.120:80/test.php" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.label.text=[NSString stringWithFormat:@"%@",responseObject];
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
    switch (toInterfaceOrientation)
    {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            _childView.frame=CGRectMake(0, 0, screenH, screenw);
            NSLog(@"left %@",NSStringFromCGRect(_childView.frame));
            
            break;
        case UIInterfaceOrientationPortrait:
            
        case UIInterfaceOrientationPortraitUpsideDown:
            _childView.frame=CGRectMake(0, 0,screenw , screenH);
            break;
        case UIInterfaceOrientationUnknown:
            NSLog(@"Unknown");
            
            break;
    }
    
    NSLog(@"rotate %@",NSStringFromCGRect(self.view.frame));
    //_childView.frame=self.view.frame;
    
}

@end
