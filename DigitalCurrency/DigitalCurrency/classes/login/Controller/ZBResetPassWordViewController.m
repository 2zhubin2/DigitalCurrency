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


@end

@implementation ZBResetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStyleDone target:self action:@selector(backSetting)];
                self.navigationItem.leftBarButtonItem = leftItem;
//                self.navigationItem.title = @"编辑资料";
}

-(void)backSetting{
    [self.navigationController popViewControllerAnimated:YES];
}

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
- (IBAction)clickReset:(id)sender {
    
    [self beginReSetPassword];
}


-(void)beginReSetPassword{
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    [par setObject:self.phoneLabel.text forKey:@"phone"];
    [par setObject:@"futures" forKey:@"project"];
    [par setObject:self.code_F.text forKey:@"code"];
    [par setObject:self.PassWord_F.text forKey:@"newPassword"];
    [par setObject:self.confirmPassword_F.text forKey:@"confirmPassword"];

//    NSLog(@"%@",par);
    
    
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_phoneLabel endEditing:YES];
    [_code_F endEditing:YES];
    [_PassWord_F endEditing:YES];
    [_confirmPassword_F endEditing:YES];
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
