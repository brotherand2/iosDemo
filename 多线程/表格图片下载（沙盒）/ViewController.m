//
//  ViewController.m
//  表格图片下载（无沙盒）
//
//  Created by Apple on 16/2/11.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "ZYHAppModal.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSArray *apps;
@property(nonatomic,strong) NSOperationQueue *queue;
@property(nonatomic,strong) NSMutableDictionary *operationCache;
@property(nonatomic,strong) NSCache *imageCache;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController
- (NSOperationQueue *)queue
{
    if (_queue==nil) {
        _queue=[[NSOperationQueue alloc]init];
    }
    return _queue;
}
- (NSMutableDictionary *)operationCache
{
    if(_operationCache==nil)
    {
        _operationCache=[NSMutableDictionary dictionary];
    }
    return _operationCache;
}
- (NSCache *)imageCache
{
    if(_imageCache==nil)
    {
        _imageCache=[[NSCache alloc]init];
    }
    return _imageCache;
}
//懒加载
- (NSArray *)apps
{
    if(_apps==nil)
    {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"apps.plist" ofType:nil];
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArray=[NSMutableArray array];
        for(NSDictionary *dict in dictArray)
        {
            ZYHAppModal *modal=[ZYHAppModal appWithDict:dict];
            [tempArray addObject:modal];
        }
        _apps=tempArray;
    }
    return _apps;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.apps.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString*identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    ZYHAppModal *modal=self.apps[indexPath.row];
    cell.textLabel.text=modal.name;
    cell.detailTextLabel.text=modal.download;
    if([self.imageCache objectForKey:modal.name])
    {
        cell.imageView.image=[self.imageCache objectForKey:modal.name];
    }
    else
    {
        UIImage *image=[UIImage imageWithContentsOfFile:[self cachePathWithUrl:modal.icon]];
        if(image)
        {
            cell.imageView.image=image;
            [self.imageCache setObject:image forKey:modal.name];
            NSLog(@"读取本地文件");
        }
        else
        {
            cell.imageView.image=[UIImage imageNamed:@"user_default"];
            [self downloadImage:indexPath];
        }
    }
    return cell;
}
- (NSString*)cachePathWithUrl:(NSString*)url
{
    NSString *cachePath=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    return [cachePath stringByAppendingPathComponent:url.lastPathComponent];
}
- (void)downloadImage:(NSIndexPath*)indexPath
{
    ZYHAppModal *modal=self.apps[indexPath.row];
    if([self.operationCache objectForKey:modal.name] )
    {
        NSLog(@"玩命下载中...");
        
        return;
    }
    __weak typeof(self)selfObj=self;
    NSOperation *operation=[NSBlockOperation blockOperationWithBlock:^
    {
        NSLog(@"正在下载中");
        NSURL *url=[NSURL URLWithString:modal.icon];
        NSData *data=[NSData dataWithContentsOfURL:url];
        UIImage *image=[UIImage imageWithData:data];
        if(image)
        {
            [selfObj.imageCache setObject:image forKey:modal.name];
            [data writeToFile:[self cachePathWithUrl:modal.icon] atomically:YES];
        }
        [selfObj.operationCache removeObjectForKey:modal.name];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [selfObj.tableView reloadRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationLeft];
        }];
    }];
    [self.queue addOperation:operation];
    [self.operationCache setObject:operation forKey:modal.name];

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",self.operationCache);
}
@end
