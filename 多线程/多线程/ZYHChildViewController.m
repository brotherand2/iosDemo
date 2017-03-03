//
//  ZYHChildViewController.m
//  多线程
//
//  Created by Apple on 16/2/9.
//  Copyright © 2016年 Apple. All rights reserved.
//
# define COSTTIME \
for (NSInteger i=0; i<20; i++)\
{\
    [NSThread sleepForTimeInterval:1.0];\
    NSLog(@"%ld--%@",i,[NSThread currentThread]);\
};

#import "ZYHChildViewController.h"
#import "ZYHView.h"
#import <pthread.h>
@interface ZYHChildViewController ()
{
@public
    CGFloat screenw;
    CGFloat screenH;
}
@property (weak, nonatomic)ZYHView *childView;
@property (weak, nonatomic)UIImageView *imageView;
@property(nonatomic,strong) NSOperationQueue *queue;
@end

@implementation ZYHChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGSize size=[UIScreen mainScreen].bounds.size;
    screenw=size.width;
    screenH=size.height;
    UIBarButtonItem *over=[[UIBarButtonItem alloc]initWithTitle:@"开始" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    self.navigationItem.rightBarButtonItem=over;
    ZYHView *view=[[ZYHView alloc]init];
    self.childView=view;
    view.tag=self.tag;
    //NSLog(@"%ld",self.view.tag);
    [view setBackgroundColor:[UIColor grayColor]];
    [self.view setBackgroundColor:[UIColor grayColor]];
    view.frame=self.view.frame;
    [self myViewInit];
    [self.view addSubview:view];

}

- (void)myViewInit
{
    switch (self.tag)
    {
        case 6:
        case 15:
        {
            UIImageView *imageView=[[UIImageView alloc]init];
            imageView.frame=_childView.frame;
            [_childView addSubview:imageView];
            _imageView=imageView;
        };
            break;
        case 25:
        {
            UIBarButtonItem *cacelAll=[[UIBarButtonItem alloc]initWithTitle:@"取消全部" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAllOperation)];
            self.navigationItem.rightBarButtonItem.title=@"暂停";
            self.navigationItem.rightBarButtonItems=@[self.navigationItem.rightBarButtonItem,cacelAll];
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.center=_childView.center;
            btn.bounds=CGRectMake(0, 0, 100, 44);
            [btn setTitle:@"开始" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(testOperation6) forControlEvents:UIControlEventTouchUpInside];
            [_childView addSubview:btn];
        }
            break;
        default:
        {
            if (10==self.tag)
            {
                NSDictionary *dict=@{NSFontAttributeName:[UIFont systemFontOfSize:22],
                                     NSForegroundColorAttributeName:[UIColor redColor]             };
                
                [self.navigationItem.rightBarButtonItem setTitle:@"终止"];
                [self.navigationItem.rightBarButtonItem setTitleTextAttributes:dict forState:UIControlStateNormal];
            }

        }
            break;
    }

}

#pragma mark测试performSelectorInBackground
- (void)testPerformSelectorInBackground
{
    for (NSInteger i=0; i<20000; i++)
    {
        NSLog(@"%@",[NSThread currentThread]);
    }
}
#pragma mark--TestPThread
void *TestPThread(void *param)
{
    NSString *str=(__bridge NSString *)(param);
    for(NSInteger i=0;i<20000;i++)
    {
        NSLog(@"%@----%@",[NSThread currentThread],str);
    }
    return NULL;
}
#pragma mark-- NSThread

- (void)testNSThread
{
    for(NSInteger i=0;i<20;i++)
    {
        if(i==5)
            [NSThread sleepForTimeInterval:5.0];
        if(i==15)
            [NSThread exit];
        NSLog(@"%@----%ld",[NSThread currentThread],i);
    }
    NSLog(@"end thread");
}
#pragma mark---卖票 
static int tickets;
- (void)sale
{
    while(true)
    {
        [NSThread sleepForTimeInterval:1.0];
        @synchronized(self)
        {
            if(tickets>0)
            {
                tickets--;
                NSLog(@"还剩票数%d ---%@",tickets,[NSThread currentThread]);
            }
            else
            {
                NSLog(@"票已卖完");
                break;
            }
        }
        
    }
}
- (void)saleTickets
{
    tickets=50;
    NSThread *threadA=[[NSThread alloc]initWithTarget:self selector:@selector(sale) object:nil];
    threadA.name=@"threadA";
    [threadA start];
    NSThread *threadB=[[NSThread alloc]initWithTarget:self selector:@selector(sale) object:nil];
    threadB.name=@"threadB";
    [threadB start];
}
- (void)cancel:(UIBarButtonItem *)btn
{
    switch (self.tag)
    {
        case 1:
        {
            NSLog(@"%s---%@",__func__,[NSThread currentThread]);
            [self performSelectorInBackground:@selector(testPerformSelectorInBackground) withObject:nil];
            NSLog(@"%@",[NSThread currentThread]);
        }
        ;
        break;
        case 0:
        {
            pthread_t thread_id;
            NSString *str=@"hello world";
            pthread_create(&thread_id,NULL,TestPThread,(__bridge void *)(str));
        }
            break;
        case 2:
        {
            NSThread *thread=[[NSThread alloc]initWithTarget:self selector:@selector(testNSThread) object:nil];
            [thread start];
        }
        break;
        case 3:
        {
            NSLog(@"NSthread start :%@",[NSThread currentThread]);
            [NSThread detachNewThreadSelector:@selector(testNSThread) toTarget:self withObject:nil];
            NSLog(@"NSthread end :%@",[NSThread currentThread]);
        }
            break;
        case 4:
        {
            NSThread *threadA=[[NSThread alloc]initWithTarget:self selector:@selector(run:) object:@"hello"];
            threadA.name=@"ThreadA";
            threadA.threadPriority=0.1;
            // 线程优先级
            // 是一个浮点数，0.0～1.0。 默认值 0.5
            // 开发的时候，一般不去修改优先级的值。
            // 优先级，必须调用很多次的时候，才能体现出来
            [threadA start];
            
            
            NSThread *threadB=[[NSThread alloc]initWithTarget:self selector:@selector(run:) object:@"World"];
            threadB.name=@"ThreadB";
            threadB.threadPriority=0.5;
            
            [threadB start];
        }
            break;
        case 5:
        {
            [self saleTickets];
        }
            break;
        case 6:
        {
            //[self downLoadImage];
            [self performSelectorInBackground:@selector(downLoadImage) withObject:nil];
        }
            break;
        case 7:
        {
            [self gcdTest1];
        }
            break;
        case 8:
        {
            [self gcdTest2];
        }
            break;
        case 9:
        {
            [self gcdTest3];
        }
            break;
        case 10:
        {
            [self gcdTest4];
        }
            break;
        case 11:
        {
            [self gcdTest5];
        }
            break;
        case 12:
        {
            [self gcdTest6];
        }
            break;
        case 13:
        {
            [self gcdTest7];
        }
            break;
        case 14:
        {
            [self gcdTest8];
        }
            break;
        case 15:
        {
            [self downLoadImage2];
        }
            break;
        case 16:
        {
            [self executeOnce];
        }
            break;
        case 17:
        {
            [self testGCDGroup];
        }
            break;
        case 18:
        {
            [self delay];
        }
            break;
        case 19:
        {
            [self testOperation1];
        }
            break;
        case 20:
        {
            [self testOperation2];
        }
            break;
        case 21:
        {
            [self testOperation3];
        }
            break;
        case 22:
        {
            [self testOperation4];
        }
            break;
        case 23:
        {
            [self testOperation5];
        }
            break;
        case 24:
        {
            [self testOperation6];
        }
            break;
        case 25:
        {
            [self testOperation7:btn];
        }
            break;
        case 26:
        {
            [self testOperation8];
        }
            break;
    }

}
#pragma mark-- 单个NSInvocationOperation
- (void)testOperation1
{
    NSOperation *operation=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(run:) object:@"hello"];
    //[operation start];
    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
    [queue addOperation:operation];
    NSLog(@"end");
}

#pragma mark-- 多个NSInvocationOperation
- (void)testOperation2
{
       //[operation start];
    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
    for(NSInteger i=0;i<10;i++)
    {
         NSOperation *operation=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(run:) object:@"hello"];
        [queue addOperation:operation];
    }

    
    NSLog(@"end");
}
#pragma mark--NSBlockOperation
- (void)testOperation3
{
   // NSOperationQueue *queue=[NSOperationQueue mainQueue];
    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
    for(NSInteger i=0;i<10;i++)
    {
        NSBlockOperation *operation=[NSBlockOperation blockOperationWithBlock:^{
            COSTTIME
        }];
        [queue addOperation:operation];
    }
    NSLog(@"end");
}
#pragma mark--NSBlockOperation简单使用
- (void)testOperation4
{
    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
    for(NSInteger i=0;i<10;i++)
    {
        [queue addOperationWithBlock:^{
            NSLog(@"%ld --%@",i,[NSThread currentThread]);
        }];
    }
    NSBlockOperation *operation=[NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op1-%@",[NSThread currentThread]);
    }];
    [operation addExecutionBlock:^{
        NSLog(@"op1-11");
    }];
    [queue addOperation:operation];
    NSInvocationOperation *op2=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(run:) object:@"world"];
    [queue addOperation:op2];

}
#pragma mark--NSBlockOperation线程间通信
- (void)testOperation5
{
    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
    [queue addOperationWithBlock:^{
        COSTTIME
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            NSLog(@"在此处更新UI --%@",[NSThread currentThread]);
        }];
    }];
}
#pragma mark--NSBlockOperation最大并发数
- (void)testOperation6
{
    if(self.queue.operationCount)
    {
        NSLog(@"已经在运行");
        return;
    }

    self.queue.maxConcurrentOperationCount=3;//不是线程数量，是同一时间时间运行的线程数量
    for(NSInteger i=0;i<20;i++)
    {
        NSOperation *operation=[NSBlockOperation blockOperationWithBlock:^{
            [NSThread sleepForTimeInterval:1.0];
            NSLog(@"%ld --%@",i,[NSThread currentThread]);
        }];
        [self.queue addOperation:operation];
    }

}
- (NSOperationQueue *)queue
{
    if(_queue==nil)
    {
        _queue=[[NSOperationQueue alloc]init];
    }
    return _queue;
}
#pragma mark--NSBlockOperation暂停
- (void)testOperation7:(UIBarButtonItem*)item
{
    if(self.queue.operationCount==0)
    {
        NSLog(@"无操作");
        return;
    }
     if([item.title isEqualToString:@"继续"])
        item.title=@"暂停";
    else
        item.title=@"继续";
    self.queue.suspended=!self.queue.suspended;
    //对于已运行的线程不能挂起，只能挂起队列中未运行的线程
}
#pragma mark--取消全部操作
- (void)cancelAllOperation
{
    [self.queue cancelAllOperations];
    self.queue.suspended=NO;
    NSLog(@"取消全部操作");
}
#pragma mark--NSOperation依赖关系
- (void)testOperation8
{
    NSBlockOperation *op1=[NSBlockOperation blockOperationWithBlock:^{
         NSLog(@"正在下载三国 --%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op2=[NSBlockOperation blockOperationWithBlock:^{
         NSLog(@"正在解压缩 --%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op3=[NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"正在更新UI --%@",[NSThread currentThread]);
    }];
    [op2 addDependency:op1];
    [op3 addDependency:op2];
    [self.queue addOperations:@[op1,op2] waitUntilFinished:YES];
    
    [[NSOperationQueue mainQueue]addOperation:op3];
    NSLog(@"come here");
}
#pragma mark--调度组
- (void)testGCDGroup
{
    dispatch_group_t group=dispatch_group_create();
    dispatch_queue_t queue=dispatch_get_global_queue(0, 0);
    dispatch_group_async(group, queue, ^{
        NSLog(@"正在下载三国 --%@",[NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"正在下载红楼 --%@",[NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"正在下载水浒 --%@",[NSThread currentThread]);
    });
//    dispatch_group_notify(group, queue, ^{
//         NSLog(@"正在阅读 --%@",[NSThread currentThread]);
//    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"正在阅读 --%@",[NSThread currentThread]);
    });
}
#pragma mark---执行一次
- (void)executeOnce
{
    static dispatch_once_t onceTocken;
    NSLog(@"%ld",onceTocken);
    dispatch_once(&onceTocken, ^{
        NSLog(@"真的执行一次吗？");
    });
    
    NSLog(@"end");
}
- (void)delay
{
    // 参数： when : 表示从现在开始，经过多少纳秒以后
    // queue ：  在哪一个队列里面执行后面的任务
    //    dispatch_after(when, dispatch_get_main_queue(), ^{
    //        NSLog(@"点我了-- %@", [NSThread currentThread]);
    //    });
    //    

    dispatch_time_t when=dispatch_time(DISPATCH_TIME_NOW, (2.0*NSEC_PER_SEC));
     NSLog(@"开始 %@",[NSThread currentThread]);
//    dispatch_after(when, dispatch_get_main_queue(), ^{
//        NSLog(@"结束%@",[NSThread currentThread]);
//    });
    dispatch_after(when, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"结束%@",[NSThread currentThread]);
    });
}
#pragma mark--GCD串行同歩队列
- (void)gcdTest1
{
    dispatch_queue_t queue=dispatch_queue_create("zyh", DISPATCH_QUEUE_SERIAL);
    NSLog(@"开始");
    // 一般只要使用”同步“执行，串行队列对添加的同步任务，会立马执行
    for(NSInteger i=0;i<10;i++)
    {
        dispatch_sync(queue, ^
                      {
                          
                          NSLog(@"%ld ---%@",i,[NSThread currentThread]);
                          
                          
                      });
    }
//在主线程按顺序执行
    NSLog(@"结束");
}
#pragma mark--GCD串行异歩队列
- (void)gcdTest2
{
    dispatch_queue_t queue=dispatch_queue_create("zyh", DISPATCH_QUEUE_SERIAL);
    NSLog(@"开始");
    // 一般只要使用”同步“执行，串行队列对添加的同步任务，会立马执行
    for(NSInteger i=0;i<10;i++)
    {
        dispatch_async(queue, ^
                      {
                          
                          NSLog(@"%ld ---%@",i,[NSThread currentThread]);
                          
                          
                      });
    }
//另开一个线程按顺序执行
    NSLog(@"结束");
}

#pragma mark--GCD并行同歩队列
- (void)gcdTest3
{
    dispatch_queue_t queue=dispatch_queue_create("zyh",DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"开始");
    // 一般只要使用”同步“执行，串行队列对添加的同步任务，会立马执行
      for(NSInteger i=0;i<10;i++)
        {
            dispatch_sync(queue, ^
            {
              
                    NSLog(@"%ld ---%@",i,[NSThread currentThread]);
              
                
            });
       }
 //在主线程按顺序执行
    NSLog(@"结束");
}
#pragma mark--GCD并行异歩队列
- (void)gcdTest4
{
    dispatch_queue_t queue=dispatch_queue_create("zyh",DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"开始");
    // 一般只要使用”同步“执行，串行队列对添加的同步任务，会立马执行
    for(NSInteger i=0;i<10;i++)
    {
        dispatch_async(queue, ^
            {
                          
                          NSLog(@"%ld ---%@",i,[NSThread currentThread]);
                          
                          
            });
    }
//开多个线程执行
    NSLog(@"结束");
}


#pragma mark--GCD 同歩主队列
/**
 主队列：专门负责在主线程上调度任务，不会在子线程调度任务，在主队列不允许开新线程.
 同步执行：要马上执行
 结果：死锁
 */

- (void)gcdTest5
{
    dispatch_queue_t queue=dispatch_get_main_queue();
    NSLog(@"开始");
    // 一般只要使用”同步“执行，串行队列对添加的同步任务，会立马执行
    for(NSInteger i=0;i<10;i++)
    {
        NSLog(@"调度前");
        dispatch_sync(queue, ^
           {
               
               NSLog(@"%ld ---%@",i,[NSThread currentThread]);
               
               
           });
        NSLog(@"睡会");
        [NSThread sleepForTimeInterval:1.0];
    }
    
    NSLog(@"结束");
}
#pragma mark--GCD异歩主队列
- (void)gcdTest6
{
    dispatch_queue_t queue=dispatch_get_main_queue();
    NSLog(@"开始");
    // 一般只要使用”同步“执行，串行队列对添加的同步任务，会立马执行
    for(NSInteger i=0;i<10;i++)
    {
        NSLog(@"调度前");
        dispatch_async(queue, ^
                      {
                          
                          NSLog(@"%ld ---%@",i,[NSThread currentThread]);
                          
                          
                      });
        NSLog(@"睡会");
        [NSThread sleepForTimeInterval:1.0];
    }
    //主线程所有任务执行完后依次执行
    NSLog(@"结束");
}
// 获得全局队列
/**
 参数：第一个参数，一般 写 0（可以适配 iOS 7 & 8）
 iOS 7
 DISPATCH_QUEUE_PRIORITY_HIGH 2  高优先级
 DISPATCH_QUEUE_PRIORITY_DEFAULT 0  默认优先级
 DISPATCH_QUEUE_PRIORITY_LOW (-2) 低优先级
 DISPATCH_QUEUE_PRIORITY_BACKGROUND INT16_MIN 后台优先级
 
 iOS 8
 QOS_CLASS_DEFAULT  0
 
 第二个参数：保留参数 0
 */

- (void)gcdTest7
{
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    NSLog(@"开始");
    // 一般只要使用”同步“执行，串行队列对添加的同步任务，会立马执行
    for(NSInteger i=0;i<10;i++)
    {
        NSLog(@"调度前");
        dispatch_sync(queue, ^
                      {
                          
                          NSLog(@"%ld ---%@",i,[NSThread currentThread]);
                          
                          
                      });
        NSLog(@"睡会");
        [NSThread sleepForTimeInterval:1.0];
    }
 //按顺序执行,跟不再dispatch_sync效果一样,不会等所有任务完成才执行
    NSLog(@"结束");
}
#pragma mark--GCD异歩主队列
- (void)gcdTest8
{
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);

    NSLog(@"开始");
    // 一般只要使用”同步“执行，串行队列对添加的同步任务，会立马执行
    for(NSInteger i=0;i<10;i++)
    {
        NSLog(@"调度前");
        dispatch_async(queue, ^
                       {
                           
                           NSLog(@"%ld ---%@",i,[NSThread currentThread]);
                           
                           
                       });
        NSLog(@"睡会");
        [NSThread sleepForTimeInterval:1.0];
    }
    //另开一个线程按顺序执行
    NSLog(@"结束");
}

#pragma mark --线程间通信下载图片
- (void)downLoadImage
{
    NSLog(@"current thread %@",[NSThread currentThread]);
    NSURL *url=[NSURL URLWithString:@"http://b.hiphotos.baidu.com/image/pic/item/1e30e924b899a901a51e411b18950a7b0208f5f0.jpg"];
    NSData *data=[NSData dataWithContentsOfURL:url];
    UIImage *image=[UIImage imageWithData:data];
    //[self performSelectorOnMainThread:@selector(SetImage:) withObject:image waitUntilDone:NO];
    // waitUntilDone：表示是否等待@selector(setImage:) 方法执行完成
    // 如果是YES，就等待setImage在其他线程执行结束，再往下执行
    //[self performSelector:@selector(SetImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:NO ];
    [_imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
    
    NSLog(@"完成");
}

#pragma mark --线程间通信下载图片2
- (void)downLoadImage2
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"current thread %@",[NSThread currentThread]);
        NSURL *url=[NSURL URLWithString:@"http://b.hiphotos.baidu.com/image/pic/item/1e30e924b899a901a51e411b18950a7b0208f5f0.jpg"];
        NSData *data=[NSData dataWithContentsOfURL:url];
        UIImage *image=[UIImage imageWithData:data];

         dispatch_async(dispatch_get_main_queue(), ^{
             _imageView.image=image;
             NSLog(@"current thread %@",[NSThread currentThread]);
         });
        
        NSLog(@"完成");

    });
   }
- (void)SetImage:(UIImage*) image
{
    NSLog(@"current thread %@",[NSThread currentThread]);
    _imageView.image=image;
    COSTTIME
}
- (void)run:(NSString *)str
{
    for(NSInteger i=0;i<10;i++)
    {
        NSLog(@"%ld --%@  --%@",i,str,[NSThread currentThread]);
    }

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
