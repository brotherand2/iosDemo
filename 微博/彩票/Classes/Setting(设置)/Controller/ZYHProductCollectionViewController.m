//
//  ZYHProductCollectionViewController.m
//  微博
//
//  Created by Apple on 16/2/8.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHProductCollectionViewController.h"
#import "ZYHProductModal.h"
#import "ZYHProductCell.h"
@interface ZYHProductCollectionViewController ()
@property(nonatomic,strong) NSArray *products;
@end

@implementation ZYHProductCollectionViewController
- (NSArray *)products
{
    if(_products==nil)
    {
        NSString *path= [[NSBundle mainBundle]pathForResource:@"products.json" ofType:nil];
        NSData *data=[NSData dataWithContentsOfFile:path];
        NSArray *dataArray=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *tempArray=[NSMutableArray array];
        for(NSDictionary *dict in dataArray)
        {
            ZYHProductModal *modal=[ZYHProductModal productWithDict:dict];
            [tempArray addObject:modal];
        }
        _products=tempArray;
    }
    return _products;
}
- (instancetype)init
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    if(self=[super initWithCollectionViewLayout:layout])
    {
        //最终的cell的大小，是由 流水布局 决定，由xib是决定不了
        //设置cell的尺寸

        layout.itemSize=CGSizeMake(80, 100);
        layout.minimumLineSpacing=0;
        layout.minimumInteritemSpacing=20;
        layout.sectionInset=UIEdgeInsetsMake(20, 10, 0, 10);
    }
    return self;
}
static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    self.collectionView.backgroundColor=[UIColor whiteColor];
    // Register cell classes
    //[self.collectionView registerClass:[ZYHProductCell class ]forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZYHProductCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return self.products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZYHProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ZYHProductModal *modal=self.products[indexPath.row];
    cell.modal=modal;
    // Configure the cell
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSURL *url=[NSURL URLWithString:@"zyh://caitu"];
    ZYHProductModal *modal=self.products[indexPath.row];

    UIApplication *app=[UIApplication sharedApplication];
    NSString *appUrl=[NSString stringWithFormat:@"%@://%@",modal.customUrl,modal.identifier];
    NSURL *url=[NSURL URLWithString:appUrl];
    if(![app canOpenURL:url])
    {
        url=[NSURL URLWithString:modal.url];
    }

    [app openURL:url];
   
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
