//
//  ViewController.m
//  collectionView
//
//  Created by Apple on 2016/12/2.
//  Copyright © 2016年 Apple. All rights reserved.
//
#import "UIView+Extension.h"
#import "ViewController.h"
@interface HeadView : UICollectionReusableView
@property(nonatomic,strong) UILabel *label;
@end



@implementation HeadView

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        self.label=[[UILabel alloc]init];
        self.label.tag=1;
        self.label.frame=self.bounds;
        self.label.height=20;
        self.label.y=self.height-20;
        self.backgroundColor = [UIColor cyanColor];
    }
    return self;
}
@end


@interface FootView : UICollectionReusableView
@property(nonatomic,strong) UILabel *label;
@end



@implementation FootView

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        self.label=[[UILabel alloc]init];
        self.label.tag=1;
        self.label.frame=self.bounds;
        self.label.height=20;
        self.label.y=self.height-20;
        self.backgroundColor = [UIColor cyanColor];
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}
@end

@interface CellView : UICollectionViewCell

@end



@implementation CellView

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}
@end

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong) UICollectionView *collectionView;
@end
static NSString *kcellIdentifier=@"kcellIdentifier";
static NSString *kheaderIdentifier=@"kheaderIdentifier";
static NSString *kfooterIdentifier=@"kfooterIdentifier";
@implementation ViewController


-(void)jump
{
    UILabel *label=[[UILabel alloc]init];
    
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor greenColor];
    label.backgroundColor=[UIColor purpleColor];
    label.text=@"jlklsladfasdf";
    
    UIViewController *vc=[[UIViewController alloc]init];
    [vc.view addSubview:label];
    vc.view.backgroundColor=[UIColor whiteColor];
    label.size=CGSizeMake(200, 50);
    label.center=vc.view.center;
    
    label.layer.shadowColor=[UIColor blackColor].CGColor;
    label.layer.shadowOpacity=0.3f;
    label.layer.shadowOffset=CGSizeMake(0, 3);
    
    
    
    UIView *bg=[[UIView alloc]initWithFrame:CGRectMake(0, label.y+200, 300, 300*0.15)];
    bg.backgroundColor=[UIColor whiteColor];
    bg.layer.shadowColor=[UIColor blackColor].CGColor;
    bg.layer.shadowOpacity=0.3f;
    
    bg.layer.shadowOffset=CGSizeMake(0, 3);
    [vc.view addSubview:bg];
    //[self.view addSubview:vc.view];
    
    //[self performSelector:@selector(startIconViewAnimates:) withObject:label afterDelay:1.5];
    [self  presentViewController:vc animated:NO completion:^{
        //[self startIconViewAnimates:label];
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0].CGColor, (__bridge id)[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7].CGColor];
        gradientLayer.locations = @[@0.0,  @1.0];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0.0, 1);
        gradientLayer.frame = CGRectMake(0, 100, 300, 100);
        [vc.view.layer addSublayer:gradientLayer];
    }];
    //label.layer.anchorPoint=CGPointMake(0, 0.5);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:5 animations:^{
           // label.layer.transform=CATransform3DMakeRotation(M_PI , 0, 1, 0);;
        } completion:^(BOOL finished) {
            
        }];

        
    });
    //[self.navigationController pushViewController:vc animated:YES];
}
- (void)startIconViewAnimates:(UIView*)view
{
    CABasicAnimation *rotateAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    // 2.设置基本动画属性
    rotateAnim.fromValue = @(0);
    rotateAnim.toValue = @(M_PI * 2);
    rotateAnim.repeatCount = NSIntegerMax;
    rotateAnim.duration = 40;
    
    // 3.添加动画到图层上
    [view.layer addAnimation:rotateAnim forKey:@"rotate"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.navigationController.navigationBar.hidden=YES;
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [[UIApplication sharedApplication].keyWindow addSubview:btn];
    btn.titleLabel.font=[UIFont systemFontOfSize:20];
    
    btn.center=self.view.center;
    [btn setTitle:@"jump" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    

    self.title = @"UICollectionView学习";
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize=CGSizeMake(60, 80);
    layout.minimumLineSpacing=0;
    //layout.minimumInteritemSpacing=0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView=collectionView;
    self.collectionView.frame=self.view.bounds;
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    //collectionView.layer.transform=CATransform3DMakeRotation(M_PI , 0, 1, 0);;
    [self.view addSubview:collectionView];
    //通过Nib生成cell，然后注册 Nib的view需要继承 UICollectionViewCell
    [self.collectionView registerClass:[CellView class] forCellWithReuseIdentifier:kcellIdentifier];
    
    //注册headerView Nib的view需要继承UICollectionReusableView
    [self.collectionView registerClass:[HeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
    //注册footerView Nib的view需要继承UICollectionReusableView
    [self.collectionView registerClass:[FootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kfooterIdentifier];
    //
    self.collectionView.allowsMultipleSelection = YES;//默认为NO,是否可以多选
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -CollectionView datasource
//section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kcellIdentifier forIndexPath:indexPath];
    //赋值
    //UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
    //UILabel *label = (UILabel *)[cell viewWithTag:2];
   // NSString *imageName = [NSString stringWithFormat:@"%ld.JPG",(long)indexPath.row];
//imageView.image = [UIImage imageNamed:imageName];
    //label.text = imageName;
    //cell.layer.transform=CATransform3DMakeRotation(M_PI , 0, 1, 0);;
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
    
}
// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier;
    if ([kind isEqualToString: UICollectionElementKindSectionFooter ]){
        reuseIdentifier = kfooterIdentifier;
    }else{
        reuseIdentifier = kheaderIdentifier;
    }
    
    UICollectionReusableView *view =  [collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
    
    UILabel *label = (UILabel *)[view viewWithTag:1];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        label.text = [NSString stringWithFormat:@"这是header:%d",indexPath.section];
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        view.backgroundColor = [UIColor lightGrayColor];
        label.text = [NSString stringWithFormat:@"这是footer:%d",indexPath.section];
    }
    return view;
}
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60, 80);
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 5, 15);//分别为上、左、下、右
}
//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={320,45};
    return size;
}
//返回头footerView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size={320,45};
    return size;
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
//每个item之间的间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 100;
//}
//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.layer.transform=CATransform3DMakeRotation(M_PI_4 , 0, 1, 0);;


    [cell setBackgroundColor:[UIColor greenColor]];
}
//取消选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor redColor]];
}
@end
