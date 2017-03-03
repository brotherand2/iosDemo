

#import "ZYHTopWindow.h"
#import "UIView+Extension.h"
@implementation ZYHTopWindow
#define padding 50
static UIWindow *window_;

+ (void)initialize
{
    window_ = [[UIWindow alloc] init];
    window_.backgroundColor=[UIColor clearColor];
    window_.rootViewController = [UIViewController new];
    window_.frame = CGRectMake(padding, 0, [UIScreen mainScreen].bounds.size.width-padding*2, 20);
    window_.windowLevel = UIWindowLevelAlert;
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
}

+ (void)show
{
    window_.hidden = NO;
}

+ (void)hide
{
    window_.hidden = YES;
}

/**
 * 监听窗口点击
 */
+ (void)windowClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}

+ (void)searchScrollViewInView:(UIView *)superview
{
    for (UIScrollView *subview in superview.subviews)
    {
        // 如果是scrollview, 滚动最顶部
        if ([subview isKindOfClass:[UIScrollView class]] && subview.isShowingOnKeyWindow)
        {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        
        // 继续查找子控件
        [self searchScrollViewInView:subview];
    }
}
@end
