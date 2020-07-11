//
//  ZBZhuXiaoTangChuangView.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/6.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBZhuXiaoTangChuangView.h"

@implementation ZBZhuXiaoTangChuangView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        return [[NSBundle mainBundle] loadNibNamed:@"ZBZhuXiaoTangChuangView" owner:nil options:nil].lastObject;
    }
    return self;
}
- (IBAction)clickBack:(UIButton *)sender {
    
    [self removeFromSuperview];
}
- (IBAction)clickQueRen:(UIButton *)sender {
    
  
    [self beginZhuXiao];
    
    [self removeFromSuperview];
    
}

#pragma mark - 开始注销
-(void)beginZhuXiao{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    
 
//    [par setObject: forKey:@"userId"];
    [par setValue:appDelegate.mineUserInfoModel.userID forKey:@"userId"];
    
//    NSLog(@"%@",appDelegate.mineUserInfoModel.userID);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://api.yysc.online/user/personal/deleteByUserId" parameters:par headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSDictionary *data = responseObject;
        NSLog(@"%@",responseObject);
               NSString *success = [NSString stringWithFormat:@"%@",data[@"success"]];
               if ([success isEqualToString:@"1"]) {
                   [MBProgressHUD showSuccess:@"注销成功..."];
                    //清空用户数据
                    NSError *error;
                    NSFileManager *fileMger = [NSFileManager defaultManager];
                    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user.plist"];
                    if ([fileMger removeItemAtPath:path error:&error]) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"zhuxiao" object:self];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"backMe" object:self];
                    }else{
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"zhuxiao" object:self];
                         [[NSNotificationCenter defaultCenter] postNotificationName:@"backMe" object:self];
                    }
                                            
                    
               }else{
                   [MBProgressHUD hideHUD];
                   [MBProgressHUD showError:@"注销未成功"];
               }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"登录失败"];
    }];
     
    
}

@end
