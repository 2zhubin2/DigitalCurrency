//
//  ZBQieHuanZhangHaoViewController.m
//  DigitalCurrency
//
//  Created by HFY on 2020/7/2.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBQieHuanZhangHaoViewController.h"

@interface ZBQieHuanZhangHaoViewController ()
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
    _preSelectBtn = _btn_one;
    _preSelectBtn.selected = YES;
    
}

-(void)backSetting{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)clickBtnOne:(UIButton *)sender {
    
    _preSelectBtn.selected = NO;
    sender.selected = !sender.isSelected;
    _preSelectBtn = sender;
    
}
- (IBAction)clickBtn_two:(UIButton *)sender {
    
    _preSelectBtn.selected = NO;
    sender.selected = !sender.isSelected;
    _preSelectBtn = sender;
}
- (IBAction)addClick:(id)sender {
    //
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
