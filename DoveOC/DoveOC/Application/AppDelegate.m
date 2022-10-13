//
//  AppDelegate.m
//  DoveOC
//
//  Created by DOVE on 2022/1/5.
//

#import "AppDelegate.h"

#import "HDHomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 测试的时候注释，看Modules中的内容时打开
//    [self p_modulesHomeViewController];
    
    return YES;
}

/// Modules 的目录首页
- (void)p_modulesHomeViewController {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = UIColor.whiteColor;
    HDHomeViewController *homeVC = [[HDHomeViewController alloc] init];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:homeVC];
    [self.window makeKeyAndVisible];
    
}

@end
