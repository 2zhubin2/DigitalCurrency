//
//  ZBSignInViewController.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/3.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBSignInViewController.h"
#import "YXCalendarView.h"
#import "ZBSignInSuccessView.h"

@interface ZBSignInViewController ()

@property(nonatomic,strong)YXCalendarView *calendar;
@property (strong, nonatomic) IBOutlet UIView *calender_view;
@property (strong, nonatomic) IBOutlet UIButton *SIgnInBtn;
@property(nonatomic,weak)UIViewController *SignInSuccessVC;

@end

@implementation ZBSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStyleDone target:self action:@selector(backMine)];
       self.navigationItem.leftBarButtonItem = leftItem;
       self.navigationItem.title = @"设置";
    self.navigationController.navigationBar.hidden = NO;
    
    _SIgnInBtn.layer.cornerRadius = 20;
    _SIgnInBtn.backgroundColor = [UIColor colorWithRed:50/255.0 green:83/255.0 blue:250/255.0 alpha:1.0];
    
    
   
    
    _calendar = [[YXCalendarView alloc] initWithFrame:CGRectMake(0, 0, ZBScreenW - 60, [YXCalendarView getMonthTotalHeight:[NSDate date] type:CalendarType_Month]) Date:[NSDate date] Type:CalendarType_Month];
    
    __weak typeof(_calendar) weakCalendar = _calendar;
    _calendar.refreshH = ^(CGFloat viewH) {
        [UIView animateWithDuration:0.3 animations:^{
//            weakCalendar.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, viewH);
        }];
        
    };
    _calendar.sendSelectDate = ^(NSDate *selDate) {
        NSLog(@"%@",[[YXDateHelpObject manager] getStrFromDateFormat:@"yyyy-MM-dd" Date:selDate]);
    };
    [self.calender_view addSubview:_calendar];
    
    
    
}
- (IBAction)cilckSignIn:(UIButton *)sender {
    
    sender.selected = YES;
    sender.layer.cornerRadius = 20;
    sender.layer.borderColor = [UIColor colorWithRed:50/255.0 green:83/255.0 blue:250/255.0 alpha:1.0].CGColor;
    sender.layer.borderWidth = 1;
    sender.backgroundColor = [UIColor whiteColor];
    
    
//    UIViewController *vc = self.childViewControllers[0];
    ZBSignInSuccessView *view = [[ZBSignInSuccessView alloc] init];
    
    [self.navigationController.view addSubview:view];
      [view mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.equalTo(self.view);
          make.left.equalTo(self.view);
          make.bottom.equalTo(self.view);
          make.right.equalTo(self.view);
      }];

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        [self.SignInSuccessVC.view removeFromSuperview];
//    });

}


-(void)backMine{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
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
