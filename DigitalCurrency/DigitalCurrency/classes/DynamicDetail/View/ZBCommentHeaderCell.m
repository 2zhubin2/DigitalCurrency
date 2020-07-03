//
//  ZBCommentHeaderCell.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/3.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBCommentHeaderCell.h"

@interface ZBCommentHeaderCell ()

@property (strong, nonatomic) IBOutlet UIView *view_imagebg;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *view_imagebgH;

@end


@implementation ZBCommentHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupImageView];
        
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
