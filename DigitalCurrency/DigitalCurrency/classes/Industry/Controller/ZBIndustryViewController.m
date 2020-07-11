//
//  ZBIndustryViewController.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/6/29.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBIndustryViewController.h"
#import "CZ_NEWMarketVC.h"
#import "ZBFabuViewController.h"


@interface ZBIndustryViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *search_bg;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *shouye_TopH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageV_TopH;

@end

@implementation ZBIndustryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor = [UIColor orangeColor];
    
    if (@available(iOS 13.0, *)) {
        
        //
        
    } else {
        _shouye_TopH.constant = 30;
        _imageV_TopH.constant = 20;
    }
    
    _search_bg.image =  [UIImage imageNamed:@"bg_search1"];
    CZ_NEWMarketVC *industry_vc_child = [[CZ_NEWMarketVC alloc] init];
    [self addChildViewController:industry_vc_child];
    [self.view addSubview:industry_vc_child.view];
    industry_vc_child.view.frame = self.view.bounds;
    
    [self notificationCenterConfig];
}

#pragma mark - 通知相关
- (void)notificationCenterConfig{
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(justPush:) name:kNotificationMessagePush object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(justPush:) name:@"jumpFabu1"object:nil];
}

- (void)justPush:(NSNotification *) notification {
    //处理消息
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
      
      if (appDelegate.login == YES) {
          ZBFabuViewController *vc = [[ZBFabuViewController alloc] init];
          
          [self.navigationController pushViewController:vc animated:YES];
      }else{
          ZBloginViewController *vc = [[ZBloginViewController alloc] init];
          
          [self.navigationController pushViewController:vc animated:YES];
      }
    
    
}
- (void)dealloc {
    //单条移除观察者
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:[NSString stringWithFormat:@"%@2",kNotificationMessagePush] object:nil];
    //移除所有观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
