//
//  ZBMineGuanZhuTableViewCell.m
//  DigitalCurrency
//
//  Created by HFY on 2020/6/30.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBMineGuanZhuTableViewCell.h"

@interface ZBMineGuanZhuTableViewCell ()

@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UIImageView *head_imageV;

@property (strong, nonatomic) IBOutlet UILabel *name_label;
@property (strong, nonatomic) IBOutlet UILabel *fansCountLabel;
@property (strong, nonatomic) IBOutlet UIButton *guanzhuBtn;

@end

@implementation ZBMineGuanZhuTableViewCell

- (void)setModel:(ZBMineGuanZhuModel *)model{
    _model = model;
    
    if (![model.head containsString:@"<html>"] && model.head.length != 0) {
//        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.head]];
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
        /*
         placeholderImage:[UIImage imageNamed:@"morentouxiang"
         */
    }
    
    _name_label.text = model.nickName;
    _fansCountLabel.text = [NSString stringWithFormat:@"%@粉丝",model.fansCount];
    

      
    self.guanzhuBtn.backgroundColor = [UIColor whiteColor];
    self.guanzhuBtn.layer.cornerRadius = 14;

    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _iconImageView.layer.cornerRadius = 20;
    [self setupshadowColor];
//    _view.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
}

-(void)setupshadowColor{
    _view.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.32].CGColor;
    _view.layer.shadowOffset = CGSizeMake(2,2);
    _view.layer.shadowOpacity = 1;
    _view.layer.shadowRadius = 5;
     _view.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clickGuanZhu:(UIButton *)sender {
    NSLog(@"123");
}

@end
