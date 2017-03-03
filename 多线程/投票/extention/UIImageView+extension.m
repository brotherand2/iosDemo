#import "UIImageView+extension.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Extention.h"
@implementation UIImageView (extension)
- (void)setHeaderIconWithUrlStr:(NSString *)urlStr andPlaceHolderName:(NSString *)imageName andRadius:(NSInteger)radious
{
    UIImage *placeholder = [UIImage imageNamed:imageName];
    UIImage *newplaceholder=[UIImage roundImageWithImage:placeholder radius:radious];
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:newplaceholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [UIImage roundImageWithImage:image radius:radious] : placeholder;
    }];
}
@end
