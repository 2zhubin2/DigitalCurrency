//
//  AppDelegate.m
//  日历自写2020.07.03
//
//  Created by 朱彬 on 2020/7/3.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "YXDayCell.h"

@interface YXDayCell ()

@property (weak, nonatomic) IBOutlet UILabel *dayL;     //日期
@property (weak, nonatomic) IBOutlet UIView *pointV;    //点

@end

@implementation YXDayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _dayL.layer.cornerRadius = dayCellH / 2;
    _pointV.layer.cornerRadius = (dayCellH - 4)/2;
    
}

//MARK: - setmethod

- (void)setCellDate:(NSDate *)cellDate {
    _cellDate = cellDate;
    if (_type == CalendarType_Week) {
        [self showDateFunction];
    } else {
        if ([[YXDateHelpObject manager] checkSameMonth:_cellDate AnotherMonth:_currentDate]) {
            [self showDateFunction];
        } else {
            [self showSpaceFunction];
        }
    }
    
}

//MARK: - otherMethod

- (void)showSpaceFunction {
    self.userInteractionEnabled = NO;
    _dayL.text = @"";
    _dayL.backgroundColor = [UIColor clearColor];
    _dayL.layer.borderWidth = 0;
    _dayL.layer.borderColor = [UIColor clearColor].CGColor;
    _pointV.hidden = YES;
    _dayL.textColor =  [UIColor colorWithRed:50/255.0 green:83/255.0 blue:250/255.0 alpha:1.0];
}

- (void)showDateFunction {
    
    self.userInteractionEnabled = YES;
    
    _dayL.text = [[YXDateHelpObject manager] getStrFromDateFormat:@"d" Date:_cellDate];
    if ([[YXDateHelpObject manager] isSameDate:_cellDate AnotherDate:[NSDate date]]) {
        _dayL.layer.borderWidth = 0.5;
        _dayL.layer.borderColor = [UIColor grayColor].CGColor;
    } else {
        _dayL.layer.borderWidth = 0;
        _dayL.layer.borderColor = [UIColor clearColor].CGColor;
    }
    if (_selectDate) {
        
        if ([[YXDateHelpObject manager] isSameDate:_cellDate AnotherDate:_selectDate]) {
            _dayL.backgroundColor = [UIColor colorWithRed:50/255.0 green:83/255.0 blue:250/255.0 alpha:1.0];
          
            _dayL.textColor = [UIColor whiteColor];
            _pointV.backgroundColor = [UIColor whiteColor];
        } else {
            _dayL.backgroundColor = [UIColor clearColor];
            _dayL.textColor = [UIColor blackColor];
          
            _pointV.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        }
        
    }
    NSString *currentDate = [[YXDateHelpObject manager] getStrFromDateFormat:@"MM-dd" Date:_cellDate];
    _pointV.hidden = YES;
    if (_eventArray.count) {
        for (NSString *strDate in _eventArray) {
            if ([strDate isEqualToString:currentDate]) {
                _pointV.hidden = NO;
                _dayL.textColor = [UIColor whiteColor];
            }
        }
    }
    
}

@end
