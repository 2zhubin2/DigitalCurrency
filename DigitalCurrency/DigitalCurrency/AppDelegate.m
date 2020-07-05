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
#import "ZBFreepwViewController.h"
#import "ZBFaBuBaseViewController.h"


@interface AppDelegate ()

@property(nonatomic,weak)UINavigationController *nav_mine;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //test VC
//    ZBloginViewController *login_vc = [[ZBloginViewController alloc] init];
//    self.window.rootViewController = login_vc;
//    ZBFreepwViewController *freepw_vc = [[ZBFreepwViewController alloc] init];
//    self.window.rootViewController = freepw_vc;
    
    
   
    UITabBarController *tabVC = [[UITabBarController alloc] init];
    self.window.rootViewController = tabVC;
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:50/255.0 green:83/255.0 blue:250/255.0 alpha:1.0],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    tabVC.tabBar.backgroundColor = [UIColor whiteColor];
    
    ZBHomeViewController *home_vc = [[ZBHomeViewController alloc] init];
    UINavigationController *nav_home = [[UINavigationController alloc] initWithRootViewController:home_vc];
    nav_home.navigationBar.hidden = YES;
    nav_home.tabBarItem.title = @"首页";
    nav_home.tabBarItem.image = [UIImage imageNamed:@"shouye_unselected"];
    nav_home.tabBarItem.selectedImage = [UIImage imageNamed:@"shouye_selected"];
    [tabVC addChildViewController:nav_home];
    
    

    
    ZBIndustryViewController *industry_vc = [[ZBIndustryViewController alloc] init];
    UINavigationController *nav_industry = [[UINavigationController alloc] initWithRootViewController:industry_vc];
    nav_industry.navigationBar.hidden = YES;
   nav_industry.tabBarItem.title = @"行情";
    nav_industry.tabBarItem.image = [UIImage imageNamed:@"hangqing_unselected"];
    nav_industry.tabBarItem.selectedImage = [UIImage imageNamed:@"hangqing_selected"];
    [tabVC addChildViewController:nav_industry];
    
    ZBFaBuBaseViewController *fabu_vc = [[ZBFaBuBaseViewController alloc] init];
    UINavigationController *nav_fabu = [[UINavigationController alloc] initWithRootViewController:fabu_vc];
    nav_fabu.tabBarItem.image = [UIImage imageNamed:@"fabu"];
    nav_fabu.tabBarItem.selectedImage = [UIImage imageNamed:@"fabu"];
    [tabVC addChildViewController:nav_fabu];
    
    
    ZBInformationViewController *information_vc = [[ZBInformationViewController alloc] init];
    UINavigationController *nav_information = [[UINavigationController alloc] initWithRootViewController:information_vc];
    nav_information.navigationBar.hidden = YES;
    nav_information.tabBarItem.title = @"资讯";
    nav_information.tabBarItem.image = [UIImage imageNamed:@"zixun_unselected"];
    nav_information.tabBarItem.selectedImage = [UIImage imageNamed:@"zixun_selected"];
    [tabVC addChildViewController:nav_information];
    
    ZBMineViewController *mine_vc = [[ZBMineViewController alloc] init];
    UINavigationController *nav_mine = [[UINavigationController alloc] initWithRootViewController:mine_vc];
    nav_mine.navigationBar.hidden = YES;
    nav_mine.tabBarItem.title = @"我的";
    nav_mine.tabBarItem.image = [UIImage imageNamed:@"wode_unselected"];
    nav_mine.tabBarItem.selectedImage = [UIImage imageNamed:@"wode_selected"];
    [tabVC addChildViewController:nav_mine];
    _nav_mine = nav_mine;
     
    
    
    [self.window makeKeyAndVisible];//MineShow
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterSetter) name:@"enterSetter" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MineShow) name:@"MineShow" object:nil];
    
    return YES;
}
-(void)enterSetter{
    self.nav_mine.navigationBar.hidden = NO;
}

-(void)MineShow{
    self.nav_mine.navigationBar.hidden = YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
