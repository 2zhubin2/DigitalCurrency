//
//  ZBMineFenSiCell.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/7.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBMineFenSiCell.h"

@interface ZBMineFenSiCell ()

@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UIImageView *head_imageV;
@property (strong, nonatomic) IBOutlet UILabel *name_label;
@property (strong, nonatomic) IBOutlet UILabel *fansCountLabel;
@property (strong, nonatomic) IBOutlet UIButton *guanzhuBtn;

@end

@implementation ZBMineFenSiCell


- (void)setModel:(ZBMineGuanZhuModel *)model{
    _model = model;
    [_head_imageV sd_setImageWithURL:[NSURL URLWithString:model.head]];
    _name_label.text = model.nickName;
    _fansCountLabel.text = [NSString stringWithFormat:@"%@粉丝",model.fansCount];
    

      
    
        self.guanzhuBtn.layer.cornerRadius = 14;
    self.guanzhuBtn.clipsToBounds = YES;
        
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupshadowColor];
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

@end
