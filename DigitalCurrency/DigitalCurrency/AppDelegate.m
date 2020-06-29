//
//  AppDelegate.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/6/29.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "AppDelegate.h"
#import "ZBHomeViewController.h"
#import "ZBMineViewController.h"
#import "ZBIndustryViewController.h"
#import "ZBInformationViewController.h"
#import "ZBFabuViewController.h"
#import "ZBloginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    ZBloginViewController *login_vc = [[ZBloginViewController alloc] init];
    self.window.rootViewController = login_vc;
    
   /*
    UITabBarController *tabVC = [[UITabBarController alloc] init];
    self.window.rootViewController = tabVC;
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:50/255.0 green:83/255.0 blue:250/255.0 alpha:1.0],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    tabVC.tabBar.backgroundColor = [UIColor whiteColor];
    
    ZBHomeViewController *home_vc = [[ZBHomeViewController alloc] init];
    home_vc.tabBarItem.title = @"首页";
    home_vc.tabBarItem.image = [UIImage imageNamed:@"shouye_unselected"];
    home_vc.tabBarItem.selectedImage = [UIImage imageNamed:@"shouye_selected"];
    [tabVC addChildViewController:home_vc];
    
    ZBIndustryViewController *industry_vc = [[ZBIndustryViewController alloc] init];
    industry_vc.tabBarItem.title = @"行情";
    industry_vc.tabBarItem.image = [UIImage imageNamed:@"hangqing_unselected"];
    industry_vc.tabBarItem.selectedImage = [UIImage imageNamed:@"hangqing_selected"];
    [tabVC addChildViewController:industry_vc];
    
    ZBFabuViewController *fabu_vc = [[ZBFabuViewController alloc] init];
    fabu_vc.tabBarItem.image = [UIImage imageNamed:@"fabu"];
    fabu_vc.tabBarItem.selectedImage = [UIImage imageNamed:@"fabu"];
    [tabVC addChildViewController:fabu_vc];
    
    
    ZBInformationViewController *information_vc = [[ZBInformationViewController alloc] init];
    information_vc.tabBarItem.title = @"资讯";
    information_vc.tabBarItem.image = [UIImage imageNamed:@"zixun_unselected"];
    information_vc.tabBarItem.selectedImage = [UIImage imageNamed:@"zixun_selected"];
    [tabVC addChildViewController:information_vc];
    
    ZBMineViewController *mine_vc = [[ZBMineViewController alloc] init];
    mine_vc.tabBarItem.title = @"我的";
    mine_vc.tabBarItem.image = [UIImage imageNamed:@"wode_unselected"];
    mine_vc.tabBarItem.selectedImage = [UIImage imageNamed:@"wode_selected"];
    [tabVC addChildViewController:mine_vc];*/
     
 
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


//#pragma mark - UISceneSession lifecycle
//
//
//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
