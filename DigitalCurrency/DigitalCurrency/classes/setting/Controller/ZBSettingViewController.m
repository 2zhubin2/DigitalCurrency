//
//  ZBSettingViewController.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/2.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBSettingViewController.h"
#import "ZBZhuXiaoViewController.h"
#import "ZBGuanYuWMViewController.h"
#import "ZBFanKuiZXViewController.h"
#import "ZBQieHuanZhangHaoViewController.h"
#import "ZBBianJiZiLiaoViewController.h"
#import "ZBResetPassWordViewController.h"

@interface ZBSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIImageView *top_view;
@property (strong, nonatomic) IBOutlet UIImageView *btm_view;


@end

@implementation ZBSettingViewController

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _top_view.image = [UIImage imageNamed:@"bg_set1"];
    _btm_view.image = [UIImage imageNamed:@"bg_set2"];
    
    //初始化NavigationItem
    [self setupNavigationItem];
    
    
}

#pragma mark - 初始化NavigationItem
-(void)setupNavigationItem{
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStyleDone target:self action:@selector(backMine)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.title = @"设置";
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

-(void)backMine{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 编辑资料
- (IBAction)BianJiZiLiao:(id)sender {
    
    ZBBianJiZiLiaoViewController *vc = [ZBBianJiZiLiaoViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 修改资料
- (IBAction)XiuGaiZiLiaoClick:(id)sender {
    
    ZBResetPassWordViewController *vc = [ZBResetPassWordViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 切换账号
- (IBAction)QieHuanZhangHaoClick:(id)sender {
    
    ZBQieHuanZhangHaoViewController *vc= [[ZBQieHuanZhangHaoViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 注销账号
- (IBAction)ZhuXiaoZhangHaoClick:(id)sender {
    ZBZhuXiaoViewController *vc = [[ZBZhuXiaoViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 关于我们
- (IBAction)guanyuwomClick:(id)sender {
    
    ZBGuanYuWMViewController *vc = [ZBGuanYuWMViewController new];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 反馈中心
- (IBAction)fankuizxClick:(id)sender {
    /*
    ZBFanKuiZXViewController *vc = [ZBFanKuiZXViewController new];
    [self.navigationController pushViewController:vc animated:YES];*/
     [MBProgressHUD showError:@"未开放此功能"];
}
- (IBAction)yonghuxieyiClick:(id)sender {
    
    [MBProgressHUD showError:@"未开放此功能"];
}
- (IBAction)YingSiZhengCeClick:(id)sender {
    [MBProgressHUD showError:@"未开放此功能"];
}

- (IBAction)tuichuLogin:(UIButton *)sender {
    //tuichuLogin
    
    //清空用户数据
       NSError *error;
       NSFileManager *fileMger = [NSFileManager defaultManager];
       NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user.plist"];
       if ([fileMger removeItemAtPath:path error:&error]) {
           [[NSNotificationCenter defaultCenter] postNotificationName:@"tuichuLogin" object:self];
       }else{
           [[NSNotificationCenter defaultCenter] postNotificationName:@"tuichuLogin" object:self];
       }
    NSString *path_temp = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user_temp.plist"];
    if ([fileMger removeItemAtPath:path_temp error:&error]) {
        //
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
