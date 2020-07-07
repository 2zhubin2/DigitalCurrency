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
#import "ZBSignInRecordModel.h"

@interface ZBSignInViewController ()

@property(nonatomic,strong)YXCalendarView *calendar;
@property (strong, nonatomic) IBOutlet UIView *calender_view;
@property (strong, nonatomic) IBOutlet UIButton *SIgnInBtn;
@property(nonatomic,weak)UIViewController *SignInSuccessVC;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation ZBSignInViewController

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStyleDone target:self action:@selector(backMine)];
       self.navigationItem.leftBarButtonItem = leftItem;
       self.navigationItem.title = @"设置";
    self.navigationController.navigationBar.hidden = NO;
    
    _SIgnInBtn.layer.cornerRadius = 20;
    _SIgnInBtn.backgroundColor = [UIColor colorWithRed:50/255.0 green:83/255.0 blue:250/255.0 alpha:1.0];
    
    
    [self steupCalendar];
    
  
    
    
    
}

-(void)steupCalendar{
    
    [self.calender_view.subviews.lastObject removeFromSuperview];
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
    
    [self ZBbeginSignIn];
    
//    UIViewController *vc = self.childViewControllers[0];
   

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

#pragma mark - 用户签到记录（仅当月）
-(void)RefreshSignIn{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    [par setObject:appDelegate.mineUserInfoModel.userID forKey:@"userId"];
    

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://api.yysc.online/user/sign/getSignList" parameters:par headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = responseObject;
        NSString *success = [NSString stringWithFormat:@"%@",dict[@"success"]];
        NSDictionary *data = dict[@"data"];

               if ([success isEqualToString:@"1"]) {
                   
                   self.dataArray = [ZBSignInRecordModel mj_objectArrayWithKeyValuesArray:data];
//                   self.dataArray = temp;
                   
               }else{
                  
               }
    } failure:nil];
     
    
}
#pragma mark - 开始签到
-(void)ZBbeginSignIn{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    [par setObject:appDelegate.mineUserInfoModel.userID forKey:@"userId"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://api.yysc.online/user/sign/signNow" parameters:par headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
        NSDictionary *data = responseObject;
        NSString *success = [NSString stringWithFormat:@"%@",data[@"success"]];
        if ([success isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:@"签到成功..."];
            
            //延时执行代码
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
            ZBSignInSuccessView *view = [[ZBSignInSuccessView alloc] init];
                [self steupCalendar];
            [self.navigationController.view addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                     make.top.equalTo(self.view);
                     make.left.equalTo(self.view);
                     make.bottom.equalTo(self.view);
                     make.right.equalTo(self.view);
            }];
        });
                
        }else{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"签到失败"];
        }
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"failure");
        }];
        
    
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
