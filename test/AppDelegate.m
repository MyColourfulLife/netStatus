//
//  AppDelegate.m
//  test
//
//  Created by 黄家树 on 2017/4/6.
//  Copyright © 2017年 huangjiashu. All rights reserved.
//

#import "AppDelegate.h"

#import <AFNetworkReachabilityManager.h>

#import "Reachability.h"


@interface AppDelegate ()
@property (nonatomic ,strong) Reachability *reachAblity;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//        [self afnStartMonaite];
    [self systemStartMonaite];
    return YES;

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


/**
 使用afn监听网络
 */
-(void)afnStartMonaite{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}


/**
 使用Reachability监听网络状态
 www.hcios.com是苹果远程通知的域名
 */
-(void)systemStartMonaite{
   Reachability *reachAblity = [Reachability  reachabilityWithHostName:@"www.hcios.com"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilitychanged:) name:kReachabilityChangedNotification object:nil];
    [reachAblity startNotifier];
    self.reachAblity = reachAblity;
}

-(void)reachabilitychanged:(NSNotification *)notice{
    Reachability *reachAbility =  notice.object;
    if ([notice.object isKindOfClass:[Reachability class]]) {
    
      NetworkStatus status =  [reachAbility currentReachabilityStatus];
        
        switch (status) {
            case NotReachable:
                NSLog(@"网络不可用");
                break;
                
                case ReachableViaWiFi:
                NSLog(@"wifi已连接");
                break;
                
                case ReachableViaWWAN:
                NSLog(@"正在使用移动网络");
                break;
                
            default:
                break;
        }
        
        
    }
    
}

@end
