//
//  ZYHSettingCell.m
//  微博
//
//  Created by Apple on 16/2/5.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHSettingCell.h"
@interface ZYHSettingCell()
@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong) UISwitch *switchView;
@property(nonatomic,strong) UIImageView *arrow;
@end

@implementation ZYHSettingCell
- (UILabel *)label
{
    if(_label==nil)
    {
        _label=[[UILabel alloc]init];
        _label.bounds=CGRectMake(0, 0, 80, 44);
        _label.textAlignment=NSTextAlignmentRight;
        [_label addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _label;
}
- (void)dealloc
{
    [_label removeObserver:self forKeyPath:@"text"];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setObject:_label.text forKey:self.item.title];
    [userDefault synchronize];
}
- (UIImageView *)arrow
{
    if (_arrow==nil) {
        _arrow=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"CellArrow"]];
    }
    return _arrow;
}
- (UISwitch *)switchView
{
    if (_switchView==nil)
    {
        _switchView=[[UISwitch alloc]init];
        [_switchView addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchView;
}
- (void)lableValueChange:(UILabel*)label
{
    
}
-(void)valueChange:(UISwitch*)switchView
{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setBool:switchView.on forKey:self.item.title];
    [userDefault synchronize];
}
- (void)awakeFromNib
{
    // Initialization code
}
//获取cell
+ (instancetype)cellWithTableView:(UITableView *)tableView andItem:(ZYHSettingItem *)item
{
    static NSString *identifier=@"cell";
    ZYHSettingCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil)
    {
        UITableViewCellStyle style=item.subTitle?UITableViewCellStyleSubtitle:UITableViewCellStyleDefault;
        cell=[[ZYHSettingCell  alloc]initWithStyle:style reuseIdentifier:identifier];
    }
    cell.item=item;
    return  cell;
}

- (void)setItem:(ZYHSettingItem *)item
{
    _item=item;
    self.textLabel.text=item.title;
    if(item.icon)
        self.imageView.image=[UIImage imageNamed:item.icon];
    self.detailTextLabel.text=item.subTitle;
    self.selectionStyle=UITableViewCellSelectionStyleDefault;
    switch (item.itemType)
    {
        case ZYHItemArrow:
            self.accessoryView=self.arrow;
            break;
        case ZYHItemDefault:
            self.accessoryView=nil;
            break;
        case ZYHItemLabel:
            if (item.labelText) {
                self.label.text=item.labelText;
            }
            else
                self.label.text=[[NSUserDefaults standardUserDefaults]objectForKey:item.title];
            self.accessoryView=self.label;
            break;
        case ZYHItemSwitch:
            self.accessoryView=self.switchView;
            self.switchView.on=[[NSUserDefaults standardUserDefaults]boolForKey:item.title];
            self.selectionStyle=UITableViewCellSelectionStyleNone;
            break;
    }

}

@end
