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
/** 日历实例*/
@property(nonatomic,strong)YXCalendarView *calendar;
/** 放置日历的View*/
@property (strong, nonatomic) IBOutlet UIView *calender_view;
/** 签到按钮*/
@property (strong, nonatomic) IBOutlet UIButton *SIgnInBtn;
/** 签到成功View*/
@property(nonatomic,weak)UIViewController *SignInSuccessVC;
/** 显示连续签到天数的label*/
@property (strong, nonatomic) IBOutlet UILabel *continueDay;
/** 签到记录*/
@property(nonatomic,strong)NSMutableArray *dataArray;
/** 顶部高度约束*/
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *Top_H;

@end

@implementation ZBSignInViewController

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //更新签到数据
    [self RefreshSignIn];
    
    //版本适配
    if (@available(iOS 13.0, *)) {
        //
    } else {
        _Top_H.constant = 74;
    }
    
    //初始化NavigationItem
    [self setupNavigationItem];
    
    //初始化日历
    [self steupCalendar];
}

#pragma mark - 初始化NavigationItem
-(void)setupNavigationItem{
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStyleDone target:self action:@selector(backMine)];
       self.navigationItem.leftBarButtonItem = leftItem;
       self.navigationItem.title = @"设置";
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - 初始化日历
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
//    NSLog(@"%@",[[YXDateHelpObject manager] getStrFromDateFormat:@"yyyy-MM-dd" Date:selDate]);
        };
    [self.calender_view addSubview:_calendar];
}

#pragma mark - 点击签到按钮
- (IBAction)cilckSignIn:(UIButton *)sender {
    
    sender.layer.cornerRadius = 20;
    sender.layer.borderColor = [UIColor colorWithRed:50/255.0 green:83/255.0 blue:250/255.0 alpha:1.0].CGColor;
    sender.layer.borderWidth = 1;
    sender.backgroundColor = [UIColor whiteColor];
    [self.SIgnInBtn setTitle:@"已签到" forState:UIControlStateNormal];
    sender.enabled = NO;
    
    [self ZBbeginSignIn];
    
}

#pragma mark - 退出当前页面
-(void)backMine{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    
    //判断今日是否签到
    [self CurIsSignIn];
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
                   
                   for (ZBSignInRecordModel *model in self.dataArray) {
                    if ([[self timetampTostring:model.time.integerValue] isEqualToString:[self curYearMD]]) {
                        self.continueDay.text = [NSString stringWithFormat:@"%@天",model.continueTimes];
                        }
                    }
                   
                   
               }else{
                  
               }
    } failure:nil];
     
    
}

#pragma mark - 今日是否签到
-(void)CurIsSignIn{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    [par setObject:appDelegate.mineUserInfoModel.userID forKey:@"userId"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://api.yysc.online/user/sign/hasSign" parameters:par headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = responseObject;
        NSString *success = [NSString stringWithFormat:@"%@",dict[@"success"]];
        NSString *data = [NSString stringWithFormat:@"%@",dict[@"data"]];

               if ([success isEqualToString:@"1"]) {
                   
                   if ([data isEqualToString:@"0"]) {
                    self.SIgnInBtn.layer.cornerRadius = 20;
                    [self.SIgnInBtn setTitle:@"立即签到" forState:UIControlStateNormal];
                    self.SIgnInBtn.backgroundColor = [UIColor colorWithRed:50/255.0 green:83/255.0 blue:250/255.0 alpha:1.0];
                    [self.SIgnInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    self.SIgnInBtn.enabled = YES;
                       
                   }else{
                       
                    self.SIgnInBtn.layer.cornerRadius = 20;
                    self.SIgnInBtn.layer.borderColor = [UIColor colorWithRed:50/255.0 green:83/255.0 blue:250/255.0 alpha:1.0].CGColor;
                    self.SIgnInBtn.layer.borderWidth = 1;
                    [self.SIgnInBtn setTitle:@"已签到" forState:UIControlStateNormal];
                    self.SIgnInBtn.enabled = NO;
                   }
                   
               }else{
                  //
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
                [self.calendar SingInSuccess];
                [self RefreshSignIn];
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
            [MBProgressHUD showError:@"网络错误"];
        }];
}

#pragma mark - 转化时间戳
-(NSString *)timetampTostring:(NSInteger)timestamp{
    
    NSString *tempTime =[[NSNumber numberWithLong:timestamp] stringValue];
    NSMutableString *getTime = [NSMutableString stringWithFormat:@"%@",tempTime];

      //    NSMutableString *getTime = @"1461896616000";
     struct utsname systemInfo;
     uname(&systemInfo);

     [getTime deleteCharactersInRange:NSMakeRange(10,3)];
     NSDateFormatter *matter = [[NSDateFormatter alloc]init];
//    matter.dateFormat =@"YYYY-MM-dd HH:mm";
    matter.dateFormat =@"yyyy-MM-dd";
//     matter.dateFormat =@"MM-dd";
    //解决时区问题
    matter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[getTime intValue]];

      NSString *timeStr = [matter stringFromDate:date];
//    NSArray *array1 =[timeStr componentsSeparatedByString:@"-"];

    return timeStr;
}

#pragma mark - 获取当前时间的字符串
-(NSString *)curYearMD{
    
    //获取当前时间日期
          NSDate *date=[NSDate date];
          NSDateFormatter *format1=[[NSDateFormatter alloc] init];
          [format1 setDateFormat:@"yyyy-MM-dd"];
          NSString *dateStr;
          dateStr=[format1 stringFromDate:date];
          return dateStr;
}



@end
