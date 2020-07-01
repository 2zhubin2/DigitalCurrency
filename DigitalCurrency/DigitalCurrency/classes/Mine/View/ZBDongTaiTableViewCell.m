//
//  ZBDongTaiTableViewCell.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/1.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBDongTaiTableViewCell.h"

@interface ZBDongTaiTableViewCell ()

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *view_imageSuperH;
@property (strong, nonatomic) IBOutlet UIView *view_imageSuper;

@property (strong, nonatomic) IBOutlet UIView *bgView;

@end

@implementation ZBDongTaiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setupImageView];
    
    if (_view_imageSuper.subviews.count == 0) {
        _view_imageSuperH.constant = 1;
    }
    [self setupShadowColor];
    
    
}

-(void)setupShadowColor{
    

    _bgView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.32].CGColor;
    _bgView.layer.shadowOffset = CGSizeMake(2,2);
    _bgView.layer.shadowOpacity = 1;
    _bgView.layer.shadowRadius = 5;
    _bgView.layer.cornerRadius = 5;
}

-(void)setupImageView{
    UIImageView *imagview = [[UIImageView alloc] init];
    imagview.image = [UIImage imageNamed:@"pic_dongtai1"];
    imagview.contentMode = UIViewContentModeScaleToFill;
    [self.view_imageSuper addSubview:imagview];
    [imagview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view_imageSuper.mas_top);
        make.left.equalTo(self.view_imageSuper.mas_left);
        make.bottom.equalTo(self.view_imageSuper.mas_bottom);
        make.right.equalTo(self.view_imageSuper.mas_right);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
