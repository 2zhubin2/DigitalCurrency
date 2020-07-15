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
#import "ZBBaseTabBarController.h"


@interface AppDelegate ()

@property(nonatomic,weak)UINavigationController *nav_mine;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    ZBBaseTabBarController *tabVC = [[ZBBaseTabBarController alloc] init];
    
    self.window.rootViewController = tabVC;

    [self.window makeKeyAndVisible];
    
    [self determineWhetherToLogin];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginSuccess) name:@"LoginSuccess" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zhuxiao) name:@"zhuxiao" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tuichuLogin) name:@"tuichuLogin" object:nil];
//    NSLog(@"%@",NSHomeDirectory());
    
    return YES;
}


-(void)LoginSuccess{
    [self determineWhetherToLogin];
    self.mineUserInfoModel_baseInfo = self.mineUserInfoModel;
}

-(void)zhuxiao{
    [self determineWhetherToLogin];
    self.mineUserInfoModel_baseInfo = nil;
}
-(void)tuichuLogin{
    [self determineWhetherToLogin];
}

#pragma mark - 判断是否登录
/**判断是否登录*/
- (void)determineWhetherToLogin
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user.plist"];
    self.mineUserInfoModel = [ZBMineUserInfoModel mj_objectWithFile:path];
    if (self.mineUserInfoModel == nil) {
        self.login = NO;
    } else {
        self.login = YES;
    }
}





@end
