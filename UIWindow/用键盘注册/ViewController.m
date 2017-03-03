//
//  ViewController.m
//  用键盘注册
//
//  Created by Apple on 16/1/17.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "ZYHKeyboardTool.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *birthdayView;
@property (strong, nonatomic)NSArray *fields;
@property (weak, nonatomic) UIDatePicker *datePicker;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setBirthdayKeyboard];
    [self setToolbar];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)keyboardFrameChange:(NSNotification *)noti
{
    CGRect keyboardRect=[noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY=keyboardRect.origin.y;
    NSInteger currentIndex=[self getCurrentResponderIndex];
    UITextField *field= self.fields[currentIndex];
    CGFloat maxY=CGRectGetMaxY(field.frame);
    if (maxY>keyboardY) {
        self.view.transform=CGAffineTransformMakeTranslation(0, keyboardY-maxY);
    }
    else
        self.view.transform=CGAffineTransformIdentity;
}
- (void)setBirthdayKeyboard
{
    UIDatePicker *datePicker=[[UIDatePicker alloc]init];
    datePicker.locale=[NSLocale localeWithLocaleIdentifier:@"zh"];
    datePicker.datePickerMode=UIDatePickerModeDate;
    self.birthdayView.inputView=datePicker;
    self.datePicker=datePicker;
}
- (void)setToolbar
{
    NSMutableArray *tempArray=[NSMutableArray array];
    for(UIView *view in self.view.subviews)
    {
        if ([view isKindOfClass:[UITextField class]]) {
            [tempArray addObject:view];
            UITextField *tf=(UITextField *)view;
            ZYHKeyboardTool *tool=[ZYHKeyboardTool keyboard];
            __weak __typeof__(self) contorller=self;
            tool.clickItem=^(ZYHKeyboardType type)
            {
                switch (type) {
                    case ZYHKeyboardFinish:
                       [contorller finish];
                        break;
                    case ZYHKeyboardPrevious:
                        [contorller previousField];
                        break;
                    case ZYHKeyboardNext:
                        [contorller nextField];
                        break;
                    default:
                        break;
                }
            };
            tf.inputAccessoryView=tool;
        }
    }
    self.fields=tempArray;
}
- (void)previousField
{
    NSInteger responderIndex=[self getCurrentResponderIndex];
    if (-1!=responderIndex) {
        NSInteger newIndex=responderIndex-1;
        if (newIndex>=0) {
            [self.fields[responderIndex] resignFirstResponder];
            [self.fields[newIndex] becomeFirstResponder];
        }
    }
}
- (void)nextField
{
    NSInteger responderIndex=[self getCurrentResponderIndex];
    if (-1!=responderIndex) {
        NSInteger newIndex=responderIndex+1;
        if (newIndex<self.fields.count) {
            [self.fields[responderIndex] resignFirstResponder];
            [self.fields[newIndex] becomeFirstResponder];
        }
    }

}
- (NSInteger)getCurrentResponderIndex
{
    for(UITextField *field in self.fields)
    {
        if(field.isFirstResponder)
            return [self.fields indexOfObject:field];
    }
    return -1;
}
- (void)finish
{
    if (self.birthdayView.isFirstResponder) {
        NSDate *date=self.datePicker.date;
        NSDateFormatter *format=[[NSDateFormatter alloc]init];
        format.dateFormat=@"YYYY-MM-dd";
        NSString *dateStr=[format stringFromDate:date];
        self.birthdayView.text=dateStr;
    }
    [self touchesBegan:nil withEvent:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
//    [UIView animateWithDuration:0.5 animations:^{
//        self.view.transform=CGAffineTransformIdentity;
//    }];
}
@end
