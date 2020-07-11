//
//  ZBFanKuiZXViewController.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/2.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBFanKuiZXViewController.h"

@interface ZBFanKuiZXViewController ()<UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *text_FV;
@property (strong, nonatomic) IBOutlet UILabel *TiShiLabel;
@property (strong, nonatomic) IBOutlet UILabel *CountLabel;

@end

@implementation ZBFanKuiZXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStyleDone target:self action:@selector(backSetting)];
          self.navigationItem.leftBarButtonItem = leftItem;
          self.navigationItem.title = @"举报";
    _text_FV.delegate = self;
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBack)];
    [self.view addGestureRecognizer:swipe];

    
    [self setupShadowColor];
    
}

-(void)swipeBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)backSetting{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置阴影
-(void)setupShadowColor{
    _text_FV.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.32].CGColor;
    _text_FV.layer.shadowOffset = CGSizeMake(2,2);
    _text_FV.layer.shadowOpacity = 1;
    _text_FV.layer.shadowRadius = 5;
    _text_FV.layer.cornerRadius = 5;
}

#pragma mark - 点击提交
- (IBAction)tijiaoClick:(id)sender {
        if (self.text_FV.text.length != 0) {
    //        NSLog(@"开始举报");
            [self ZBbeginJuBao];
        }else{
            [MBProgressHUD showError:@"请输入举报原因"];
        }
}


- (void)textViewDidBeginEditing:(UITextView *)textView{
//    NSLog(@"开始编辑");
    _TiShiLabel.hidden = YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    _CountLabel.text = [NSString stringWithFormat:@"%ld",_text_FV.text.length];
    
    if (_text_FV.text.length <= 300) {
        _text_FV.editable = YES;
    }else{
        _text_FV.text = [_text_FV.text substringToIndex:300];
        _CountLabel.text = [NSString stringWithFormat:@"%ld",_text_FV.text.length];
        [MBProgressHUD showError:@"最多填入300字"];
    }
}

#pragma mark - 开始举报
-(void)ZBbeginJuBao{
     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    NSInteger curTimeTap = [HNPFabuVC getNowTimestamp];
    
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
//    [par setObject:self.userID forKey:@"userId"];
 
    [par setObject:appDelegate.mineUserInfoModel.userID forKey:@"userId"];
    [par setObject:self.model.talkId forKey:@"talkId"];
    [par setObject:self.text_FV.text forKey:@"content"];
    [par setObject:@"" forKey:@"contact"];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
   
    [manager POST:@"http://api.yysc.online/user/talk/reportTalk" parameters:par headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
        NSDictionary *data = responseObject;
//        NSLog(@"%@",data);
        NSString *success = [NSString stringWithFormat:@"%@",data[@"success"]];
        if ([success isEqualToString:@"1"]) {
             [MBProgressHUD hideHUD];
            [MBProgressHUD showMessage:@"举报成功..."];
            
            //延时执行代码
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [MBProgressHUD hideHUD];
                [self.navigationController popViewControllerAnimated:YES];
            
                });
        }else{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"举报失败，重新输入"];
        }
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"举报失败，重新输入"];
        }];
        
    
}

@end
