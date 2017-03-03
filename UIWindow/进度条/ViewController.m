//
//  ViewController.m
//  进度条
//
//  Created by Apple on 16/1/26.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "ZYHProcessCircle.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet ZYHProcessCircle *progressView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sliderChange:(UISlider*)sender
{
    self.progressView.progress=sender.value;
}
@end
