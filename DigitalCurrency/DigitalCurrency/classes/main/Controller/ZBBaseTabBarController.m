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
    
    self.delegate = self;
    _tabVC = self;
     [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:50/255.0 green:83/255.0 blue:250/255.0 alpha:1.0],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
     _tabVC.tabBar.backgroundColor = [UIColor whiteColor];
     
     ZBHomeViewController *home_vc = [[ZBHomeViewController alloc] init];
    [self setUpOneChildViewController:home_vc image:[UIImage imageNamed:@"shouye_unselected"] sellectImage:[UIImage imageNamed:@"shouye_selected"] title:@"首页"];
     
     ZBIndustryViewController *industry_vc = [[ZBIndustryViewController alloc] init];
    [self setUpOneChildViewController:industry_vc image:[UIImage imageNamed:@"hangqing_unselected"] sellectImage:[UIImage imageNamed:@"hangqing_selected"] title: @"行情"];
     
     ZBFaBuBaseViewController *fabu_vc = [[ZBFaBuBaseViewController alloc] init];
    [self setUpOneChildViewController:fabu_vc image:[UIImage imageNamed:@"fabu"] sellectImage:[UIImage imageNamed:@"fabu"] title: @"发布"];
     
     ZBInformationViewController *information_vc = [[ZBInformationViewController alloc] init];
    [self setUpOneChildViewController:information_vc image:[UIImage imageNamed:@"zixun_unselected"] sellectImage:[UIImage imageNamed:@"zixun_selected"] title: @"资讯"];
     
     ZBMineViewController *mine_vc = [[ZBMineViewController alloc] init];
    [self setUpOneChildViewController:mine_vc image:[UIImage imageNamed:@"wode_unselected"] sellectImage:[UIImage imageNamed:@"wode_selected"] title:@"我的"];
    
    
}



#pragma mark - 添加一个子控制器的方法
- (void)setUpOneChildViewController:(UIViewController *)viewController image:(UIImage *)image sellectImage:(UIImage *)image_s title:(NSString *)title{

    UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:viewController];
    navC.navigationBar.hidden = YES;
    navC.tabBarItem.title = title;
    navC.tabBarItem.image = image;
    navC.tabBarItem.selectedImage = image_s;

    [_tabVC addChildViewController:navC];
}



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
