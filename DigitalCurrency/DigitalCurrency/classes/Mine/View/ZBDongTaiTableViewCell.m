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

@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UIButton *head_btn;
@property (strong, nonatomic) IBOutlet UILabel *nickName;
@property (strong, nonatomic) IBOutlet UILabel *time_label;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@property (strong, nonatomic) IBOutlet UIImageView *image_View;
@property (strong, nonatomic) IBOutlet UILabel *zanCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *commentCountLabel;

@end

@implementation ZBDongTaiTableViewCell


- (void)setModel:(ZBDongTaiModel *)model{
    _model = model;
    
    if (![model.user.head containsString:@"<html>"] && model.user.head.length != 0) {
//        [_head_btn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.user.head] forState:UIControlStateNormal];
        [_head_btn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.user.head] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
    }
   
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _nickName.text = appDelegate.mineUserInfoModel.nickName;
    _time_label.text = [self timetampTostring:model.publishTime.integerValue];
    _contentLabel.text = model.content;
    _zanCountLabel.text = model.zanCount.stringValue;
    _commentCountLabel.text = model.commentCount.stringValue;
    if (self.model.picture.length == 0 || [self.model.picture containsString:@"<html>"]) {
//       _image_View.image = [UIImage imageNamed:@"pic_dongtai1"];
        _view_imageSuperH.constant = 0 ;
       }else{
        [_image_View sd_setImageWithURL:[NSURL URLWithString:self.model.picture]];//pic_dongtai1
           [_image_View sd_setImageWithURL:[NSURL URLWithString:self.model.picture] placeholderImage:[UIImage imageNamed:@"pic_dongtai1"]];
           
       }
      
       _image_View.contentMode = UIViewContentModeScaleToFill;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    [self setupImageView];
    
//    if (_view_imageSuper.subviews.count == 0) {
//        _view_imageSuperH.constant = 1;
//    }
    _head_btn.layer.cornerRadius = 30;
    _head_btn.clipsToBounds = YES;
    [self setupShadowColor];
    [_contentLabel setValue:@(20) forKey:@"lineSpacing"];
    
    
}

-(void)setupShadowColor{
    

    _bgView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.32].CGColor;
    _bgView.layer.shadowOffset = CGSizeMake(2,2);
    _bgView.layer.shadowOpacity = 1;
    _bgView.layer.shadowRadius = 5;
    _bgView.layer.cornerRadius = 5;
}

-(void)setupImageView{
//    if (self.model.picture.length == 0) {
//    _image_View.image = [UIImage imageNamed:@"pic_dongtai1"];
//    }
//    [_image_View sd_setImageWithURL:[NSURL URLWithString:self.model.picture]];
//    _image_View.contentMode = UIViewContentModeScaleToFill;
//    [self.view_imageSuper addSubview:_image_View];
//    [_image_View mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view_imageSuper.mas_top);
//        make.left.equalTo(self.view_imageSuper.mas_left);
//        make.bottom.equalTo(self.view_imageSuper.mas_bottom);
//        make.right.equalTo(self.view_imageSuper.mas_right);
//    }];
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
