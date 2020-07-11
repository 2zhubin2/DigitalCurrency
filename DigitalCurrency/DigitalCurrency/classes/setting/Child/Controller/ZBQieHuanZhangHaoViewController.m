//
//  ZBQieHuanZhangHaoViewController.m
//  DigitalCurrency
//
//  Created by HFY on 2020/7/2.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBQieHuanZhangHaoViewController.h"
#import "ZBAddCountViewController.h"

@interface ZBQieHuanZhangHaoViewController ()<ZBAddCountViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *touxiang_one;
@property (strong, nonatomic) IBOutlet UIImageView *touxiang_two;

@property(nonatomic,strong)UIButton *preSelectBtn;
@property (strong, nonatomic) IBOutlet UIButton *btn_one;
@property (strong, nonatomic) IBOutlet UIButton *btn_two;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel_one;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel_two;

@end

@implementation ZBQieHuanZhangHaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStyleDone target:self action:@selector(backSetting)];
          self.navigationItem.leftBarButtonItem = leftItem;
          self.navigationItem.title = @"切换账号";
   
    _touxiang_one.layer.cornerRadius = 30;
    _touxiang_two.layer.cornerRadius = 30;
    _touxiang_one.clipsToBounds = YES;
    _touxiang_two.clipsToBounds = YES;
    _preSelectBtn = _btn_one;
    _preSelectBtn.selected = YES;
    
  
       
    
}


#pragma mark - setTempUserInfoModel
- (void)setTempUserInfoModel:(ZBMineUserInfoModel *)tempUserInfoModel{
    _tempUserInfoModel = tempUserInfoModel;
    if (![tempUserInfoModel.head containsString:@"<html>"] && tempUserInfoModel.head.length != 0) {
        [_touxiang_two sd_setImageWithURL:[NSURL URLWithString:tempUserInfoModel.head] placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
    }
    _nameLabel_two.text = tempUserInfoModel.nickName;
}

- (void)viewWillAppear:(BOOL)animated{
    [self determineWhetherToLogin_temp];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (![appDelegate.mineUserInfoModel.head containsString:@"<html>"] && appDelegate.mineUserInfoModel.head.length != 0) {

        [_touxiang_one sd_setImageWithURL:[NSURL URLWithString:appDelegate.mineUserInfoModel.head] placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
    }
    _nameLabel_one.text = appDelegate.mineUserInfoModel.nickName;
    
    if (_tempUserInfoModel != nil) {
        if (![_tempUserInfoModel.head containsString:@"<html>"] && _tempUserInfoModel.head.length != 0) {
            [_touxiang_two sd_setImageWithURL:[NSURL URLWithString:_tempUserInfoModel.head] placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
        }
        _nameLabel_two.text = _tempUserInfoModel.nickName;
    }
}

-(void)backSetting{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 点击左侧按钮
- (IBAction)clickBtnOne:(UIButton *)sender {
    
    _preSelectBtn.selected = NO;
    sender.selected = !sender.isSelected;
    _preSelectBtn = sender;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (_tempUserInfoModel != nil) {
        ZBMineUserInfoModel *temp = appDelegate.mineUserInfoModel;
        appDelegate.mineUserInfoModel = _tempUserInfoModel;
        //存入用户数据
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user.plist"];
        NSDictionary *tempDic = [self.tempUserInfoModel mj_keyValues];
        [tempDic writeToFile:path atomically:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:self];
        _tempUserInfoModel = temp;
        //存入临时用户数据
        NSString *path_temp = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user_temp.plist"];
        NSDictionary *tempDic_temp = [temp mj_keyValues];
        [tempDic_temp writeToFile:path_temp atomically:YES];
        
        [MBProgressHUD showSuccess:@"切换账号成功"];
    }
    
    
}

#pragma mark - 点击右侧按钮
- (IBAction)clickBtn_two:(UIButton *)sender {
    
    _preSelectBtn.selected = NO;
    sender.selected = !sender.isSelected;
    _preSelectBtn = sender;
     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (_tempUserInfoModel != nil) {
        ZBMineUserInfoModel *temp = appDelegate.mineUserInfoModel;
        appDelegate.mineUserInfoModel = _tempUserInfoModel;
        //存入用户数据
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user.plist"];
        NSDictionary *tempDic = [self.tempUserInfoModel mj_keyValues];
        [tempDic writeToFile:path atomically:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:self];
        _tempUserInfoModel = temp;
        //存入临时用户数据
        NSString *path_temp = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user_temp.plist"];
        NSDictionary *tempDic_temp = [temp mj_keyValues];
        [tempDic_temp writeToFile:path_temp atomically:YES];
        
        [MBProgressHUD showSuccess:@"切换账号成功"];
    }
   
    
}

#pragma mark - 点击添加
- (IBAction)addClick:(id)sender {
    ZBAddCountViewController *vc = [[ZBAddCountViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - ZBAddCountViewControllerDelegate
- (void)AddCountViewControllerAddSuccess:(ZBMineUserInfoModel *)model{
    _tempUserInfoModel = model;
    NSString *path_temp = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user_temp.plist"];
    NSDictionary *tempDic_temp = [model mj_keyValues];
    [tempDic_temp writeToFile:path_temp atomically:YES];
}


#pragma mark - 判断是否存储临时账号
/**判断是否存储临时账号*/
- (void)determineWhetherToLogin_temp
{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user_temp.plist"];
    ZBMineUserInfoModel *temp = [ZBMineUserInfoModel mj_objectWithFile:path];
    if (temp == nil) {
        //
    }else{
        self.tempUserInfoModel = temp;
    }

}


@end
