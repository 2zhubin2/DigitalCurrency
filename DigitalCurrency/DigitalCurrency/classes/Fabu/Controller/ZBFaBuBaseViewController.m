//
//  ZBFaBuBaseViewController.m
//  DigitalCurrency
//
//  Created by HFY on 2020/7/2.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBFaBuBaseViewController.h"
#import "ZBFabuViewController.h"

@interface ZBFaBuBaseViewController ()

@end

@implementation ZBFaBuBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)viewWillAppear:(BOOL)animated{
        self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    ZBFabuViewController *vc = [[ZBFabuViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)cilckTuPian:(id)sender {
    ZBFabuViewController *vc = [[ZBFabuViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)cilckWenZhang:(id)sender {
    ZBFabuViewController *vc = [[ZBFabuViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
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
