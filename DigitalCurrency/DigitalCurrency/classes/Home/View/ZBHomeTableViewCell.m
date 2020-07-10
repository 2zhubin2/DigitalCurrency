//
//  ZBHomeTableViewCell.m
//  DigitalCurrency
//
//  Created by HFY on 2020/6/29.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBHomeTableViewCell.h"

@interface ZBHomeTableViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *image_V_updown;
@property (strong, nonatomic) IBOutlet UIImageView *image_v_head;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *upPercent;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *upOrDownPercentLabel;


@end

@implementation ZBHomeTableViewCell

- (void)setModel:(ZBHomeTableViewModel *)model{
    _model = model;
    _nameLabel.text = model.name;
    _upPercent.text = [NSString stringWithFormat:@"%@%%",model.upPercent];
    _priceLabel.text = model.price;
//    _upOrDownPercentLabel.text = model.upOrDownPercent;
    
    if (model.upOrDownPercent.intValue >= 0) {
        _upOrDownPercentLabel.text = [NSString stringWithFormat:@"+%@",model.upOrDownPercent];
        self.image_V_updown.image = [UIImage imageNamed:@"pic_up"];
    }else{
        _upOrDownPercentLabel.text = model.upOrDownPercent;
        self.image_V_updown.image = [UIImage imageNamed:@"pic_down"];
    }
    
    
    switch (self.row_num%5) {
        case 0:
            _image_v_head.image = [UIImage imageNamed:@"icon_btc"];
            break;
        case 1:
            _image_v_head.image = [UIImage imageNamed:@"icon_etth"];
        break;
        case 2:
            _image_v_head.image = [UIImage imageNamed:@"icon_hc"];
        break;
        case 3:
            _image_v_head.image = [UIImage imageNamed:@"icon_mof"];
        break;
        case 4:
            _image_v_head.image = [UIImage imageNamed:@"icon_exn"];
        break;
        default:
            break;
    }
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _image_V_updown.image = [UIImage imageNamed:@"pic_down"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
