//
//  ZBSearchViewController.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/2.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBSearchViewController.h"
#import "ZBSearchOneViewController.h"
#import "ZBSearchTwoViewController.h"

@interface ZBSearchViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *image_view;
@property (strong, nonatomic) IBOutlet UIView *bg_view;
@property (strong, nonatomic) IBOutlet UITextField *search_F;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *View_topH;

@end

@implementation ZBSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _image_view.image = [UIImage imageNamed:@"bg_search2"];
    [self addChildVC];
    _search_F.text = @"";
    if (@available(iOS 13.0, *)) {
        
        //
        
    } else {
        _View_topH.constant = 20;
    }
}
- (IBAction)clickQueXiao:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)clickSearchBtn:(id)sender {
    
    if (self.search_F.text.length == 0) {
        self.SearchStatu = NO;
        [self loadViewOneOrTwo];
    }else{
        [self.view endEditing:YES];
        self.SearchStatu = YES;
        [self loadViewOneOrTwo];
    }
    

}
- (IBAction)SouSuo_F:(UITextField *)sender {
    [sender resignFirstResponder];
}

- (IBAction)Edit_end:(id)sender {
    [sender resignFirstResponder];
}

-(void)addChildVC{
    
    NSArray *childClassName = @[@"ZBSearchOneViewController",
                                @"ZBSearchTwoViewController"];
    for (NSString *className in childClassName) {
        UIViewController *vc = [[NSClassFromString(className) alloc] init];
        [self addChildViewController:vc];
    }
    
    UIViewController  *vc = self.childViewControllers[0];
//    vc.view.frame = CGRectMake(0, zbStatuBarH + 44,zbStatuBarW , ZBScreenH - zbStatuBarH - 44 );
    [self.bg_view addSubview:vc.view];
    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bg_view);
        make.left.equalTo(self.bg_view);
        make.bottom.equalTo(self.bg_view);
        make.right.equalTo(self.bg_view);
    }];


    
    
    
}

-(void)loadViewOneOrTwo{
//    [self determineWhetherToLogin];
    if (self.SearchStatu == YES) {
//           UIViewController *preVC = self.childViewControllers[0];
//           [preVC.view removeFromSuperview];
        [_bg_view.subviews.lastObject removeFromSuperview];
           UIViewController *curVC = self.childViewControllers[1];
        [self.bg_view addSubview:curVC.view];
        [curVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
               make.top.equalTo(self.bg_view);
               make.left.equalTo(self.bg_view);
               make.bottom.equalTo(self.bg_view);
               make.right.equalTo(self.bg_view);
           }];
        
       }else{
//           UIViewController *preVC = self.childViewControllers[1];
//           [preVC.view removeFromSuperview];
            [_bg_view.subviews.lastObject removeFromSuperview];
           UIViewController *curVC = self.childViewControllers[0];
           [self.bg_view addSubview:curVC.view];
           [curVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
               make.top.equalTo(self.bg_view);
               make.left.equalTo(self.bg_view);
               make.bottom.equalTo(self.bg_view);
               make.right.equalTo(self.bg_view);
           }];
           
       }
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
