//
//  ZBAddCountViewController.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/9.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBAddCountViewController.h"
#import "ZBRegisterViewController.h"

@interface ZBAddCountViewController ()
@property (strong, nonatomic) IBOutlet UIView *loginView;
@property (strong, nonatomic) IBOutlet UITextField *name_F;
@property (strong, nonatomic) IBOutlet UITextField *password_F;

@end

@implementation ZBAddCountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStyleDone target:self action:@selector(backMine)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    _loginView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0].CGColor;
       _loginView.layer.shadowOffset = CGSizeMake(2, 2);
       _loginView.layer.shadowOpacity = 1;
       _loginView.layer.shadowRadius = 5;
       _loginView.layer.cornerRadius = 10;
    
}

-(void)backMine{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)clickLogin:(UIButton *)sender {
    [self beginLogin];
}

- (IBAction)clickRegester:(UIButton *)sender {
    ZBRegisterViewController *vc = [[ZBRegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)clickShow:(UIButton *)sender {
    _password_F.secureTextEntry = !_password_F.isSecureTextEntry;
}


-(void)beginLogin{
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    [par setObject:self.name_F.text forKey:@"phone"];
    [par setObject:self.password_F.text forKey:@"password"];
    [par setObject:@"1" forKey:@"type"];
    [par setObject:@"futures" forKey:@"project"];
    [par setObject:@"000000" forKey:@"code"];

   

//    NSLog(@"%@",par);

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://api.yysc.online/system/login" parameters:par headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSDictionary *data = responseObject;
               NSString *success = [NSString stringWithFormat:@"%@",data[@"success"]];
        NSDictionary *dict = data[@"data"];
//               NSLog(@"data===%@",data);
//        NSLog(@"dict===%@",dict);
               if ([success isEqualToString:@"1"]) {
                   [MBProgressHUD showMessage:@"添加账号成功..."];

               
                   ZBMineUserInfoModel *tempModel = [ZBMineUserInfoModel mj_objectWithKeyValues:dict];
                       //延时执行代码
                       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                           [MBProgressHUD hideHUD];
                           if ([self.delegate respondsToSelector:@selector(AddCountViewControllerAddSuccess:)]) {
                            [self.delegate AddCountViewControllerAddSuccess:tempModel];
                        }
                           [self.navigationController popViewControllerAnimated:YES];
                       });
                    
                                            
                    
               }else{
                   [MBProgressHUD hideHUD];
                   [MBProgressHUD showError:@"添加账号失败"];
               }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"添加账号失败"];
    }];
     
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_name_F endEditing:YES];
    [_password_F endEditing:YES];
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
