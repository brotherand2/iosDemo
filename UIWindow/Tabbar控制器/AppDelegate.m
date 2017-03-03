//
//  AppDelegate.m
//  Tabbar控制器
//
//  Created by Apple on 16/1/24.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UIWindow *window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UITabBarController *tabVC=[[UITabBarController alloc]init];
    
    UIViewController *vc1=[[UIViewController alloc]init];
    vc1.tabBarItem.title=@"联系人";
    vc1.tabBarItem.image=[UIImage imageNamed:@"tab_buddy_nor"];
    vc1.view.backgroundColor=[UIColor greenColor];
    
    UIViewController *vc2=[[UIViewController alloc]init];
    vc2.tabBarItem.title=@"动态";
    vc2.tabBarItem.image=[UIImage imageNamed:@"tab_qworld_nor"];
   vc2.view.backgroundColor=[UIColor purpleColor];
    UIViewController *vc3=[[UIViewController alloc]init];
    vc3.tabBarItem.title=@"设置";
    vc3.tabBarItem.image=[UIImage imageNamed:@"tab_me_nor"];
   vc3.view.backgroundColor=[UIColor blueColor];
    tabVC.viewControllers=@[vc1,vc2,vc3];
    window.rootViewController=tabVC;
    [window makeKeyAndVisible];
    self.window=window;
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
