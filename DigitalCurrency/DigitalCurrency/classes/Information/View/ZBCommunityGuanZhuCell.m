//
//  ZBCommunityGuanZhuCell.m
//  DigitalCurrency
//
//  Created by HFY on 2020/7/1.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBCommunityGuanZhuCell.h"

@interface ZBCommunityGuanZhuCell ()

@property (strong, nonatomic) IBOutlet UIView *bg_view;

@property (strong, nonatomic) IBOutlet UIImageView *head_imageV;
@property (strong, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *fansiCountLabel;
@property (strong, nonatomic) IBOutlet UIButton *ganzhuBtn;

@end

@implementation ZBCommunityGuanZhuCell

- (void)setModel:(ZBCommunityGuanZhuModel *)model{
    _model = model;
    if (![model.head containsString:@"<html>"] && model.head.length != 0) {
        
        [_head_imageV sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
         }
    _nickNameLabel.text = model.nickName;
    _fansiCountLabel.text = [NSString stringWithFormat:@"%@粉丝",model.fansCount];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupshadowColor];
    _head_imageV.layer.cornerRadius = 20;
    _ganzhuBtn.layer.cornerRadius = 14;
}


-(void)setupshadowColor{
    _bg_view.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.32].CGColor;
    _bg_view.layer.shadowOffset = CGSizeMake(2,2);
    _bg_view.layer.shadowOpacity = 1;
    _bg_view.layer.shadowRadius = 5;
    _bg_view.layer.cornerRadius = 5;
}

- (IBAction)clickGuanZhu:(UIButton *)sender{
    sender.layer.cornerRadius = 14;
    sender.layer.borderColor = [UIColor colorWithRed:50/255.0 green:83/255.0 blue:250/255.0 alpha:1.0].CGColor;
    sender.layer.borderWidth = 1;
    sender.backgroundColor = [UIColor whiteColor];
    [sender setTitle:@"已关注" forState:UIControlStateNormal];
    sender.enabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
