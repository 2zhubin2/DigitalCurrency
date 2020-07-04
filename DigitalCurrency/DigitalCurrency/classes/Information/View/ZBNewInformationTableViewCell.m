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

@end

@implementation ZBNewInformationTableViewCell

- (void)setModel:(ZBNewInformationModel *)model{
    
    _model = model;
    _contentLabel.text = model.content;
//    _time_label.text = [self timetampTostring:model.time.intValue];
    _time_label.text = [NSString stringWithFormat:@"%@",[self timetampTostring:model.time.integerValue]];
    _log_label.text = [NSString stringWithFormat:@"%ld",self.log_title.length];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupshadowColor];
     
    
    /*
     UIView *view = [[UIView alloc] init];
     view.frame = CGRectMake(15,257,345,91);
     view.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
     view.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.32].CGColor;
     view.layer.shadowOffset = CGSizeMake(2,2);
     view.layer.shadowOpacity = 1;
     view.layer.shadowRadius = 5;
     UIView *viewShadow1 = [[UIView alloc] init];
     viewShadow1.frame = CGRectMake(15,257,345,91);
     viewShadow1.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
     viewShadow1.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
     viewShadow1.layer.shadowOffset = CGSizeMake(-3, -3);
     viewShadow1.layer.shadowOpacity = 1;
     viewShadow1.layer.shadowRadius = 5;

     [self.view bringSubviewToFront:view];
     view.layer.cornerRadius = 5;
     */
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
