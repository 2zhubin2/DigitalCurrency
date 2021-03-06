//
//  ZBNewInformationTableViewCell.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/1.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBNewInformationTableViewCell.h"
#import <sys/utsname.h>

@interface ZBNewInformationTableViewCell ()

@property (strong, nonatomic) IBOutlet UIView *bg_view;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@property (strong, nonatomic) IBOutlet UILabel *time_label;
@property (strong, nonatomic) IBOutlet UILabel *log_label;
@property (strong, nonatomic) IBOutlet UIImageView *image_v_head;

@end

@implementation ZBNewInformationTableViewCell

- (void)setModel:(ZBNewInformationModel *)model{
    
    _model = model;
    _contentLabel.text = model.content;
//    _time_label.text = [self timetampTostring:model.time.intValue];
    _time_label.text = [NSString stringWithFormat:@"%@",[self timetampTostring:model.time.integerValue]];
//    _log_label.text = [NSString stringWithFormat:@"%@",self.log_title];
    if (self.typeFlag == YES) {
        _log_label.text = @"热点资讯";
    }else{
        _log_label.text = @"精选好文";
    }
    
    
}

- (void)setRow_num:(NSInteger)row_num{
    _row_num = row_num;
    switch (self.row_num%4) {
        case 0:
            _image_v_head.image = [UIImage imageNamed:@"pic_zx1"];
            break;
        case 1:
            _image_v_head.image = [UIImage imageNamed:@"pic_zx2"];
        break;
        case 2:
            _image_v_head.image = [UIImage imageNamed:@"pic_zx3"];
        break;
        case 3:
            _image_v_head.image = [UIImage imageNamed:@"pic_zx4"];
        break;
        default:
            break;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupshadowColor];
     
    [_contentLabel setValue:@(23) forKey:@"lineSpacing"];
  
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
