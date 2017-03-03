//
// 文件名： ZYHVideoController.m
// 项目名： 多线程
// 创建者：Apple
// 日期时间 :16/2/18 18:52
// 版权：  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHVideoController.h"
#import "ZYHMoviePlayerViewController.h"
#import "ZYHVideoTool.h"
#import "MBProgressHUD+MJ.h"
#import "ZYHCell.h"
@interface ZYHVideoController()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) NSArray *videos;
@end

@implementation ZYHVideoController
- (void)viewDidLoad
{
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.rowHeight=70;
    self.tableView.separatorStyle=UITableViewCellEditingStyleNone;
    [MBProgressHUD showMessage:@"正在加载视频信息..."];
    //NSString *urlStr=[NSString stringWithFormat:@"http://%@:8080/MJServer/video",IPAdd];
    NSString *urlStr=[NSString stringWithFormat:@"http://%@:8080/MJServer/video?type=XML",IPAdd];
    NSURL *url=[NSURL URLWithString:urlStr];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15];
    __weak typeof(self)selfObj=self;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(connectionError)
            NSLog(@"%@",connectionError);
        [MBProgressHUD hideHUD];
        if(connectionError||data==nil)
        {
            [MBProgressHUD showError:@"未连接网络"];
            return ;
        }
        //selfObj.videos=[ZYHVideoTool parseJSONData:data];
        selfObj.videos=[ZYHVideoTool parseXMLData:data];
        [selfObj.tableView reloadData];       
    }];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videos.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYHCell *cell=[ZYHCell cellWithTableView:tableView];
    VideoModal *modal=self.videos[indexPath.row];
    cell.modal=modal;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoModal *modal=self.videos[indexPath.row];
    NSString *urlStr=[NSString stringWithFormat:@"http://%@:8080/MJServer/%@",IPAdd, modal.url];
    ZYHMoviePlayerViewController *VC=[[ZYHMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:urlStr]];
    [self presentMoviePlayerViewControllerAnimated:VC];
    
}
@end
