//
//  ViewController.m
//  存档
//
//  Created by Apple on 16/1/20.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.textView.text=nil;
}

- (IBAction)saveArray:(id)sender
{
    NSString *str=NSHomeDirectory();
    NSString *docPath=[str stringByAppendingString:@"/Document"];
    NSString *path=[str stringByAppendingPathComponent:@"document"];
    NSString * search= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    self.textView.text=search;
    NSString *savePath=[search stringByAppendingPathComponent:@"data.plist"];
    NSArray *array=@[@1,@3.0,@"hello world!"];
    [array writeToFile:savePath atomically:YES];
}
- (IBAction)readArray:(id)sender
{
    NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *docPath=[path stringByAppendingPathComponent:@"data.plist"];
    NSArray *array=[NSArray arrayWithContentsOfFile:docPath];
    NSLog(@"%@",array);
}
//偏好设置位置
- (IBAction)saveDocument:(id)sender
{
    //删掉存档文件后，不能再创建，因为这个键值还在内存中,没有新键值就不会创建新文件
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:@"hello world" forKey:@"zyh"];
    [defaults synchronize];
}
- (IBAction)readDocument:(id)sender
{
    NSUserDefaults *defults=[NSUserDefaults standardUserDefaults];
    NSString *str= [defults objectForKey:@"zyh"];
    self.textView.text=str;
}
- (IBAction)saveArchive:(id)sender
{
    Person *person=[[Person alloc]init];
     person.name=@"zyh";
    person.age=26;
    person.height=1.61;
    Person *p1=[[Person alloc]initWithAge:17 andHeight:1.54 angName:@"abc"];
    Person *p2=[[Person alloc]initWithAge:19 andHeight:1.67 angName:@"dfsdf"];
    NSString *docPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *path=[docPath stringByAppendingPathComponent:@"zyh.data"];
    [NSKeyedArchiver archiveRootObject:person toFile:path];
    NSString *path2=[docPath stringByAppendingPathComponent:@"test.txt"];
    NSMutableData *data=[NSMutableData data];
    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:p1 forKey:@"p1"];
    [archiver encodeObject:p2 forKey:@"p2"];
    [archiver finishEncoding];
    [data writeToFile:path2 atomically:YES];
}

- (IBAction)readArchive:(id)sender
{
    NSString *docPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *path=[docPath stringByAppendingPathComponent:@"zyh.data"];
    Person *person=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"%@",person);
    self.textView.text=person.description;
    NSString *path2=[docPath stringByAppendingPathComponent:@"test.txt"];
    NSMutableData *data=[NSMutableData dataWithContentsOfFile:path2];
    NSKeyedUnarchiver *archiver=[[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    Person *p1=[archiver decodeObjectForKey:@"p1"];
    Person *p2=[archiver decodeObjectForKey:@"p2"];
    [archiver finishDecoding];
    NSLog(@"p1=%@",p1);
    NSLog(@"p2=%@",p2);
}
@end
