//
//  ZBCommunityTuiJianTableViewCell.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/1.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBCommunityTuiJianTableViewCell.h"
#import <sys/utsname.h>

@interface ZBCommunityTuiJianTableViewCell ()

@property (strong, nonatomic) IBOutlet UIView *bg_view;
@property (strong, nonatomic) IBOutlet UIView *view_imagebg;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *view_imagebgH;
@property (strong, nonatomic) IBOutlet UIButton *head_iamgeV;
@property (strong, nonatomic) IBOutlet UILabel *nickName_label;
@property (strong, nonatomic) IBOutlet UILabel *time_label;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@property (strong, nonatomic) IBOutlet UILabel *zanCount_label;
@property (strong, nonatomic) IBOutlet UILabel *commentCount_label;

@property(nonatomic,weak)UIImageView *image_V;

@end

@implementation ZBCommunityTuiJianTableViewCell

- (void)setModel:(ZBCommunityTuiJianModel *)model{
    _model = model;

    if (![model.user.head containsString:@"<html>"] && model.user.head.length != 0) {
           [self.head_iamgeV sd_setBackgroundImageWithURL:[NSURL URLWithString:model.user.head] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
        
       }
    
    
    _nickName_label.text = model.user.nickName;
    _time_label.text = [self timetampTostring:model.publishTime.integerValue];
    _contentLabel.text = model.content;
    if ([model.picture containsString:@"<html>"]  || model.picture.length == 0) {
        _view_imagebgH.constant = 0;
    }else{
        [self.image_V sd_setImageWithURL:[NSURL URLWithString:model.picture]];
        [self.image_V sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:[UIImage imageNamed:@"pic_dongtai1"]];
    }
   
    _zanCount_label.text = model.zanCount;
    _commentCount_label.text = model.commentCount;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupImageView];
    [self setupshadowColor];
    _head_iamgeV.layer.cornerRadius = 30;
    _head_iamgeV.clipsToBounds = YES;
    [_contentLabel setValue:@(23) forKey:@"lineSpacing"];
    
//    if (_view_imagebg.subviews.count == 0) {
//        _view_imagebgH.constant = 1;
//    }
    
}

-(void)setupImageView{
    UIImageView *imagview = [[UIImageView alloc] init];
    imagview.image = [UIImage imageNamed:@"pic_dongtai1"];
    _image_V = imagview;
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

-(NSString *)timetampTostring:(NSInteger)timestamp{
    
    NSString *tempTime =[[NSNumber numberWithLong:timestamp] stringValue];
    NSMutableString *getTime = [NSMutableString stringWithFormat:@"%@",tempTime];

      //    NSMutableString *getTime = @"1461896616000";
     struct utsname systemInfo;
     uname(&systemInfo);

     [getTime deleteCharactersInRange:NSMakeRange(10,3)];
     NSDateFormatter *matter = [[NSDateFormatter alloc]init];
    matter.dateFormat =@"YYYY-MM-dd HH:mm";
//    matter.dateFormat =@"YYYY-MM-dd";
    //解决时区问题
    matter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[getTime intValue]];

      NSString *timeStr = [matter stringFromDate:date];
//    NSArray *array1 =[timeStr componentsSeparatedByString:@"-"];

    return timeStr;
}


@end
