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

@interface ZBSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIImageView *top_view;
@property (strong, nonatomic) IBOutlet UIImageView *btm_view;


@end

@implementation ZBSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    _top_view.image = [UIImage imageNamed:@"bg_set1"];
    _btm_view.image = [UIImage imageNamed:@"bg_set2"];
    
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStyleDone target:self action:@selector(backMine)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.title = @"设置";
    
    
}

-(void)backMine{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)BianJiZiLiao:(id)sender {
}
- (IBAction)XiuGaiZiLiaoClick:(id)sender {
}
- (IBAction)QieHuanZhangHaoClick:(id)sender {
}

- (IBAction)ZhuXiaoZhangHaoClick:(id)sender {
    ZBZhuXiaoViewController *vc = [[ZBZhuXiaoViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)guanyuwomClick:(id)sender {
    
    ZBGuanYuWMViewController *vc = [ZBGuanYuWMViewController new];
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)fankuizxClick:(id)sender {
    
    ZBFanKuiZXViewController *vc = [ZBFanKuiZXViewController new];
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)yonghuxieyiClick:(id)sender {
}
- (IBAction)YingSiZhengCeClick:(id)sender {
}

@end
