//
//  ViewController.m
//  点餐系统
//
//  Created by Apple on 16/1/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *fruitView;
@property (weak, nonatomic) IBOutlet UILabel *meatView;
@property (weak, nonatomic) IBOutlet UILabel *juiceView;
@property(nonatomic,strong) NSArray *foods;
@end

@implementation ViewController
- (NSArray *)foods
{
    if (_foods==nil) {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"foods.plist" ofType:nil];
        _foods=[NSArray arrayWithContentsOfFile:path];
    }
    return _foods;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    for (NSInteger i=0; i<self.foods.count; i++) {
        [self pickerView:nil didSelectRow:0 inComponent:i];
    }
}
//每一列返回多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.foods[component] count];
}
//返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.foods.count;
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.foods[component][row];
}
//  选中了pickerView的第component列第row行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(0==component)
        self.fruitView.text=self.foods[0][row];
    else if (1==component)
        self.meatView.text=self.foods[1][row];
    else
        self.juiceView.text=self.foods[2][row];
}
- (IBAction)random :(id)sender
{
    for (NSInteger i=0; i<self.foods.count; i++) {
        NSInteger row=[self.pickerView selectedRowInComponent:i];
        NSInteger count=[self.foods[i] count];
        NSInteger newRow;
        do {
            newRow=arc4random()%count;
        } while (newRow==row);
        [self pickerView:nil didSelectRow:newRow inComponent:i];
        [self.pickerView selectRow:newRow inComponent:i animated:YES];
    }
}
@end
