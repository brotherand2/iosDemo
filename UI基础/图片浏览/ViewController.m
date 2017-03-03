//
//  ViewController.m
//  图片浏览
//
//  Created by Apple on 15/11/24.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,assign)NSInteger photeIndex;
@property(nonatomic,strong)NSMutableArray *images;
- (IBAction)next:(id)sender;
-( IBAction)previous:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *show;
@property (weak, nonatomic) IBOutlet UIButton *previousBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self changeData];
}
- (IBAction)resumeGame:(id)sender {
}
- (NSArray *)images
{
    if(!_images)
    {
        _images=[NSMutableArray array];
        for(int i=0;i<10;i++)
        {
            NSString *fileName=[NSString stringWithFormat:@"%d.png",i+1];
            NSMutableDictionary *dict=[NSMutableDictionary dictionary];
            dict[@"icon"]=fileName;
            dict[@"desc"]=[NSString stringWithFormat:@"这是第%d张图片",i+1];
            [_images addObject:dict];
        }
    }
    return _images;
}
- (void)changeData
{
    self.numberLabel.text=[NSString stringWithFormat:
                           @"%ld/%ld",self.photeIndex+1,self.images.count];
    NSDictionary *dict=self.images[self.photeIndex];
    self.show.image=[UIImage imageNamed:dict[@"icon"]];
    self.descLabel.text=dict[@"desc"];
    self.previousBtn.enabled=(self.photeIndex!=0);
    self.nextBtn.enabled=(self.photeIndex!=self.images.count-1);
}
- (void)next:(id)sender
{
    self.photeIndex++;
    [self changeData];
}
- (void)previous:(id)sender
{
    self.photeIndex--;
    [self changeData];
}
@end
