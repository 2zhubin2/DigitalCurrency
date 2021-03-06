//
//  ZBFreepwViewController.m
//  DigitalCurrency
//
//  Created by HFY on 2020/6/29.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBFreepwViewController.h"
#import "ZBimageCodeView.h"
#import "ZBMineUserInfoModel.h"
#import "ZBRegisterViewController.h"
#import "ZBloginViewController.h"

@interface ZBFreepwViewController ()
@property (strong, nonatomic) IBOutlet UITextField *phone_F;
@property (strong, nonatomic) IBOutlet UITextField *code_F;

@end

@implementation ZBFreepwViewController

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
   
    //初始化NavigationItem
    [self setupNavigationItem];
    
}

#pragma mark - 初始化NavigationItem
-(void)setupNavigationItem{
    
   UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStyleDone target:self action:@selector(backSetting)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

#pragma mark - 点击导航条左侧item
-(void)backSetting{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 点击密码登陆
- (IBAction)passWordLogin:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 点击注册
- (IBAction)ClickRegister:(UIButton *)sender {
    
    ZBRegisterViewController *vc = [ZBRegisterViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 点击登陆
- (IBAction)clickLogin:(id)sender {
    [self beginLogin];
}

#pragma mark - 点击验证码
- (IBAction)ClickGetCode:(id)sender {
    
//    ZBimageCodeViewController *vc = [[ZBimageCodeViewController alloc] init];
//    [self presentViewController:vc animated:YES completion:nil];
    ZBimageCodeView *view = [[ZBimageCodeView alloc] init];
    view.phone = self.phone_F.text;
    view.type = @"2";

    
    [self.navigationController.view addSubview:view];
    view.frame = self.view.frame;
}

#pragma mark - 开始登陆
-(void)beginLogin{
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    [par setObject:self.phone_F.text forKey:@"phone"];
    [par setObject:@"" forKey:@"password"];
    [par setObject:@"2" forKey:@"type"];
    [par setObject:@"futures" forKey:@"project"];
    [par setObject:self.code_F.text forKey:@"code"];

   
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
                        
                           //存入用户数据
                            NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user.plist"];
                            NSDictionary *tempDic = [mineuserInfoModel mj_keyValues];
                            [tempDic writeToFile:path atomically:YES];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:self];
                           
                           [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count-3] animated:YES];
                           
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
    [_phone_F endEditing:YES];
    [_code_F endEditing:YES];
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
