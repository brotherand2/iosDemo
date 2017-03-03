//
//  VideoController.m
//  多线程
//
//  Created by Apple on 16/2/13.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "VideoController.h"
#import "ZYHVideoModal.h"
@interface VideoController ()<NSXMLParserDelegate>
@property(nonatomic,strong) NSMutableArray *videos;
@property(nonatomic,strong) ZYHVideoModal *currentModal;
@property(nonatomic,strong) NSMutableString *elementString;
@end

@implementation VideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _videos=[NSMutableArray array];
    
    _elementString=[NSMutableString string];
    [self loadData:nil];
}

- (IBAction)loadData:(id)sender

{
    NSLog(@"load");
    NSString *urlStr=[NSString stringWithFormat:@"http://%@/videos.xml",IPAdd];
    NSURL *url=[NSURL URLWithString:urlStr];
    //NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSURLRequest *request=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(connectionError||data==nil)
            return ;
        NSXMLParser *paser=[[NSXMLParser alloc]initWithData:data];
        paser.delegate=self;
        [paser parse];
    }];

}

-  (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"1 开始解悉文档");
    [self.videos removeAllObjects];
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"5结束解悉文档");
    __weak typeof(self)selfObj=self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [selfObj.tableView reloadData];
        [selfObj.refreshControl endRefreshing];
        NSLog(@"%@",selfObj.videos);
    });
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    NSLog(@"2开始节点%@---%@",elementName,attributeDict);
    if([elementName isEqualToString:@"video"])
    {
        _currentModal=[[ZYHVideoModal alloc]init];
        self.currentModal.videoId=attributeDict[@"videoId"];
        
    }
    [self.elementString setString:@""];
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSLog(@"3发现节点内容%@",string);
    [self.elementString appendString:string];
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"结束节点%@",elementName);
    if([elementName isEqualToString:@"video"])
    {
        [self.videos addObject:self.currentModal];
    }
    else if (![elementName isEqualToString:@"videos"])
        [self.currentModal setValue:self.elementString forKeyPath:elementName];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videos.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    ZYHVideoModal *modal=self.videos[indexPath.row];
    cell.textLabel.text=modal.name;
    return cell;
}
@end
