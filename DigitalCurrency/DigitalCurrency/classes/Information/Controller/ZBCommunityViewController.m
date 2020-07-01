//
//  ZBCommunityViewController.m
//  DigitalCurrency
//
//  Created by HFY on 2020/6/30.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBCommunityViewController.h"
#import "ZBCommunityTuiJianViewController.h"

@interface ZBCommunityViewController ()

@property(nonatomic,weak)UIView *tuijian_view;

@end

@implementation ZBCommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        self.view.backgroundColor = [UIColor orangeColor];
    
    ZBCommunityTuiJianViewController *tuijian_vc = [[ZBCommunityTuiJianViewController alloc] init];
    [self addChildViewController:tuijian_vc];
    [self.view addSubview:tuijian_vc.view];
    tuijian_vc.view.frame = CGRectMake(0, zbStatuBarH , zbStatuBarW, ZBScreenH - zbStatuBarH - 44 - 49);
    _tuijian_view = tuijian_vc.view;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
