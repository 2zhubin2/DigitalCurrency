//
//  ZBCommentHeaderCell.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/3.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBCommentHeaderCell.h"
#import "ZBForwardViewController.h"

@interface ZBCommentHeaderCell ()

@property (strong, nonatomic) IBOutlet UIView *view_imagebg;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *view_imagebgH;
@property (strong, nonatomic) IBOutlet UILabel *nickName_label;
@property (strong, nonatomic) IBOutlet UILabel *time_label;
@property (strong, nonatomic) IBOutlet UILabel *content_label;
@property (strong, nonatomic) IBOutlet UILabel *zanCount_labal;
@property (strong, nonatomic) IBOutlet UILabel *browserCount_label;
@property (strong, nonatomic) IBOutlet UIButton *head_btn;

@property(nonatomic,weak)UIImageView *iamge_view;
@property (strong, nonatomic) IBOutlet UIButton *guanzhuBtn;

@end


@implementation ZBCommentHeaderCell

- (void)setModel:(ZBCommunityTuiJianModel *)model{
    _model = model;
    /*
     [self.head_iamgeV sd_setBackgroundImageWithURL:[NSURL URLWithString:model.user.head] forState:UIControlStateNormal];
      _nickName_label.text = model.user.nickName;
      _time_label.text = [self timetampTostring:model.publishTime.integerValue];
      _contentLabel.text = model.content;
      if (model.picture.length == 0) {
          _view_imagebgH.constant = 1;
      }else{
          [self.image_V sd_setImageWithURL:[NSURL URLWithString:model.picture]];
      }
     
      _zanCount_label.text = model.zanCount;
      _commentCount_label.text = model.commentCount;
     */
    
    if (![model.user.head containsString:@"<html>"] && model.user.head.length != 0 ) {
        [self.head_btn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.user.head] forState:UIControlStateNormal];
    }
   
    _nickName_label.text = model.user.nickName;
    _time_label.text = [self timetampTostring:model.publishTime.integerValue];
    _content_label.text = model.content;
    if (model.picture.length == 0 || [model.picture containsString:@"<html>"]) {
        _view_imagebgH.constant = 1;
    }else{
        [self.iamge_view sd_setImageWithURL:[NSURL URLWithString:model.picture]];
    }
    _zanCount_labal.text = [NSString stringWithFormat:@"等%ld人点赞",model.zanCount.integerValue];
    _browserCount_label.text = [NSString stringWithFormat:@"浏览%ld人",model.browserCount.integerValue];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupImageView];
    self.head_btn.layer.cornerRadius = 30;
    self.head_btn.clipsToBounds = YES;
        
    if (_view_imagebg.subviews.count == 0) {
            _view_imagebgH.constant = 1;
        }
    self.guanzhuBtn.layer.cornerRadius = 14;
        
}

- (IBAction)ClickGuanZhu:(UIButton *)sender {
    sender.layer.cornerRadius = 14;
    sender.layer.borderColor = [UIColor colorWithRed:50/255.0 green:83/255.0 blue:250/255.0 alpha:1.0].CGColor;
    sender.layer.borderWidth = 1;
//    sender.backgroundColor = [UIColor whiteColor];
    [sender setBackgroundColor:[UIColor whiteColor]];
    [sender setTitle:@"已关注" forState:UIControlStateNormal];
    sender.enabled = NO;
}

- (IBAction)cilckFenXiang:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(CommentHeaderCellClickFenXiang:)]) {
        [self.delegate CommentHeaderCellClickFenXiang:self];
    }
    
    
}

-(void)setupImageView{
        UIImageView *imagview = [[UIImageView alloc] init];
//        imagview.image = [UIImage imageNamed:@"pic_dongtai1"];
    self.iamge_view = imagview;
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
