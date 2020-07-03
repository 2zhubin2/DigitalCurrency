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


@end

@implementation ZBHomeTableViewCell

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
