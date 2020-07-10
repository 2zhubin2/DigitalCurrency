//
//  ZBBianJiZiLiaoViewController.m
//  DigitalCurrency
//
//  Created by HFY on 2020/7/2.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBBianJiZiLiaoViewController.h"
#import "SelectPhotoManager.h"

@interface ZBBianJiZiLiaoViewController ()<selectPhotoDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *topImageV;
@property (strong, nonatomic) IBOutlet UIImageView *bgImageV;
@property (strong, nonatomic) IBOutlet UITextField *sex_FV;
@property (strong, nonatomic) IBOutlet UITextField *nickName_F;
@property (strong, nonatomic) IBOutlet UITextField *sigure_F;

@property (nonatomic,strong)SelectPhotoManager *photoManger;
@property(nonatomic,copy)NSString *saveUrl;

@end

@implementation ZBBianJiZiLiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStyleDone target:self action:@selector(backSetting)];
             self.navigationItem.leftBarButtonItem = leftItem;
             self.navigationItem.title = @"编辑资料";
    
//    _topImageV.image = [UIImage imageNamed:@"morentouxiang2"];
    _bgImageV.image = [UIImage imageNamed:@"bg_bianjiziliao"];
    _topImageV.layer.cornerRadius = 50;
    _topImageV.clipsToBounds = YES;
    [_topImageV sd_setImageWithURL:[NSURL URLWithString:appDelegate.mineUserInfoModel.head] placeholderImage:[UIImage imageNamed:@"morentouxiang2"]];
    _nickName_F.text = appDelegate.mineUserInfoModel.nickName;
    _sigure_F.text = appDelegate.mineUserInfoModel.signature;
    
}
- (IBAction)clickCamera:(UIButton *)sender {
    
    if (!_photoManger) {
        _photoManger = [[SelectPhotoManager alloc]init];
        _photoManger.delegate = self;
    }
       [_photoManger startSelectPhotoWithImageName:@"选择头像"];
            __weak typeof (self)mySelf = self;
            _photoManger.successHandle = ^(SelectPhotoManager *manager, UIImage *image) {
                mySelf.topImageV.image = image;
               
            };
//    [MBProgressHUD showError:@"暂不支持修改头像"];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

-(void)backSetting{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)BeginEditingSex:(id)sender {
    
    [self selectSex];
    
}
- (IBAction)changeEdit:(id)sender {
    [self selectSex];
}

- (IBAction)cilckWanChen:(UIButton *)sender {
    
    if (_saveUrl == nil) {
        [self uoLoadPicture];
    }else{
        if (self.nickName_F.text.length != 0) {
               if (self.sigure_F.text.length != 0) {
                    [self reSetZiLiao];
               }else{
               [MBProgressHUD showError:@"请输入个性签名"];
               }
           }else{
               [MBProgressHUD showError:@"请输入昵称"];
           }
    }
    
   
   
}


-(void)selectSex{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    actionSheet.title = @"选择性别";
    
    //修改标题的内容，字号，颜色。使用的key值是“attributedTitle”
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:@"选择性别"];
    [hogan addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, [[hogan string] length])];
    [hogan addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] range:NSMakeRange(0, [[hogan string] length])];
    [actionSheet setValue:hogan forKey:@"attributedTitle"];

    
    
     UIAlertAction *zeroAction = [UIAlertAction actionWithTitle:@"保密" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //        NSLog(@"点击了取消");
         self.sex_FV.text = @"保密";
     }];
    //修改按钮的颜色，同上可以使用同样的方法修改内容，样式
    [zeroAction setValue:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forKey:@"_titleTextColor"];
   
    
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"保密" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
//    [actionSheet setValue:string forKey:@"_attributedTitle"];

    
    
    
    
    UIAlertAction *OneAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"点击了取消");
        self.sex_FV.text = @"男";

    }];
    [OneAction setValue:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forKey:@"_titleTextColor"];
    
    UIAlertAction *twoAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    //        NSLog(@"点击了取消");
        self.sex_FV.text = @"女";

        }];
    [twoAction setValue:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forKey:@"_titleTextColor"];
    
    UIAlertAction *quexiaoAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        self.sex_FV.text = @"";
    }];
    [quexiaoAction setValue:[UIColor colorWithRed:50/255.0 green:83/255.0 blue:250/255.0 alpha:1.0] forKey:@"_titleTextColor"];
    
    /*
     UILabel *label = [[UILabel alloc] init];
     label.frame = CGRectMake(174,628.5,26.5,13);
     label.numberOfLines = 0;
     [self.view addSubview:label];

     NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"取消" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:50/255.0 green:83/255.0 blue:250/255.0 alpha:1.0]}];

     label.attributedText = string;
     */

//    [actionSheet addAction:cancel_action];
    [actionSheet addAction:zeroAction];
    [actionSheet addAction:OneAction];
    [actionSheet addAction:twoAction];
    [actionSheet addAction:quexiaoAction];
    [self presentViewController:actionSheet animated:YES completion:nil];
}


-(void)reSetZiLiao{
    [MBProgressHUD showMessage:@"正在修改..."];
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
        @"id" : appDelegate.mineUserInfoModel.userID,
        @"nickName" : self.nickName_F.text,
        @"signature":self.sigure_F.text,
        @"head":self.saveUrl
    };
    
    [manager PUT:@"http://api.yysc.online/user/personal/updateUser" parameters:tempdict headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        if ([responseObject[@"success"] isEqualToNumber:@1]) {
            NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user.plist"];
            NSMutableDictionary *userPlist = [[[NSMutableDictionary alloc] initWithContentsOfFile:path] mutableCopy];
            [userPlist setObject:self.nickName_F.text forKey:@"nickName"];
            [userPlist setObject:self.sigure_F.text forKey:@"signature"];
            [userPlist setObject:self.saveUrl forKey:@"head"];
            [userPlist writeToFile:path atomically:YES];
            appDelegate.mineUserInfoModel.nickName = self.nickName_F.text;
            appDelegate.mineUserInfoModel.signature = self.sigure_F.text;
            appDelegate.mineUserInfoModel.head = self.saveUrl;
            [MBProgressHUD showSuccess:@"修改成功" ];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"edit" object:self];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            [MBProgressHUD showError:@"修改失败"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络错误"];
        NSLog(@"%@",error);
    }];
}


#pragma mark -上传图片

-(void)uoLoadPicture{
    
    NSDictionary *dict = @{
        @"file" : self.topImageV.image
    };
    [NetworkTool.shared postReturnString:@"http://image.yysc.online/upload" fileName:@"iconImage" image:self.topImageV.image viewcontroller:nil params:dict success:^(id _Nonnull response) {
        [MBProgressHUD showSuccess:@"上传图片中"];
        self.saveUrl = response;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
           if (self.nickName_F.text.length != 0) {
                if (self.sigure_F.text.length != 0) {
                    [self reSetZiLiao];
                }else{
                    [MBProgressHUD showError:@"请输入个性签名"];
                }
                }else{
                    [MBProgressHUD showError:@"请输入昵称"];
                }
        });
//        NSLog(@"%@",self.saveUrl);
    } failture:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"上传图片失败"];
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
