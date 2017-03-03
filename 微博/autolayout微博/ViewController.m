//
//  ViewController.m
//  autolayout微博
//
//  Created by Apple on 15/12/19.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "HMMicroBlog.h"
#import "HMMicroBlogCell.h"
@interface ViewController ()
@property(nonatomic,strong)NSArray *microBlogs;
@end

@implementation ViewController
- (NSArray *)microBlogs{
    
    if (_microBlogs == nil) {
        //        1.获取全路径
        NSString *path =  [[NSBundle mainBundle]pathForResource:@"microBlogs.plist" ofType:nil];
        //        2.读取plsit文件
        NSArray *dictArray =  [NSArray arrayWithContentsOfFile:path];
        //        3.字典转模型
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            HMMicroBlog *blog = [HMMicroBlog microBlogWithDict:dict];
            [tempArray addObject:blog];
        }
        _microBlogs = tempArray;
        
    }
    return _microBlogs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight=UITableViewAutomaticDimension;//设置自动计算高度
    self.tableView.estimatedRowHeight=44;//接着必须预估计行高
    
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma 返回一共多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.microBlogs.count;
    
}
#pragma 返回怎样的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    1.创建cell
    static NSString *ID = @"weibo";
    HMMicroBlogCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell =[[HMMicroBlogCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    //    2.赋值
    HMMicroBlog *blog = self.microBlogs[indexPath.row];
    cell.microBlog = blog;
    //    3.返回cell
    return cell;
    
    
    
    
}

@end
