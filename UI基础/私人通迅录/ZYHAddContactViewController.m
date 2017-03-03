//
//  ZYHAddContactViewController.m
//  helloworld
//
//  Created by Apple on 16/1/20.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHAddContactViewController.h"
#import "ZYHContactModal.h"

@interface ZYHAddContactViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation ZYHAddContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.nameField becomeFirstResponder];
    [self.nameField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.phoneField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];

}

- (IBAction)save:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    ZYHContactModal *modal=[ZYHContactModal contactWithName:_nameField.text andPhone:_phoneField.text];
    if (_addContact) {
        _addContact(modal);
    }
}
- (void)textChange
{
    self.saveBtn.enabled=self.nameField.text.length&&self.phoneField.text.length;
}
@end
