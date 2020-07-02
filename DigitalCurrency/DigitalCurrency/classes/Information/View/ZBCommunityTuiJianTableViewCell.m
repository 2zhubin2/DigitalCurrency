//
//  ZBCommunityTuiJianTableViewCell.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/1.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBCommunityTuiJianTableViewCell.h"

@interface ZBCommunityTuiJianTableViewCell ()

@property (strong, nonatomic) IBOutlet UIView *bg_view;
@property (strong, nonatomic) IBOutlet UIView *view_imagebg;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *view_imagebgH;


@end

@implementation ZBCommunityTuiJianTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupImageView];
    [self setupshadowColor];
    
    if (_view_imagebg.subviews.count == 0) {
        _view_imagebgH.constant = 1;
    }
    
}

-(void)setupImageView{
    UIImageView *imagview = [[UIImageView alloc] init];
    imagview.image = [UIImage imageNamed:@"pic_dongtai1"];
    imagview.contentMode = UIViewContentModeScaleToFill;
    [self.view_imagebg
     addSubview:imagview];
    [imagview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view_imagebg.mas_top);
        make.left.equalTo(self.view_imagebg.mas_left);
        make.bottom.equalTo(self.view_imagebg.mas_bottom);
        make.right.equalTo(self.view_imagebg.mas_right);
    }];
}

-(void)setupshadowColor{
    
    _bg_view.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.32].CGColor;
    _bg_view.layer.shadowOffset = CGSizeMake(2,2);
    _bg_view.layer.shadowOpacity = 1;
    _bg_view.layer.shadowRadius = 5;
     _bg_view.layer.cornerRadius = 5;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
