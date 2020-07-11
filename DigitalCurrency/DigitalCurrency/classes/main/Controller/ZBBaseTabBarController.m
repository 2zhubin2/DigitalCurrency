//
//  ZBBaseTabBarController.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/7.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBBaseTabBarController.h"
#import "ZBHomeViewController.h"
#import "ZBMineViewController.h"
#import "ZBIndustryViewController.h"
#import "ZBInformationViewController.h"
#import "ZBFabuViewController.h"
#import "ZBloginViewController.h"
#import "ZBFreepwViewController.h"
#import "ZBFaBuBaseViewController.h"



@interface ZBBaseTabBarController ()<UITabBarControllerDelegate,UITabBarDelegate>

@property(nonatomic,weak)UITabBarController *tabVC;
@property(nonatomic,assign)NSInteger tabTag;

@end

@implementation ZBBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupController];
    }
    return self;
}

#pragma mark - 初始化子控制器
-(void)setupController{
//    UITabBarController *tabVC = [[UITabBarController alloc] init];
    self.delegate = self;
//    self.tabBar.delegate = self;
    _tabVC = self;
     [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:50/255.0 green:83/255.0 blue:250/255.0 alpha:1.0],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
     _tabVC.tabBar.backgroundColor = [UIColor whiteColor];
     
     ZBHomeViewController *home_vc = [[ZBHomeViewController alloc] init];
     UINavigationController *nav_home = [[UINavigationController alloc] initWithRootViewController:home_vc];
     nav_home.navigationBar.hidden = YES;
     nav_home.tabBarItem.title = @"首页";
     nav_home.tabBarItem.image = [UIImage imageNamed:@"shouye_unselected"];
     nav_home.tabBarItem.selectedImage = [UIImage imageNamed:@"shouye_selected"];
     [_tabVC addChildViewController:nav_home];
     
     

     
     ZBIndustryViewController *industry_vc = [[ZBIndustryViewController alloc] init];
     UINavigationController *nav_industry = [[UINavigationController alloc] initWithRootViewController:industry_vc];
     nav_industry.navigationBar.hidden = YES;
    nav_industry.tabBarItem.title = @"行情";
     nav_industry.tabBarItem.image = [UIImage imageNamed:@"hangqing_unselected"];
     nav_industry.tabBarItem.selectedImage = [UIImage imageNamed:@"hangqing_selected"];
     [_tabVC addChildViewController:nav_industry];
     
     ZBFaBuBaseViewController *fabu_vc = [[ZBFaBuBaseViewController alloc] init];
     UINavigationController *nav_fabu = [[UINavigationController alloc] initWithRootViewController:fabu_vc];
    nav_fabu.tabBarItem.title = @"发布";
    nav_fabu.tabBarItem.image = [UIImage imageNamed:@"fabu"];
     nav_fabu.tabBarItem.selectedImage = [UIImage imageNamed:@"fabu"];
     [_tabVC addChildViewController:nav_fabu];
     
     
     ZBInformationViewController *information_vc = [[ZBInformationViewController alloc] init];
     UINavigationController *nav_information = [[UINavigationController alloc] initWithRootViewController:information_vc];
     nav_information.navigationBar.hidden = YES;
     nav_information.tabBarItem.title = @"资讯";
     nav_information.tabBarItem.image = [UIImage imageNamed:@"zixun_unselected"];
     nav_information.tabBarItem.selectedImage = [UIImage imageNamed:@"zixun_selected"];
     [_tabVC addChildViewController:nav_information];
     
     ZBMineViewController *mine_vc = [[ZBMineViewController alloc] init];
     UINavigationController *nav_mine = [[UINavigationController alloc] initWithRootViewController:mine_vc];
     nav_mine.navigationBar.hidden = YES;
     nav_mine.tabBarItem.title = @"我的";
     nav_mine.tabBarItem.image = [UIImage imageNamed:@"wode_unselected"];
     nav_mine.tabBarItem.selectedImage = [UIImage imageNamed:@"wode_selected"];
     [_tabVC addChildViewController:nav_mine];
}

//static NSInteger tabTag = 0;

#pragma mark - 实现中间item点击直接push的需求
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([tabBarController.tabBar.selectedItem.title isEqualToString:@"发布"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"jumpFabu%ld",self.tabTag] object:nil];
        return NO;//为NO就不会切换tab
    }
    return YES;
}



- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    //这里为什么要通过item名字来判断第几个tab呢？
    //因为发现self.selectIndex不准确，索性手动来判断。
    //解释下为什么需要知道当前是第几个item？
    //因为SB创建的tabbarController没有navgation，所以无法直接push跳转。
    //present虽然能跳转，但是没了navgation，在present的页面万一push就又麻烦了。所以不能直接在tabbarController里面push；
    //另外，为了保证发送通知针对的是你当前所在的界面，而不是每次点击发送的通知和接收的通知都一样，所以，加上index后缀，使得通知一一对应。
    if ([item.title isEqualToString:@"首页"]) {
        self.tabTag = 0;
    }
    if ([item.title isEqualToString:@"行情"]) {
        self.tabTag = 1;
    }
    if ([item.title isEqualToString:@"资讯"]) {
        self.tabTag = 2;
    }
    if ([item.title isEqualToString:@"我的"]) {
        self.tabTag = 3;
    }
    if ([item.title isEqualToString:@"发布"]) {
        return;

    }
}
@end
