//
//  ZBRegisterViewController.m
//  DigitalCurrency
//
//  Created by HFY on 2020/6/29.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBRegisterViewController.h"
#import "ZBimageCodeView.h"

@interface ZBRegisterViewController ()

@property (strong, nonatomic) IBOutlet UITextField *name_label;
@property (strong, nonatomic) IBOutlet UITextField *code_label;
@property (strong, nonatomic) IBOutlet UITextField *password_label;
@property (strong, nonatomic) IBOutlet UITextField *confirmPassword;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *Top_H;

@end

@implementation ZBRegisterViewController

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //版本适配
    if (@available(iOS 13.0, *)) {

    } else {
        _Top_H.constant = 59;
    }
    
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

#pragma mark - 点击获取验证码
- (IBAction)touchCode:(id)sender {
    
    if (_name_label.text.length != 0) {
     ZBimageCodeView *view = [ZBimageCodeView new];
     view.phone = self.name_label.text;
     view.type = @"1";
     [self.navigationController.view addSubview:view];
     view.frame = self.view.bounds;
    }else{
            [MBProgressHUD showError:@"请输入账号（手机号）..."];
       }

}

#pragma mark - 点击注册
- (IBAction)cilckBeginRegister:(id)sender {
    
    //提醒框
    [MBProgressHUD showMessage:@"正在努力帮你注册..."];
     
     if (_name_label.text.length != 0 && _password_label.text.length != 0 && _code_label.text.length != 0 && _confirmPassword.text.length != 0) {
         
         [MBProgressHUD hideHUD];
         //延时执行代码
               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   [self beginRegist];
               });
     }else{
          [MBProgressHUD hideHUD];
          [MBProgressHUD showError:@"输入未完成..."];
     }
}

#pragma mark - 开始注册
-(void)beginRegist{
    //获取参数
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    [par setObject:self.name_label.text forKey:@"phone"];
    [par setObject:self.password_label.text forKey:@"password"];
    [par setObject:self.confirmPassword.text forKey:@"confirmPassword"];
    [par setObject:self.code_label.text forKey:@"code"];
    [par setObject:@"1" forKey:@"type"];
    [par setObject:@"futures" forKey:@"project"];
    

    //发送网络请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://api.yysc.online/system/register" parameters:par headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *data = responseObject;
        NSString *success = [NSString stringWithFormat:@"%@",data[@"success"]];
        if ([success isEqualToString:@"1"]) {
            
            [MBProgressHUD showMessage:@"注册成功"];
            //延时执行代码
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
               [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"注册失败"];
            }

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"注册失败"];
        }];
}

#pragma mark - touchesBegan
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_name_label endEditing:YES];
    [_code_label endEditing:YES];
    [_password_label endEditing:YES];
    [_confirmPassword endEditing:YES];
}

@end
