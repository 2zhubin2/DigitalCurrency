//
//  ZBIndustryViewController.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/6/29.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBIndustryViewController.h"
#import "CZ_NEWMarketVC.h"

@interface ZBIndustryViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *search_bg;

@end

@implementation ZBIndustryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor = [UIColor orangeColor];
    
    _search_bg.image =  [UIImage imageNamed:@"bg_search1"];
    CZ_NEWMarketVC *industry_vc_child = [[CZ_NEWMarketVC alloc] init];
    [self addChildViewController:industry_vc_child];
    [self.view addSubview:industry_vc_child.view];
    industry_vc_child.view.frame = self.view.bounds;
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
