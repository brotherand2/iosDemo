//
//  ViewController.m
//  省级联动
//
//  Created by Apple on 16/1/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "ZYHProvincesModal.h"
@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong) NSArray *provinces;
@property (weak, nonatomic) UIPickerView *pickerView;
@property(nonatomic,assign) NSInteger provinceIndex;
@end

@implementation ViewController
//懒加载
- (NSArray *)provinces
{
    if(_provinces==nil)
    {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"provinces.plist" ofType:nil];
        NSArray *dictArray=[NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArray=[NSMutableArray array];
        for(NSDictionary *dict in dictArray)
        {
            ZYHProvincesModal *provincesModal=[ZYHProvincesModal provincesWithDict:dict];
            [tempArray addObject:provincesModal];
        }
        _provinces=tempArray;
    }
    return _provinces;
}
- (UIPickerView *)pickerView
{
    if (nil==_pickerView) {
        UIPickerView *view=[[UIPickerView alloc]init];
        view.center=self.view.center;
        view.delegate=self;
        view.dataSource=self;
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
    if (0==component) {
        return self.provinces.count;
    }
    else
    {
        ZYHProvincesModal *modal=self.provinces[self.provinceIndex];
        return modal.cities.count;
        
    }
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
- (UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label=nil;
    if (view) {
        label=(UILabel*)view;
    }
    else
        label=[[UILabel alloc]init];
    
    if (0==component) {
        ZYHProvincesModal *modal=self.provinces[row];
        label.text=modal.name;
        [label setBackgroundColor:[UIColor grayColor]];
    }
    else
    {
        ZYHProvincesModal*modal=self.provinces[self.provinceIndex];
        label.text=modal.cities[row];
        [label setBackgroundColor:[UIColor purpleColor]];
    }
    return label;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 44;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 0==component?150:100;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (0==component) {
        self.provinceIndex=row;
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
        [self.pickerView reloadComponent:1];
    }
}
@end
