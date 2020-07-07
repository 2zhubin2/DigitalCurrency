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

@end

@implementation ZBZhuXiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStyleDone target:self action:@selector(backSetting)];
       self.navigationItem.leftBarButtonItem = leftItem;
       self.navigationItem.title = @"注销";
    
    _view_one.layer.cornerRadius = 3;
    _view_two.layer.cornerRadius = 3;
    _view_three.layer.cornerRadius = 3;
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"backMe" object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backMe_go) name:@"backMe" object:nil];
//    ZBZhuXiaoTangChuangViewController *vc = [[ZBZhuXiaoTangChuangViewController alloc] init];
//    [self addChildViewController:vc];
}

-(void)backMe_go{
    
    [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count-3] animated:YES];
}

-(void)backSetting{
    [self.navigationController popViewControllerAnimated:YES];
}
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
//
//    [self presentViewController:vc animated:YES completion:nil];
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
