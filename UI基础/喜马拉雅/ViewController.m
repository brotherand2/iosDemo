//
//  ViewController.m
//  喜马拉雅
//
//  Created by Apple on 15/11/27.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *lastView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.scrollView.contentSize=CGSizeMake(0, self.scrollView.frame.size.height+self.lastView.frame.size.height);
    //[NSThread sleepForTimeInterval:3.0];
    self.scrollView.contentSize=CGSizeMake(0,CGRectGetMaxY(self.lastView.frame) );
    self.scrollView.contentInset=UIEdgeInsetsMake(64, 0, 60, 0);
    self.scrollView.contentOffset=CGPointMake(0, -64);//原点为-64
}


@end
