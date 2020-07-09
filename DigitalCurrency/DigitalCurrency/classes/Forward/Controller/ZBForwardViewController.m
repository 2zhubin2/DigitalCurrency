//
//  ZBForwardViewController.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/4.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBForwardViewController.h"

@interface ZBForwardViewController ()<UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *text_V;
@property (strong, nonatomic) IBOutlet UILabel *tishiLabel;
@property (strong, nonatomic) IBOutlet UIImageView *image_V;
@property (strong, nonatomic) IBOutlet UILabel *NickNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UIButton *TSPLBtn;

@end

@implementation ZBForwardViewController

- (void)setModel:(ZBCommunityTuiJianModel *)model{
    _model = model;
    if (model.picture.length != 0 && ![model.picture containsString:@"<html>"]) {
        
        [_image_V sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
        }
    
    _NickNameLabel.text = model.user.nickName;
    _contentLabel.text = model.content;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStyleDone target:self action:@selector(backMine)];
             self.navigationItem.leftBarButtonItem = leftItem;
             self.navigationItem.title = @"分享";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(BeginFaSong)];
    self.navigationItem.rightBarButtonItem = rightItem;

    if (_model.picture.length != 0 && ![_model.picture containsString:@"<html>"]) {

        [_image_V sd_setImageWithURL:[NSURL URLWithString:_model.picture] placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
        }

    _NickNameLabel.text = _model.user.nickName;
    _contentLabel.text = _model.content;

    _text_V.delegate = self;
}

-(void)BeginFaSong{
//    NSLog(@"BeginFaSong");
    if (_text_V.text.length != 0) {
         [self ZBbeginFenXiang];
    }else{
        [MBProgressHUD showError:@"请输入分享内容"];
    }
   
}

-(void)backMine{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}


- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"开始编辑");
    _tishiLabel.hidden = YES;
}

- (IBAction)ClickTSPL:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}

#pragma mark - 分享功能
-(void)ZBbeginFenXiang{
//        [MBProgressHUD showMessage:@"正在修改..."];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        AFJSONResponseSerializer *response   = [AFJSONResponseSerializer serializer];
        response.removesKeysWithNullValues = YES;
        response.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/html",@"text/css",@"text/javascript", nil];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"Referer"];
        // 设置超时时间
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 20.f;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        manager.responseSerializer = response;
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSDictionary *tempdict = @{
            @"content" : self.text_V.text,
        };
    NSString *url = [NSString stringWithFormat:@"http://api.yysc.online/user/userTalk/userTalkOperation?talkId=%@&type=3&userId=%@",self.model.talkId,appDelegate.mineUserInfoModel.userID];
    
//    NSLog(@"~~");
        [manager PUT:url parameters:tempdict headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [MBProgressHUD hideHUD];
            if ([responseObject[@"success"] isEqualToNumber:@1]) {

                [MBProgressHUD showSuccess:@"转发成功" ];
                 
                if (self.TSPLBtn.isSelected) {
                    [self ZBbeginFabuPL];
                }else{
                    self.text_V.text = @"";
                }
                
//                [self.navigationController popViewControllerAnimated:YES];
            }
            else {
                [MBProgressHUD showError:@"转发失败"];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"网络错误"];
            NSLog(@"%@",error);
        }];
        
    
}

#pragma mark - 发布评论功能
-(void)ZBbeginFabuPL{
    
//    NSInteger curTimeTap = [HNPFabuVC getNowTimestamp];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
//    [par setObject:self.userID forKey:@"userId"];
 
    [par setObject:appDelegate.mineUserInfoModel.userID forKey:@"userId"];
    [par setObject:self.model.talkId forKey:@"talkId"];
    [par setObject:self.text_V.text forKey:@"content"];
    [par setObject:@"" forKey:@"video"];
    [par setObject:@"" forKey:@"matchId"];
    
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
   
    [manager POST:@"http://api.yysc.online/user/talk/commentTalk" parameters:par headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
        NSDictionary *data = responseObject;
//        NSLog(@"%@",data);
        NSString *success = [NSString stringWithFormat:@"%@",data[@"success"]];
        if ([success isEqualToString:@"1"]) {
            [MBProgressHUD showMessage:@"评论成功..."];
            
            //延时执行代码
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [MBProgressHUD hideHUD];
               self.text_V.text = @"";
//                [self.navigationController popViewControllerAnimated:YES];
                [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count-3] animated:YES];
            
                });
        }else{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"评论失败，重新输入"];
        }
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD showError:@"网络错误"];
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
