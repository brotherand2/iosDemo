//
//  ZYHPaintView.m
//  helloworld
//
//  Created by Apple on 16/1/28.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHPaintView.h"
#import "ZYHBezierPath.h"
#import "UIImage+Extention.h"
#import "MBProgressHUD+MJ.h"
@interface ZYHPaintView()
@property(nonatomic,strong) NSMutableArray *paths;

@end

@implementation ZYHPaintView
- (void)undo
{
    if (_paths) {
        [_paths removeLastObject];
    }
    [self setNeedsDisplay];
}
- (void)clearScreen
{
    [_paths removeAllObjects];
    [self setNeedsDisplay];
}
- (void)erase
{
    _color=self.backgroundColor;
}
- (void)setImage:(UIImage *)image
{
    _image=image;
    [_paths addObject:_image];
    [self setNeedsDisplay];
}
- (void)save
{
    UIImage *image=[UIImage clipScreenImageWithView:self];
    NSData *data=UIImagePNGRepresentation(image);
    [data writeToFile:@"/Users/apple/Desktop/save.png" atomically:YES];
    // Adds a photo to the saved photos album.  The optional completionSelector should have the form:
    //  - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
  
}
//保存到相册后调用
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(error)
        [MBProgressHUD showError:@"保存失败"];
    else
        [MBProgressHUD showSuccess:@"保存成功到相册"];
}
- (void)awakeFromNib
{
    _width=2;
    _color=[UIColor blackColor];
    _paths=[NSMutableArray array];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    ZYHBezierPath *path=[ZYHBezierPath paintPathWithLineWidth:_width andColor:_color];
    UITouch *touch=touches.anyObject;
    CGPoint startPoint=[touch locationInView:self];
    [path moveToPoint:startPoint];
    [_paths addObject:path];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    ZYHBezierPath *path=[_paths lastObject];
    UITouch *touch=touches.anyObject;
    CGPoint movePoint=[touch locationInView:self];
    [path addLineToPoint:movePoint];
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect
{
    for(ZYHBezierPath *path in _paths)
    {
        if ([path isKindOfClass:[UIImage class]]) {
            UIImage *image=(UIImage*)path;
            [image drawAtPoint:CGPointZero];
            continue;
        }
        [path.color set];
        [path stroke];
    }
}
@end
