//
//  ZBimageCodeView.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/6.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBimageCodeView.h"

@interface ZBimageCodeView ()

@property (strong, nonatomic) IBOutlet UITextField *text_F;
@property (strong, nonatomic) IBOutlet UIButton *refreshBtn;
@property (strong, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation ZBimageCodeView


#pragma mark - awakeFromNib
- (void)awakeFromNib{
    [super awakeFromNib];
    
    //添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setRefreshImage)];
           [self.imageV addGestureRecognizer:tap];
}

#pragma mark - initWithFrame
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        return [[NSBundle mainBundle] loadNibNamed:@"ZBimageCodeView" owner:nil options:nil].lastObject;
       
    }
    return self;
}

#pragma mark - 点击刷新
- (IBAction)clickFresh:(id)sender {
    _refreshBtn.hidden = YES;
    [self setRefreshImage];
}

#pragma mark - 点击退出
- (IBAction)ClicktuIchu:(id)sender {
    
    [self removeFromSuperview];
    
}

#pragma mark - 点击确认
- (IBAction)clickqueren:(id)sender {
    
    [self sendVerification_code];
    
}

#pragma mark - 更新验证码图片
-(void)setRefreshImage{
    
    NSURL *url = [NSURL URLWithString:@"http://api.yysc.online/system/sendVerify"];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSString *imageS = [NSString stringWithFormat:@"%@",dict[@"data"]];
         NSData *ImageData =[[NSData alloc]initWithBase64EncodedString:imageS options:NSDataBase64DecodingIgnoreUnknownCharacters];
       UIImage *testImage = [UIImage imageWithData:ImageData];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.imageV.image = testImage;
        }];
        
    }]resume];
     
}

#pragma mark - 获取验证码
-(void)sendVerification_code{
   
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    [par setObject:self.phone forKey:@"phone"];
    [par setObject:self.type forKey:@"type"];
    [par setObject:@"futures" forKey:@"project"];
    [par setObject:self.text_F.text forKey:@"code"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://api.yysc.online/system/sendCode" parameters:par headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
        NSDictionary *data = responseObject;
        NSString *success = [NSString stringWithFormat:@"%@",data[@"success"]];
        NSLog(@"%@",data);
        if ([success isEqualToString:@"1"]) {
            [MBProgressHUD showMessage:@"获取验证码成功..."];
            
            //延时执行代码
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [MBProgressHUD hideHUD];
                [self removeFromSuperview];
                    
                });
        }else{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"获取验证码失败"];
        }
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"获取验证码失败"];
        }];
        
    
}

#pragma mark - touchesBegan
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}

@end
