//
//  ZBZhuXiaoTangChuangViewController.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/2.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBZhuXiaoTangChuangViewController.h"

@interface ZBZhuXiaoTangChuangViewController ()
@property (strong, nonatomic) IBOutlet UIView *bg_view;

@end

@implementation ZBZhuXiaoTangChuangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _bg_view.layer.cornerRadius = 10;
}
- (IBAction)quxiaoClick:(id)sender {
    [self.view removeFromSuperview];
}
- (IBAction)querenClick:(id)sender {
    [self.view removeFromSuperview];
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
