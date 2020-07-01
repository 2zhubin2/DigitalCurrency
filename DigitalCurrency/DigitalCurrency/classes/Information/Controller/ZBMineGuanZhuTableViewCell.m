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


@end

@implementation ZBMineGuanZhuTableViewCell



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
