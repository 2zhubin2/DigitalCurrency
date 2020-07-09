//
//  ZBFabuViewController.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/6/29.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBFabuViewController.h"
#import "SelectPhotoManager.h"

@interface ZBFabuViewController ()<UITextViewDelegate,selectPhotoDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *TiShiLabel;
@property (strong, nonatomic) IBOutlet UITextView *text_FV;
@property (strong, nonatomic) IBOutlet UIButton *openCaremaBtn;

@property (nonatomic,strong)SelectPhotoManager *photoManger;
@property (strong, nonatomic) IBOutlet UIView *pic_BgView;

@property(nonatomic,weak)UIImageView *image_V;
@property (strong, nonatomic) IBOutlet UIButton *deldeteImageVBtn;


@end

@implementation ZBFabuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStyleDone target:self action:@selector(backSetting)];
                self.navigationItem.leftBarButtonItem = leftItem;
                self.navigationItem.title = @"发布";
    //调用相机
//    [self setphotoImage];
    
    self.text_FV.delegate = self;
}




- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
       self.tabBarController.tabBar.hidden = YES;
}

-(void)backSetting{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"开始编辑");
    _TiShiLabel.hidden = YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    //
}
- (IBAction)clickCamera:(UIButton *)sender {
    UIImagePickerController *pickVC = [[UIImagePickerController alloc]init];
    pickVC.delegate = self;
    [self presentViewController:pickVC animated:YES completion:nil];
}

- (IBAction)ClickDeleteImageV:(UIButton *)sender {
    
    if (self.pic_BgView.subviews.count != 0) {
        [self.pic_BgView.subviews.lastObject removeFromSuperview];
        self.deldeteImageVBtn.hidden = YES;
    }
}
- (IBAction)clickFaBu:(UIButton *)sender {
    
    if (self.pic_BgView.subviews.count != 0) {
        [self ZBbeginFabu];
    }else{
        [MBProgressHUD showError:@"图片不能为空"];
    }
    
}


//获取选择的图片
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *pickImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    UIImageView *image_v = [[UIImageView alloc] init];
    image_v.image = pickImage;
    image_v.contentMode = UIViewContentModeScaleToFill;
    self.image_V =  image_v;
    if (self.pic_BgView.subviews.count != 0) {
        [self.pic_BgView.subviews.lastObject removeFromSuperview];
    }
    [self.pic_BgView addSubview:image_v];
    self.deldeteImageVBtn.hidden = NO;
    [image_v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pic_BgView);
        make.left.equalTo(self.pic_BgView);
        make.bottom.equalTo(self.pic_BgView);
        make.right.equalTo(self.pic_BgView);
        
    }];
    
//    _addImageView.image = pickImage;
}


#pragma mark -发送post请求，实现发布功能
-(void)ZBbeginFabu{
    
//    NSInteger curTimeTap = [HNPFabuVC getNowTimestamp];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    [par setObject:appDelegate.mineUserInfoModel.userID forKey:@"userId"];
    [par setObject:@"false" forKey:@"displayBig"];
    [par setObject:_text_FV.text forKey:@"content"];
    [par setObject:@"" forKey:@"video"];
    [par setObject:@"" forKey:@"picture"];
    
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
   
    [manager POST:@"http://api.yysc.online/user/talk/publishTalk" parameters:par headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
        NSDictionary *data = responseObject;
//        NSLog(@"%@",data);
        NSString *success = [NSString stringWithFormat:@"%@",data[@"code"]];
        if ([success isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:@"发布成功..."];
            
            //延时执行代码
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                 [MBProgressHUD hideHUD];
//
//                });
        }else{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"发布失败，重新输入"];
        }
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD showError:@"发布失败，重新输入"];
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
