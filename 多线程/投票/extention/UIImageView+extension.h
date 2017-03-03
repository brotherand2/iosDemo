
#import <UIKit/UIKit.h>

@interface UIImageView (extension)
/**
 *  下载图片
 *
 *  @param url       远程图片url
 *  @param imageName 占位图片名
 */
- (void)setHeaderIconWithUrlStr:(NSString *)urlStr andPlaceHolderName:(NSString*)imageName andRadius:(NSInteger)radious;
@end
