//
//  ViewController.m
//  级联菜单
//
//  Created by Apple on 16/2/10.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "ZYHCategoryModal.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *categoryView;
@property (weak, nonatomic) IBOutlet UITableView *subCategoryView;
@property(nonatomic,strong) NSArray *categories;
@end

@implementation ViewController
//懒加载
- (NSArray *)categories
{
    if(_categories==nil)
    {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"categories.plist" ofType:nil];
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArray=[NSMutableArray array];
        for(NSDictionary *dict in dictArray)
        {
            ZYHCategoryModal *modal=[ZYHCategoryModal categoryWithDict:dict];
            [tempArray addObject:modal];
        }
        _categories=tempArray;
    }
    return _categories;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_categoryView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    _subCategoryView.contentInset=UIEdgeInsetsMake(-64, 0, 0, 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    if(tableView==self.categoryView)
    {
        return self.categories.count;
    }
     ZYHCategoryModal *modal=self.categories[self.categoryView.indexPathForSelectedRow.row];
    return modal.subcategories.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView==self.categoryView)
    {
        ZYHCategoryModal *modal=self.categories[indexPath.row];
        static NSString *idetifier=@"category";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:idetifier];
        cell.imageView.image=[UIImage imageNamed:modal.icon];
        cell.imageView.highlightedImage=[UIImage imageNamed:modal.highlighted_icon];
        cell.textLabel.text=modal.name;
        cell.textLabel.highlightedTextColor=[UIColor redColor];
        return cell;
    }
    else
    {
        static NSString *idetifier=@"subCategory";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:idetifier];
        ZYHCategoryModal *modal=self.categories[self.categoryView.indexPathForSelectedRow.row];
        cell.textLabel.text=modal.subcategories[indexPath.row];
        return cell;
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.categoryView)
    {
        [self.subCategoryView reloadData];
        
    }
}
@end
