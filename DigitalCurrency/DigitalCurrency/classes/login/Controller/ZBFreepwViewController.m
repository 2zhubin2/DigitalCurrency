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

@interface ZBFreepwViewController ()
@property (strong, nonatomic) IBOutlet UITextField *phone_F;
@property (strong, nonatomic) IBOutlet UITextField *code_F;

@end

@implementation ZBFreepwViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStyleDone target:self action:@selector(backSetting)];
       self.navigationItem.leftBarButtonItem = leftItem;
    
}

-(void)backSetting{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)clickLogin:(id)sender {
    [self beginLogin];
}

- (IBAction)ClickGetCode:(id)sender {
    
//    ZBimageCodeViewController *vc = [[ZBimageCodeViewController alloc] init];
//    [self presentViewController:vc animated:YES completion:nil];
    ZBimageCodeView *view = [[ZBimageCodeView alloc] init];
    view.phone = self.phone_F.text;
    view.type = @"2";

    
    [self.navigationController.view addSubview:view];
    view.frame = self.view.frame;
}

-(void)beginLogin{
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    [par setObject:self.phone_F.text forKey:@"phone"];
    [par setObject:@"" forKey:@"password"];
    [par setObject:@"2" forKey:@"type"];
    [par setObject:@"futures" forKey:@"project"];
    [par setObject:self.code_F.text forKey:@"code"];

   

//    NSLog(@"%@",par);

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://api.yysc.online/system/login" parameters:par headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSDictionary *data = responseObject;
               NSString *success = [NSString stringWithFormat:@"%@",data[@"success"]];
        NSDictionary *dict = data[@"data"];
//               NSLog(@"data===%@",data);
//        NSLog(@"dict===%@",dict);
               if ([success isEqualToString:@"1"]) {
                   [MBProgressHUD showMessage:@"登录成功..."];
//                   ZBPersonModel *perModel = [ZBPersonModel ZBPersonModelWithDict:dict];
                 
                       //延时执行代码
                       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                           [MBProgressHUD hideHUD];
                           /*
                           if (self.loginType == NO) {
                                   //存入用户数据
                                   NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user.plist"];
                                   NSDictionary *tempDic = [perModel mj_keyValues];
                                   [tempDic writeToFile:path atomically:YES];
                                   
                               [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:self];
                           }else{
                                //存入用户数据
                                NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user.plist"];
                                NSDictionary *tempDic = [perModel mj_keyValues];
                                [tempDic writeToFile:path atomically:YES];
//                               [[NSNotificationCenter defaultCenter] postNotificationName:@"back" object:self];
//                               [[NSNotificationCenter defaultCenter] postNotificationName:@"backPre" object:nil];
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:self];
//                               [self.navigationController popViewControllerAnimated:YES];
                               [self dismissViewControllerAnimated:YES completion:nil];
                               
                           }
                       */
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
