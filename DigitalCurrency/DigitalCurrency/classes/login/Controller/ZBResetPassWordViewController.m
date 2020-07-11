//
//  ZBResetPassWordViewController.m
//  DigitalCurrency
//
//  Created by HFY on 2020/6/29.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBResetPassWordViewController.h"
#import "ZBimageCodeView.h"

@interface ZBResetPassWordViewController ()
@property (strong, nonatomic) IBOutlet UITextField *phoneLabel;
@property (strong, nonatomic) IBOutlet UITextField *code_F;
@property (strong, nonatomic) IBOutlet UITextField *PassWord_F;
@property (strong, nonatomic) IBOutlet UITextField *confirmPassword_F;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *Top_H;


@end

@implementation ZBResetPassWordViewController

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //版本适配
    if (@available(iOS 13.0, *)) {
        //
    } else {
        _Top_H.constant = 64;
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
- (IBAction)touchCodeClick:(id)sender {
    if (_phoneLabel.text.length != 0) {
        ZBimageCodeView *view = [ZBimageCodeView new];
         view.phone = self.phoneLabel.text;
         view.type = @"3";

         [self.navigationController.view addSubview:view];
         view.frame = self.view.bounds;
    }else{
        [MBProgressHUD showError:@"请输入手机号"];
    }
}

#pragma mark - 点击重置密码
- (IBAction)clickReset:(id)sender {
    
    [self beginReSetPassword];
}

#pragma mark - 开始重置密码
-(void)beginReSetPassword{
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    [par setObject:self.phoneLabel.text forKey:@"phone"];
    [par setObject:@"futures" forKey:@"project"];
    [par setObject:self.code_F.text forKey:@"code"];
    [par setObject:self.PassWord_F.text forKey:@"newPassword"];
    [par setObject:self.confirmPassword_F.text forKey:@"confirmPassword"];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://api.yysc.online/system/resetPassword" parameters:par headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *data = responseObject;
        NSString *success = [NSString stringWithFormat:@"%@",data[@"success"]];
        NSLog(@"%@",data);
        if ([success isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:@"重置成功..."];
            //延时执行代码
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
                });
        }else{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"重置失败"];
            }

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"重置失败"];
        }];
}

#pragma mark - touchesBegan
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_phoneLabel endEditing:YES];
    [_code_F endEditing:YES];
    [_PassWord_F endEditing:YES];
    [_confirmPassword_F endEditing:YES];
}


@end
