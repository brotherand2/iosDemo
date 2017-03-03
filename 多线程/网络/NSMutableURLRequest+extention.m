//
//  NSMutableURLRequest+extention.m
//  多线程
//
//  Created by Apple on 16/2/17.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "NSMutableURLRequest+extention.h"
# define ZYHEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]
@implementation NSMutableURLRequest (extention)
+  (void)upload:(NSString *)name fileName:(NSString *)fileName urlStr:(NSString *)urlStr data:(NSData *)data params:(NSDictionary *)params
{
    static NSString *boundary=@"zyhupload";
    NSURL *url=[NSURL URLWithString:urlStr];
    NSMutableURLRequest *request=[self requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15];
    request.HTTPMethod=@"POST";
    //设置请求头
    NSString *requestHead=[NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request setValue:requestHead forHTTPHeaderField:@"Content-Type"];
    NSMutableData *dataM=[NSMutableData data];
        //设置请求体
    NSString *str=[NSString stringWithFormat:@"--%@\r\n",boundary];
    [dataM appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    str=[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\nContent-Type: application/octet-stream\r\n\r\n",name, fileName];
    [dataM appendData:ZYHEncode(str)];
    [dataM appendData:data];
     [dataM appendData:ZYHEncode(@"\r\n")];
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *str=[NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n%@",boundary,key,obj];
        [dataM appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    }];
    str=[NSString stringWithFormat:@"\r\n--%@--",boundary];
    [dataM appendData:ZYHEncode(str)];
    request.HTTPBody=dataM;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(connectionError)
          NSLog(@"%@",connectionError);
        if(connectionError||data==nil)
            return ;
        id result=[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        NSLog(@"result=%@",result);
    }];

}
@end
