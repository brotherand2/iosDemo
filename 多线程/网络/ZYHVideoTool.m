//
//  ZYHVideoTool.m
//  多线程
//
//  Created by Apple on 16/2/19.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHVideoTool.h"
#import "VideoModal.h"
#import "GDataXMLNode.h"
@interface ZYHVideoTool()<NSXMLParserDelegate>
@property(nonatomic,strong) NSMutableArray *videos;
@end

@implementation ZYHVideoTool
+ (NSArray*)parseXMLData:(NSData *)data
{
    ZYHVideoTool *tool=[[ZYHVideoTool alloc]init];
    
    //return [tool SAXParseXMLData:data];
    return [tool DomParseData:data];
}
+ (NSArray*)parseJSONData:(NSData *)data
{
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    NSArray *array=dict[@"videos"];
    NSMutableArray *videos=[NSMutableArray array];
    if(array)
    {
        
        for(NSDictionary * dict in array)
        {
            VideoModal *modal=[VideoModal videoWithDict:dict];
            [videos addObject:modal];
        }
    }
    return videos;
}
- (NSArray*)DomParseData:(NSData*)data
{
    GDataXMLDocument *document=[[GDataXMLDocument alloc]initWithData:data error:NULL];
    GDataXMLElement *rootElement=[document rootElement];
    NSArray *array=[rootElement elementsForName:@"video"];
    self.videos=[NSMutableArray array];
    for(GDataXMLElement*element in array)
    {
        /*
         {"id":2,"image":"resources/images/minion_02.png","length":12,"name":"小黄人 第02部","url":"resources/videos/minion_02.mp4"},
         */
        VideoModal *modal=[[VideoModal alloc]init];
        modal.name=[[element attributeForName:@"name"]stringValue];
        modal.identifier=[[element attributeForName:@"id"]stringValue];
        modal.length=[[[element attributeForName:@"length"]stringValue]integerValue];
        modal.imageName=[[element attributeForName:@"image"]stringValue];
        modal.url=[[element attributeForName:@"url"]stringValue];
        [self.videos addObject:modal];
    }
    return self.videos;
}
- (NSArray*)SAXParseXMLData:(NSData*)data
{
    NSXMLParser *parser=[[NSXMLParser alloc]initWithData:data];
    parser.delegate=self;
    [parser parse];
    NSLog(@"卡在这里%@",[NSThread currentThread]);
    return self.videos;
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    if([elementName isEqualToString:@"videos"])
        self.videos=[NSMutableArray array];
    else if ([elementName isEqualToString:@"video"])
    {
        VideoModal *modal=[VideoModal videoWithDict:attributeDict];
        [self.videos addObject:modal];
    }
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
}
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
     NSLog(@"%s",__func__);
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"%s",__func__);
}

@end
