//
//  ZBInformationDetail_oneCell.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/3.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBInformationDetail_oneCell.h"

@interface ZBInformationDetail_oneCell ()

@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UILabel *header_label;


@end

@implementation ZBInformationDetail_oneCell

- (void)setModel:(ZBNewInformationModel *)model{
    
    _model = model;
    _contentLabel.text = model.content;
        

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_header_label setValue:@(17) forKey:@"lineSpacing"];
    [_contentLabel setValue:@(20) forKey:@"lineSpacing"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
