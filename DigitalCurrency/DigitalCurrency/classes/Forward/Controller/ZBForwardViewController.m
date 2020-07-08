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
    NSLog(@"BeginFaSong");
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
