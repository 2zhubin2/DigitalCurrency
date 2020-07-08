//
//  ZBIndustryStormTableViewCell.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/1.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBIndustryStormTableViewCell.h"
#import <sys/utsname.h>

@interface ZBIndustryStormTableViewCell ()

@property (strong, nonatomic) IBOutlet UIView *bg_view;

@property (strong, nonatomic) IBOutlet UILabel *content_label;
@property (strong, nonatomic) IBOutlet UILabel *time_label;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *head_label;

@end

@implementation ZBIndustryStormTableViewCell

- (void)setModel:(ZBIndustryStormModel *)model{
    
    _model = model;
    _content_label.text = model.content;
    
    _time_label.text = [NSString stringWithFormat:@"%@",[self timetampTostring:model.time.integerValue]];
    
    _titleLabel.text = @"";
    
}

  //各个cell间距值为10
//- (void)setFrame:(CGRect)frame{
//    frame.size.height -= 10;
//    frame.origin.y += 10;
//    //重写覆盖frame
//    [super setFrame:frame];
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupshadowColor];
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
