//
//  AppDelegate.m
//  CNNavigationDemo
//
//  Created by 葱泥 on 16/7/29.
//  Copyright © 2016年 葱泥. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
#warning 全局Bar设置，当然你可以不设置，使用全局设置，可以方便的管理bar的UI样式等，可以轻松实现换肤等功能
    NSDictionary *barSettingDictionary = @{kCNNavigationBarTitleFont: [UIFont systemFontOfSize:18.0],
                                           kCNNavigationBarTitleColor: [UIColor whiteColor],
                                           kCNNavigationBarLeftTitleFont: [UIFont systemFontOfSize:14.0],
                                           kCNNavigationBarLeftTitleColor: [UIColor whiteColor],
                                           kCNNavigationBarLeftIconImage: [UIImage imageNamed:@"image.bundle/NavigationBarImage_back_icon"],
                                           kCNNavigationBarBackgroundColor: [UIColor grayColor]};
    [CNBaseViewController globalSettingNavigationBar:barSettingDictionary];
    
    
    ViewController *vc = [[ViewController alloc] init];
    
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:vc];
    /**
     *  隐藏系统自带的Bar
     */
    navigationVC.navigationBarHidden = YES;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navigationVC;
    self.window.backgroundColor = [UIColor whiteColor];
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
