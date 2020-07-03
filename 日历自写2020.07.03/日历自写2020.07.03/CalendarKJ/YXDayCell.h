//
//  AppDelegate.m
//  日历自写2020.07.03
//
//  Created by 朱彬 on 2020/7/3.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXDateHelpObject.h"

static CGFloat const dayCellH = 40;//日期cell高度

typedef enum : NSUInteger {
    CalendarType_Week,
    CalendarType_Month,
} CalendarType;

@interface YXDayCell : UICollectionViewCell

@property (nonatomic, strong) NSDate *currentDate;  //当月或当周日期
@property (nonatomic, strong) NSDate *selectDate;   //选择日期
@property (nonatomic, strong) NSDate *cellDate;     //cell显示日期
@property (nonatomic, assign) CalendarType type;    //选择类型
@property (nonatomic, strong) NSArray *eventArray;  //事件数组

@end
