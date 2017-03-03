//
//  ViewController.m
//  画板
//
//  Created by Apple on 16/1/28.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "ZYHPaintView.h"
#import "ZYHHandleView.h"
@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet ZYHPaintView *paintView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)valueChange:(UISlider*)sender
{
    _paintView.width=sender.value;
}
- (IBAction)colorBtnChange:(UIButton*)sender
{
    _paintView.color=sender.backgroundColor;
    
}
- (IBAction)undo:(UIButton*)sender
{
    [_paintView undo];
    
}
- (IBAction)clearPainter:(UIButton*)sender
{
    [_paintView clearScreen];
    
}
- (IBAction)erase:(UIButton*)sender
{
    [_paintView erase];
    
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (IBAction)photo:(UIButton*)sender
{
    //去用户的相册
    //照片选择器
    UIImagePickerController *imageVC=[[UIImagePickerController alloc]init];
    //相簿UIImagePickerControllerSourceTypePhotoLibrary
    //照片UIImagePickerControllerSourceTypeSavedPhotosAlbum
    imageVC.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self  presentViewController:imageVC animated:YES completion:nil];
    imageVC.delegate=self;
    
}
//在相册中选中某张图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image=info[UIImagePickerControllerOriginalImage];
    
    ZYHHandleView *handleView=[[ZYHHandleView alloc]initWithFrame:_paintView.bounds];
    handleView.backgroundColor=_paintView.backgroundColor;
    handleView.image=image;
    [_paintView clearScreen];
    handleView.handleBlock=^(UIImage *image)
    {
        
        _paintView.image=image;
    };
    [_paintView addSubview:handleView];
    //_paintView.image=image;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save:(UIButton*)sender
{
    
    [_paintView save];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
