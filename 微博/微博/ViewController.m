//
//  ViewController.m
//  微博
//
//  Created by Apple on 15/11/29.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"
#include "ZYHMicroBlogData.h"
#include "ZYHMicroBlogCell.h"
@interface ViewController ()
@property(nonatomic,strong)NSArray *microBlog;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSArray *)microBlog
{
    if(_microBlog==nil)
    {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"microBlogs.plist" ofType:nil];
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArray=[NSMutableArray array];
        for(NSDictionary *dict in dictArray)
        {
            ZYHMicroBlogData *blog=[ZYHMicroBlogData microWithDict:dict];
            [tempArray addObject:blog];
        }
        _microBlog=tempArray;
    }
    return _microBlog;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.microBlog.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYHMicroBlogData *blog=self.microBlog[indexPath.row];
    ZYHMicroBlogCell *cell=[ZYHMicroBlogCell cellWithTableView:tableView];
    [cell setMicroBlogData:blog];
    return  cell;
}
/**
 *  返回行每一CELL的高度
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYHMicroBlogData *blog=self.microBlog[indexPath.row];
    return blog.cellHeight;
}
@end
