//
//  ZBloginViewController.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/6/29.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBloginViewController.h"
#import "ZBRegisterViewController.h"
#import "ZBFreepwViewController.h"
#import "ZBResetPassWordViewController.h"
#import "ZBMineUserInfoModel.h"

@interface ZBloginViewController ()
@property (strong, nonatomic) IBOutlet UIView *loginView;
@property (strong, nonatomic) IBOutlet UITextField *name_F;
@property (strong, nonatomic) IBOutlet UITextField *password_F;

@end

@implementation ZBloginViewController

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
  
    //初始化NavigationItem
    [self setupNavigationItem];
    
    //初始化loginView
    [self setupLoginView];
    
}

#pragma mark - 初始化NavigationItem
-(void)setupNavigationItem{
    
  UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStyleDone target:self action:@selector(backMine)];
   self.navigationItem.leftBarButtonItem = leftItem;
}

#pragma mark - 初始化loginView
-(void)setupLoginView{

    _loginView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0].CGColor;
    _loginView.layer.shadowOffset = CGSizeMake(2, 2);
    _loginView.layer.shadowOpacity = 1;
    _loginView.layer.shadowRadius = 5;
    _loginView.layer.cornerRadius = 10;
}

#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
    
}

#pragma mark - 点击导航条左侧item
-(void)backMine{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 点击忘记密码
- (IBAction)clickWJMM:(id)sender {
    ZBResetPassWordViewController *vc = [ZBResetPassWordViewController new];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 点击免密登陆
- (IBAction)clickMMDL:(id)sender {
    ZBFreepwViewController *vc = [ZBFreepwViewController new];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 点击注册
- (IBAction)cliickGoRegister:(id)sender {
    ZBRegisterViewController *vc = [ZBRegisterViewController new];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 点击登陆
- (IBAction)clickBeginLogin:(id)sender {
    
    [self beginLogin];
    
}

#pragma mark - 点击显示密码
- (IBAction)clickShow:(UIButton *)sender {
    _password_F.secureTextEntry = !_password_F.isSecureTextEntry;
}


#pragma mark - 开始登陆
-(void)beginLogin{
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    [par setObject:self.name_F.text forKey:@"phone"];
    [par setObject:self.password_F.text forKey:@"password"];
    [par setObject:@"1" forKey:@"type"];
    [par setObject:@"futures" forKey:@"project"];
    [par setObject:@"000000" forKey:@"code"];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://api.yysc.online/system/login" parameters:par headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSDictionary *data = responseObject;
               NSString *success = [NSString stringWithFormat:@"%@",data[@"success"]];
        NSDictionary *dict = data[@"data"];
               if ([success isEqualToString:@"1"]) {
                   [MBProgressHUD showMessage:@"登录成功..."];
                   ZBMineUserInfoModel *mineuserInfoModel = [ZBMineUserInfoModel mj_objectWithKeyValues:dict];
                       //延时执行代码
                       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                           [MBProgressHUD hideHUD];
                                   NSLog(@"responseObjrect===%@",responseObject);
                           //存入用户数据
                           NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user.plist"];
                           NSDictionary *tempDic = [mineuserInfoModel mj_keyValues];
                           [tempDic writeToFile:path atomically:YES];
                           [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:self];
                           [self.navigationController popViewControllerAnimated:YES];
                       });
 
               }else{
                   [MBProgressHUD hideHUD];
                   [MBProgressHUD showError:@"登录未成功"];
               }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"登录失败"];
    }];
}

#pragma mark - touchesBegan
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_name_F endEditing:YES];
    [_password_F endEditing:YES];
}


@end
