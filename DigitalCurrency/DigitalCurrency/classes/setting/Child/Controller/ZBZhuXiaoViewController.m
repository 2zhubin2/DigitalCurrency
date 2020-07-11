//
//  ZBZhuXiaoViewController.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/2.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBZhuXiaoViewController.h"
#import "ZBZhuXiaoTangChuangView.h"
#import "ZBMineViewController.h"

@interface ZBZhuXiaoViewController ()
@property (strong, nonatomic) IBOutlet UIView *view_one;
@property (strong, nonatomic) IBOutlet UIView *view_two;
@property (strong, nonatomic) IBOutlet UIView *view_three;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *Top_H;

@end

@implementation ZBZhuXiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //屏幕适配
    if (@available(iOS 13.0, *)) {
        //
    } else {
        _Top_H.constant = 54;
    }
    
    //初始化NavigationItem
    [self setupNavigationItem];
    
    //设置切角
    _view_one.layer.cornerRadius = 3;
    _view_two.layer.cornerRadius = 3;
    _view_three.layer.cornerRadius = 3;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backMe_go) name:@"backMe" object:nil];

}

#pragma mark - 初始化NavigationItem
-(void)setupNavigationItem{
    
     UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStyleDone target:self action:@selector(backSetting)];
          self.navigationItem.leftBarButtonItem = leftItem;
          self.navigationItem.title = @"注销";
}



-(void)backMe_go{
    
    [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count-3] animated:YES];
}

-(void)backSetting{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 点击申请注销
- (IBAction)shengqingClick:(id)sender {
//    UIViewController *vc = self.childViewControllers[0];
//    ZBZhuXiaoTangChuangViewController *vc = [[ZBZhuXiaoTangChuangViewController alloc] init];
    ZBZhuXiaoTangChuangView *view = [[ZBZhuXiaoTangChuangView alloc] init];
    
    [self.navigationController.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.right.equalTo(self.view);
    }];

}



@end
