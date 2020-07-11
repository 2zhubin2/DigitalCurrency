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

@property(nonatomic,copy)NSString *saveUrl;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *Top_H;


@end

@implementation ZBFabuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (@available(iOS 13.0, *)) {
        
        //
        
    } else {
        _Top_H.constant = 70;
    }
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStyleDone target:self action:@selector(backSetting)];
                self.navigationItem.leftBarButtonItem = leftItem;
                self.navigationItem.title = @"发布";

    self.text_FV.delegate = self;
}


- (IBAction)cilckLabel_one:(UIButton *)sender {
    
    self.text_FV.text = [NSString stringWithFormat:@"%@%@",self.text_FV.text,sender.titleLabel.text];
    _TiShiLabel.hidden = YES;
}


- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
       self.tabBarController.tabBar.hidden = YES;
}

-(void)backSetting{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)textViewDidBeginEditing:(UITextView *)textView{
    _TiShiLabel.hidden = YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    //
}

#pragma mark - 点击相机
- (IBAction)clickCamera:(UIButton *)sender {

    if (!_photoManger) {
          _photoManger = [[SelectPhotoManager alloc]init];
          _photoManger.delegate = self;
      }
         [_photoManger startSelectPhotoWithImageName:@"选择头像"];
              __weak typeof (self)mySelf = self;
              _photoManger.successHandle = ^(SelectPhotoManager *manager, UIImage *image) {
                  UIImageView *image_v = [[UIImageView alloc] init];
                     image_v.image = image;
                     image_v.contentMode = UIViewContentModeScaleToFill;
                     mySelf.image_V =  image_v;
                  if (mySelf.pic_BgView.subviews.count != 0) {
                        [mySelf.pic_BgView.subviews.lastObject removeFromSuperview];
                    }
                    [mySelf.pic_BgView addSubview:image_v];
                    mySelf.deldeteImageVBtn.hidden = NO;
                    [image_v mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(mySelf.pic_BgView);
                        make.left.equalTo(mySelf.pic_BgView);
                        make.bottom.equalTo(mySelf.pic_BgView);
                        make.right.equalTo(mySelf.pic_BgView);

                    }];

              };
}

#pragma mark - 删除图片
- (IBAction)ClickDeleteImageV:(UIButton *)sender {
    
    if (self.pic_BgView.subviews.count != 0) {
        [self.pic_BgView.subviews.lastObject removeFromSuperview];
        self.deldeteImageVBtn.hidden = YES;
    }
}

- (IBAction)clickOne:(UIButton *)sender {
//    [MBProgressHUD showSuccess:@"点击成功..."];
    if (self.pic_BgView.subviews.count != 0) {
        
        [self uoLoadPicture];

    }else{
        [MBProgressHUD showError:@"图片不能为空"];
    }
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
    [par setObject:self.saveUrl forKey:@"picture"];



    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager POST:@"http://api.yysc.online/user/talk/publishTalk" parameters:par headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSDictionary *data = responseObject;
//        NSLog(@"%@",data);
        NSString *success = [NSString stringWithFormat:@"%@",data[@"code"]];
        if ([success isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:@"发布成功..."];

        }else{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"发布失败，重新输入"];
        }

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD showError:@"发布失败，重新输入"];
        }];
   


}


#pragma mark -上传图片
-(void)uoLoadPicture{
    
    NSDictionary *dict = @{
        @"file" : self.image_V.image
    };
    [NetworkTool.shared postReturnString:@"http://image.yysc.online/upload" fileName:@"iconImage" image:self.image_V.image viewcontroller:nil params:dict success:^(id _Nonnull response) {
        [MBProgressHUD showSuccess:@"上传图片中"];
        self.saveUrl = response;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
            [self ZBbeginFabu];
        });
    } failture:^(NSError * _Nonnull error) {
        [MBProgressHUD showError:@"上传图片失败"];
    }];
    
}


@end
