

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property(nonatomic,assign)   CGSize size;
@property(nonatomic,assign)   CGPoint origin;
@property(nonatomic,assign)   CGFloat centerX;
@property(nonatomic,assign)   CGFloat centerY;
/**
* 判断一个控件是否真正显示在主窗口
*/
- (BOOL)isShowingOnKeyWindow;
/**
 *  视图左右 摇晃
 *
 *  @param enabled yes 为开启,No 为关闭
 */
- (void)shakeStatus:(BOOL)enabled;

/**
 *  设置底部分隔线
 */
-(void)setBottomBorder;
-(void)setBottomBorder:(UIColor*)borderColor;
-(void)setTopBorder:(UIColor*)borderColor;
-(void)setTopBoder;
-(void)setCornerRadius;
-(void)setCornerWithRadius:(NSInteger)radius;
@end
