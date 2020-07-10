//
//  ZBsettingCell.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/10.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBsettingCell.h"
#import "ZBZhuXiaoViewController.h"
#import "ZBGuanYuWMViewController.h"
#import "ZBFanKuiZXViewController.h"
#import "ZBQieHuanZhangHaoViewController.h"
#import "ZBBianJiZiLiaoViewController.h"
#import "ZBResetPassWordViewController.h"

@interface ZBsettingCell ()

@property (strong, nonatomic) IBOutlet UIImageView *icon_ImageV;
@property (strong, nonatomic) IBOutlet UILabel *name_label;

@property (strong, nonatomic) IBOutlet UIView *down_line;

@end

@implementation ZBsettingCell

- (void)setNum:(NSInteger)num{
    _num = num;
    switch (_num) {
          case 0:
              _icon_ImageV.image = [UIImage imageNamed:@"btn_bianjizl"];
              _name_label.text = @"编辑资料";
              break;
          case 1:
          _icon_ImageV.image = [UIImage imageNamed:@"btn_xiugaimm"];
          _name_label.text = @"修改密码";
          break;
          case 2:
          _icon_ImageV.image = [UIImage imageNamed:@"btn_qiehuanzh"];
          _name_label.text = @"切换账号";
          break;
          case 3:
          _icon_ImageV.image = [UIImage imageNamed:@"btn_zhuxiaozh"];
          _name_label.text = @"注销账号";
          break;
          case 4:
          _icon_ImageV.image = [UIImage imageNamed:@"btn_guanyuwm"];
          _name_label.text = @"关于我们";
          _down_line.hidden = YES;
          break;
              
          default:
              break;
      }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
