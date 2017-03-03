//
//  ViewController.m
//  选择国旗
//
//  Created by Apple on 16/1/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "ZYHFlagModal.h"
#import "ZYHFlagView.h"
@interface ViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,strong) NSArray *flags;
@property (weak, nonatomic) UIPickerView *pickerView;
@end

@implementation ViewController
//懒加载
- (NSArray *)flags
{
    if(_flags==nil)
    {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"flags.plist" ofType:nil];
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArray=[NSMutableArray array];
        for(NSDictionary *dict in dictArray)
        {
            ZYHFlagModal *flagModal=[ZYHFlagModal flagWithDict:dict];
            [tempArray addObject:flagModal];
        }
        _flags=tempArray;
    }
    return _flags;
}
- (UIPickerView *)pickerView
{
    if(nil==_pickerView)
    {
        UIPickerView *view=[[UIPickerView alloc]init];
        view.delegate=self;
        view.dataSource=self;
        view.center=self.view.center;
        [self.view addSubview:view];
        _pickerView=view;
    }
    return _pickerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.pickerView;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.flags.count;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    ZYHFlagView *flagView=[ZYHFlagView flagView:view];
    flagView.flagModal=self.flags[row];
    return flagView;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return [ZYHFlagView viewHeigh];
}

@end
