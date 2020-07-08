//
//  AppDelegate.m
//  日历自写2020.07.03
//
//  Created by 朱彬 on 2020/7/3.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXMonthView.h"

typedef void(^RefreshH)(CGFloat viewH);

@interface YXCalendarView : UIView

@property (nonatomic, copy) SendSelectDate sendSelectDate;  //回传选择日期

/**
 实现该block滑动时更新控件高度
 */
@property (nonatomic, copy) RefreshH refreshH;

/**
 根据日期获取控件总高度
 
 @param date 日期
 @param type 类型
 @return return value description
 */
+ (CGFloat)getMonthTotalHeight:(NSDate *)date type:(CalendarType)type;

/**
 初始化方法
 
 @param frame 控件尺寸,高度可以调用该类计算方法计算
 @param date 日期
 @param type 类型
 @return return value description
 */
- (instancetype)initWithFrame:(CGRect)frame Date:(NSDate *)date Type:(CalendarType)type;
- (instancetype)initWithDate:(NSDate *)date Type:(CalendarType)type;



-(void)SingInSuccess;

@end
