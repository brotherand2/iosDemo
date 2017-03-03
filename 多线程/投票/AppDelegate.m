//
//  AppDelegate.m
//  投票
//
//  Created by Apple on 2016/11/24.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "AppDelegate.h"
#import "VoteResultViewController.h"
#import "RangeViewController.h"
#import "VoteTimeViewController.h"
#import "ViewController.h"
#import "FileViewController.h"
#import "SettingViewController.h"
#import "CompanyViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
static char TAG_ACTIVITY_INDICATOR;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"%p",&TAG_ACTIVITY_INDICATOR);
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //CompanyViewController *test=[[CompanyViewController alloc]init];
    // Override point for customization after application launch.
    UITabBarController *tabVC=[[UITabBarController alloc]init];
    ViewController *voteVC=[[ViewController alloc]init];
    voteVC.tabBarItem.image=[UIImage imageNamed:@"tabBar_essence_icon"];
    voteVC.title=@"投票";
    
    VoteResultViewController *resultVC=[[VoteResultViewController alloc]init];
    resultVC.tabBarItem.image=[UIImage imageNamed:@"tabBar_friendTrends_icon"];
    resultVC.title=@"投票公司";
    
    RangeViewController *rangeVC=[[RangeViewController alloc]init];
    rangeVC.tabBarItem.image=[UIImage imageNamed:@"tabBar_new_icon"];
    rangeVC.title=@"投票范围";
    
    VoteTimeViewController *timeVC=[[VoteTimeViewController alloc]init];
    timeVC.tabBarItem.image=[UIImage imageNamed:@"tabBar_me_icon"];
    timeVC.title=@"投票时间";
    
    SettingViewController *fileVC=[[SettingViewController alloc]init];
    fileVC.tabBarItem.image=[UIImage imageNamed:@"tabBar_me_icon"];
    fileVC.title=@"投票文件";
    
    tabVC.viewControllers=@[voteVC,resultVC,fileVC, timeVC,rangeVC];
    self.window.rootViewController=tabVC;
     [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
