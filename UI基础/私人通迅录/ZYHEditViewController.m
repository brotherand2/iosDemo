//
//  ZYHEditViewController.m
//  helloworld
//
//  Created by Apple on 16/1/20.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHEditViewController.h"

@interface ZYHEditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation ZYHEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nameField.text=self.modal.name;
    self.phoneField.text=self.modal.phone;
    
    [self.nameField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.phoneField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];

}
- (void)textChange
{
    self.saveBtn.enabled=self.nameField.text.length&&self.phoneField.text.length;
}
- (IBAction)editContact:(UIBarButtonItem*)sender
{
    BOOL isEdit=NO;
    if ([sender.title isEqualToString:@"编辑"]) {
        isEdit=YES;
    }
     sender.title=isEdit? @"取消":@"编辑";
    _nameField.enabled=isEdit;
    _phoneField.enabled=isEdit;
    _saveBtn.hidden=!isEdit;
    if (!isEdit) {
        _nameField.text=_modal.name;
        _phoneField.text=_modal.phone;
    }
    else
    [self.nameField becomeFirstResponder];
}
- (IBAction)save:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    _modal.name=_nameField.text;
    _modal.phone=_phoneField.text;
    if (_editContact) {
        _editContact(_modal);
    }
}
@end
