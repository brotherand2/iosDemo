//
//  ZYHShareViewController.m
//  微博
//
//  Created by Apple on 16/2/5.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ZYHShareViewController.h"
#import "ZYHSettingItem.h"
#import "ZYHItemGroup.h"
#import <MessageUI/MessageUI.h>

@interface ZYHShareViewController ()<MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>


@end

@implementation ZYHShareViewController
- (void)addGroupOne
{
    ZYHSettingItem *shareToSina=[ZYHSettingItem settingItemWithTitle:@"新浪微博" icon:@"WeiboSina" vcCalss:nil];
    shareToSina.operation=^
    {
        NSURL *url=[NSURL URLWithString:@"http://www.baidu.com"];
        [[UIApplication sharedApplication]openURL:url];
    };
    ZYHSettingItem *messageShare=[ZYHSettingItem settingItemWithTitle:@"短信分享" icon:@"SmsShare" vcCalss:nil];
    __weak typeof(self) selfObj=self;
    
    messageShare.operation=^
    {
        //方法1,不能指定短信内容，不能回到原应用
//        UIApplication *app=[UIApplication sharedApplication];
//        NSURL *url=[NSURL URLWithString:@"sms://10086"];
//        
//        [app openURL:url];
        //方法2
        MFMessageComposeViewController *messageVC=[[MFMessageComposeViewController alloc]init];
        messageVC.body=@"你吃饭了吗?";//短信内容
        messageVC.recipients=@[@"10086",@"13750528276"];//收件人
        messageVC.messageComposeDelegate=selfObj;
        [selfObj presentViewController:messageVC animated:YES completion:nil];
        
    };
    ZYHSettingItem *mailShare=[ZYHSettingItem settingItemWithTitle:@"邮件分享" icon:@"MailShare" vcCalss:nil];
    mailShare.operation=^
    {
        //方法1,不能指定短信内容，不能回到原应用
        //NSURL *url=[NSURL URLWithString:@"mailto://547996854@qq.com"];
        //[[UIApplication sharedApplication]openURL:url];
        MFMailComposeViewController *mailVc=[[MFMailComposeViewController alloc]init];
        mailVc.mailComposeDelegate = selfObj;
        
        [mailVc setSubject:@"我的邮箱测试"];
        [mailVc setToRecipients:@[@"547996854@qq.com"]];//收件人
        //抄送
        [mailVc setCcRecipients:@[@"547996854@qq.com",@"2387904913@qq.com"]];
        //密送
        [mailVc setBccRecipients:@[@"brothand2@outlook.com"]];
        [mailVc setMessageBody:@"HOW ARE YOU" isHTML:NO];//内容
        
        UIImage *image = [UIImage imageNamed:@"DSC_2009_RF"];
        [mailVc addAttachmentData:UIImageJPEGRepresentation(image, 0.7) mimeType:@"image/jpeg" fileName:@"DSC_2009_RF.jpg"];
        
        [selfObj presentViewController:mailVc animated:YES completion:nil];
        
    };
    ZYHItemGroup *group=[[ZYHItemGroup alloc]init];
    group.items=@[shareToSina,messageShare,mailShare];
    [self.data addObject:group];
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
   [controller dismissViewControllerAnimated:YES completion:nil];
    switch (result)
    {
        case MessageComposeResultCancelled:
            NSLog(@"短信取消");
            break;
        case MessageComposeResultFailed:
            NSLog(@"短信失败");
            break;
        case MessageComposeResultSent:
            NSLog(@"短信已经发出");
            break;
    }

}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"邮件取消");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"邮件失败");
            break;
        case MFMailComposeResultSent:
            NSLog(@"邮件已经发出");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"邮件已经保存");
            break;
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGroupOne];
    // Do any additional setup after loading the view.
}


@end
