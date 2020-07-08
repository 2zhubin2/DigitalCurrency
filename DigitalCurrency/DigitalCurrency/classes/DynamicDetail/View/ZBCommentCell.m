//
//  ZBCommentCell.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/3.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBCommentCell.h"

@interface ZBCommentCell ()

@property (strong, nonatomic) IBOutlet UIButton *head_btn;

@property (strong, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *zancountLabel;
@property (strong, nonatomic) IBOutlet UILabel *conentLabel;
//@property(nonatomic,strong)UIImageView *image_view;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageV_bgH;
//@property (strong, nonatomic) IBOutlet UIView *image_bgV;
@property (strong, nonatomic) IBOutlet UIImageView *image_view;

@end

@implementation ZBCommentCell

- (void)setModel:(ZBcommmentModel *)model{
    _model = model;
    if (model.user.head.length != 0 && ![model.user.head containsString:@"<html>"]) {
//        [self.head_btn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.user.head] forState:UIControlStateNormal];
//        [self.head_btn sd_setImageWithURL:[NSURL URLWithString:model.user.head] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
        [self.head_btn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.user.head] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
    }
    
    _nickNameLabel.text = model.user.nickName;
    _timeLabel.text = [self timetampTostring:model.publishTime.integerValue];
    _zancountLabel.text = model.talk.zanCount.stringValue;
    _conentLabel.text = model.content;
    // model.talk.picture
    if (model.talk.picture.length >= 1) {
        [_image_view sd_setImageWithURL:[NSURL URLWithString:model.talk.picture]];
        _image_view.contentMode = UIViewContentModeScaleToFill;
//        [self.image_bgV addSubview:self.image_view];
//        [self.image_view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.image_bgV);
//            make.left.equalTo(self.image_bgV);
//            make.bottom.equalTo(self.image_bgV);
//            make.right.equalTo(self.image_bgV);
//        }];
    }else{
        self.imageV_bgH = 0;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _head_btn.layer.cornerRadius = 20;
    _head_btn.clipsToBounds = YES;
    
    // Initialization code
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
