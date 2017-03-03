//
//  ViewController.h
//  calculate
//
//  Created by Apple on 15/11/23.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction) calculate;
@property(nonatomic,weak)IBOutlet UITextField *textField1;
@property(nonatomic,weak)IBOutlet UITextField *textField2;
@property(nonatomic,weak)IBOutlet UILabel *label;

@end

