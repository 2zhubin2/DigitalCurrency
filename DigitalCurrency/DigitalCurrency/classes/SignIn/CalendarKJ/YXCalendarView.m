//
//  AppDelegate.m
//  日历自写2020.07.03
//
//  Created by 朱彬 on 2020/7/3.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "YXCalendarView.h"
#import <sys/utsname.h>

static CGFloat const yearMonthH = 20;   //年月高度
static CGFloat const weeksH = 20;       //周高度
#define ViewW self.frame.size.width     //当前视图宽度
#define ViewH self.frame.size.height    //当前视图高度

@interface YXCalendarView ()

@property (nonatomic, strong) UILabel *yearMonthL;      //年月label
@property (nonatomic, strong) UIScrollView *scrollV;    //scrollview
@property (nonatomic, assign) CalendarType type;        //选择类型
@property (nonatomic, strong) NSDate *currentDate;      //当前月份
@property (nonatomic, strong) NSDate *selectDate;       //选中日期
@property (nonatomic, strong) NSDate *tmpCurrentDate;   //记录上下滑动日期

@property (nonatomic, strong) YXMonthView *leftView;    //左侧日历
@property (nonatomic, strong) YXMonthView *middleView;  //中间日历
@property (nonatomic, strong) YXMonthView *rightView;   //右侧日历

@end

@implementation YXCalendarView

- (instancetype)initWithFrame:(CGRect)frame Date:(NSDate *)date Type:(CalendarType)type {
    
    if (self = [super initWithFrame:frame]) {
        _type = type;
        _currentDate = date;
        _selectDate = date;
        if (type == CalendarType_Week) {
            _tmpCurrentDate = date;
            _currentDate = [[YXDateHelpObject manager] getLastdayOfTheWeek:date];
        }
        [self settingViews];
//        [self addSwipes];
    }
    return self;
}

- (instancetype)initWithDate:(NSDate *)date Type:(CalendarType)type {
    
    if (self = [super init]) {
        _type = type;
        _currentDate = date;
        _selectDate = date;
        if (type == CalendarType_Week) {
            _tmpCurrentDate = date;
            _currentDate = [[YXDateHelpObject manager] getLastdayOfTheWeek:date];
        }
        [self settingViews];
//        [self addSwipes];
    }
    return self;
}

- (void)dealloc
{
    [_scrollV removeObserver:self forKeyPath:@"contentOffset"];
}

//MARK: - setMethod

-(void)setType:(CalendarType)type {
    _type = type;
    
    _middleView.type = type;
    _leftView.type = type;
    _rightView.type = type;
    
    if (type == CalendarType_Week) {
        //周
        if (_refreshH) {
            if (ViewH == dayCellH + yearMonthH + weeksH) {
                return;
            }
            _refreshH(dayCellH + yearMonthH + weeksH);
            __weak typeof(_scrollV) weakScroll = _scrollV;
            [UIView animateWithDuration:0.3 animations:^{
                weakScroll.frame = CGRectMake(0, yearMonthH + weeksH, ViewW, dayCellH);
            }];
            
        }
    } else {
        //月
        if (_refreshH) {
            CGFloat viewH = [YXCalendarView getMonthTotalHeight:_currentDate type:CalendarType_Month];
            if (viewH == ViewH) {
                return;
            }
            _refreshH(viewH);
            __weak typeof(_scrollV) weakScroll = _scrollV;
            [UIView animateWithDuration:0.3 animations:^{
                weakScroll.frame = CGRectMake(0, yearMonthH + weeksH, ViewW, viewH - yearMonthH - weeksH);
            }];
        }
    }
    
}

//MARK: - otherMethod
+ (CGFloat)getMonthTotalHeight:(NSDate *)date type:(CalendarType)type {
    if (type == CalendarType_Week) {
        return yearMonthH + weeksH + dayCellH;
    } else {
        NSInteger rows = [[YXDateHelpObject manager] getRows:date];
        return yearMonthH + weeksH + rows * dayCellH;
    }
    
}

- (void)slideView:(UISwipeGestureRecognizer *)sender {
    
    if (sender.direction == UISwipeGestureRecognizerDirectionUp) {
        _tmpCurrentDate = _currentDate.copy;
        //上滑
        if (_type == CalendarType_Week) {
            return;
        }
        if (_selectDate && [[YXDateHelpObject manager] checkSameMonth:_selectDate AnotherMonth:_currentDate]) {
            _currentDate = [[YXDateHelpObject manager] getLastdayOfTheWeek:_selectDate];
            _middleView.currentDate = _currentDate;
            _leftView.currentDate = [[YXDateHelpObject manager]getEarlyOrLaterDate:_currentDate LeadTime:-7 Type:2];
            _rightView.currentDate = [[YXDateHelpObject manager]getEarlyOrLaterDate:_currentDate LeadTime:7 Type:2];
        } else {
            //默认第一周
            _currentDate = [[YXDateHelpObject manager] getLastdayOfTheWeek:[[YXDateHelpObject manager] GetFirstDayOfMonth:_currentDate]];
            _middleView.currentDate = _currentDate;
            _leftView.currentDate = [[YXDateHelpObject manager]getEarlyOrLaterDate:_currentDate LeadTime:-7 Type:2];
            _rightView.currentDate = [[YXDateHelpObject manager]getEarlyOrLaterDate:_currentDate LeadTime:7 Type:2];
            
        }
        self.type = CalendarType_Week;
    } else if (sender.direction == UISwipeGestureRecognizerDirectionDown) {
        //下滑
        if (_type == CalendarType_Month) {
            return;
        }
        //选中最后一行再上滑需要这个判断
        if (![[YXDateHelpObject manager] checkSameMonth:_tmpCurrentDate AnotherMonth:_currentDate]) {
            _currentDate = _tmpCurrentDate.copy;
        }
        _type = CalendarType_Month;
        [self setData];
        [self scrollToCenter];
    }
    
}

//MARK: - setViewMethod

- (void)addSwipes {
    
    UISwipeGestureRecognizer *swipUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideView:)];
    [swipUp setDirection:UISwipeGestureRecognizerDirectionUp];
    [self addGestureRecognizer:swipUp];
    
    UISwipeGestureRecognizer *swipDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideView:)];
    [swipDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [self addGestureRecognizer:swipDown];
    
}

- (void)settingViews {
    [self settingHeadLabel];
    [self settingScrollView];
    [self addObserver];
}

- (void)settingHeadLabel {
    
    _yearMonthL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ViewW, yearMonthH)];
//    _yearMonthL.text = [[YXDateHelpObject manager] getStrFromDateFormat:@"yyyy年MM月" Date:_currentDate];
    _yearMonthL.text = [[YXDateHelpObject manager] getStrFromDateFormat:@"yyyy.MM" Date:_currentDate];

    _yearMonthL.textAlignment = NSTextAlignmentCenter;
//     _yearMonthL.textAlignment = NSTextAlignmentLeft;
    _yearMonthL.font = [UIFont systemFontOfSize:15];
    [self addSubview:_yearMonthL];
    
    NSArray *weekdays = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    CGFloat weekdayW = ViewW/7;
    for (int i = 0; i < 7; i++) {
        UILabel *weekL = [[UILabel alloc] initWithFrame:CGRectMake(i*weekdayW, yearMonthH, weekdayW, weeksH)];
        weekL.textAlignment = NSTextAlignmentCenter;
        weekL.font = [UIFont systemFontOfSize:15];
        weekL.text = weekdays[i];
        [self addSubview:weekL];
    }
    
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, yearMonthH, ViewW, 1)];
//    line.backgroundColor = [UIColor lightGrayColor];
//    line.alpha = 0.3;
//    [self addSubview:line];
    
}

- (void)settingScrollView {
    
    _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, yearMonthH + weeksH, ViewW, ViewH - yearMonthH - weeksH)];
    _scrollV.contentSize = CGSizeMake(ViewW * 3, 0);
    _scrollV.pagingEnabled = YES;
    _scrollV.showsHorizontalScrollIndicator = NO;
    _scrollV.showsVerticalScrollIndicator = NO;
    [self addSubview:_scrollV];
    
    __weak typeof(self) weakSelf = self;
    CGFloat height = 6 * dayCellH;
    _leftView = [[YXMonthView alloc] initWithFrame:CGRectMake(0, 0, ViewW, height) Date:
                 _type == CalendarType_Month ? [[YXDateHelpObject manager] getPreviousMonth:_currentDate] :[[YXDateHelpObject manager]getEarlyOrLaterDate:_currentDate LeadTime:-7 Type:2]];
    _leftView.type = _type;
    _leftView.selectDate = _selectDate;
    
    _middleView = [[YXMonthView alloc] initWithFrame:CGRectMake(ViewW, 0, ViewW, height) Date:_currentDate];
    _middleView.type = _type;
    _middleView.selectDate = _selectDate;
    _middleView.sendSelectDate = ^(NSDate *selDate) {
        weakSelf.selectDate = selDate;
        if (weakSelf.sendSelectDate) {
            weakSelf.sendSelectDate(selDate);
        }
        [weakSelf setData];
    };
    
    _rightView = [[YXMonthView alloc] initWithFrame:CGRectMake(ViewW * 2, 0, ViewW, height) Date:
                  _type == CalendarType_Month ? [[YXDateHelpObject manager] getNextMonth:_currentDate] : [[YXDateHelpObject manager]getEarlyOrLaterDate:_currentDate LeadTime:7 Type:2]];
    _rightView.type = _type;
    _rightView.selectDate = _selectDate;
    
    [_scrollV addSubview:_leftView];
    [_scrollV addSubview:_middleView];
    [_scrollV addSubview:_rightView];
    
    [self scrollToCenter];
}

- (void)setData {
    
    _middleView.currentDate = _currentDate;
    if (_type == CalendarType_Month) {
        _leftView.currentDate = [[YXDateHelpObject manager] getPreviousMonth:_currentDate];
        _rightView.currentDate = [[YXDateHelpObject manager] getNextMonth:_currentDate];
    } else {
        _leftView.currentDate = [[YXDateHelpObject manager] getEarlyOrLaterDate:_currentDate LeadTime:-7 Type:2];
        _rightView.currentDate = [[YXDateHelpObject manager] getEarlyOrLaterDate:_currentDate LeadTime:7 Type:2];
    }
    _middleView.selectDate = _selectDate;
    _leftView.selectDate = _selectDate;
    _rightView.selectDate = _selectDate;
    
    
    self.type = _type;
    
}

//MARK: - kvo
- (void)addObserver {
    [_scrollV addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self monitorScroll];
    }
    
}

- (void)monitorScroll {
    
    if (_scrollV.contentOffset.x > 2*ViewW -1) {
        
        _leftView.currentDate = _currentDate;
        if (_type == CalendarType_Month) {
            //左滑,下个月
            _middleView.currentDate = [[YXDateHelpObject manager] getNextMonth:_currentDate];
            _currentDate = [[YXDateHelpObject manager] getNextMonth:_currentDate];
            _rightView.currentDate = [[YXDateHelpObject manager] getNextMonth:_currentDate];
            _yearMonthL.text = [[YXDateHelpObject manager] getStrFromDateFormat:@"yyyy.MM" Date:_currentDate];
        } else {
            //下周
            _middleView.currentDate = [[YXDateHelpObject manager] getEarlyOrLaterDate:_currentDate LeadTime:7 Type:2];
            _currentDate = [[YXDateHelpObject manager] getEarlyOrLaterDate:_currentDate LeadTime:7 Type:2];
            _tmpCurrentDate = _currentDate.copy;
            _rightView.currentDate = [[YXDateHelpObject manager] getEarlyOrLaterDate:_currentDate LeadTime:7 Type:2];
            _yearMonthL.text = [[YXDateHelpObject manager] getStrFromDateFormat:@"yyyy.MM" Date:_currentDate];
        }
        _rightView.selectDate = _selectDate;
        _leftView.selectDate = _selectDate;
        _middleView.selectDate = _selectDate;
        
        [self scrollToCenter];
        self.type = _type;
        
    } else if (_scrollV.contentOffset.x < 1) {
        
        _rightView.currentDate = _currentDate;
        if (_type == CalendarType_Month) {
            //右滑,上个月
            _middleView.currentDate = [[YXDateHelpObject manager] getPreviousMonth:_currentDate];
            _currentDate = [[YXDateHelpObject manager] getPreviousMonth:_currentDate];
            _leftView.currentDate = [[YXDateHelpObject manager] getPreviousMonth:_currentDate];
            _yearMonthL.text = [[YXDateHelpObject manager] getStrFromDateFormat:@"yyyy年MM月" Date:_currentDate];
        } else {
            //上周
            _middleView.currentDate = [[YXDateHelpObject manager] getEarlyOrLaterDate:_currentDate LeadTime:-7 Type:2];
            _currentDate = [[YXDateHelpObject manager] getEarlyOrLaterDate:_currentDate LeadTime:-7 Type:2];
            _tmpCurrentDate = _currentDate.copy;
            _leftView.currentDate = [[YXDateHelpObject manager] getEarlyOrLaterDate:_currentDate LeadTime:-7 Type:2];
            _yearMonthL.text = [[YXDateHelpObject manager] getStrFromDateFormat:@"yyyy年MM月" Date:_currentDate];
        }
        _rightView.selectDate = _selectDate;
        _leftView.selectDate = _selectDate;
        _middleView.selectDate = _selectDate;
        
        [self scrollToCenter];
        self.type = _type;
        
    }
    
}

//MARK: - scrollViewMethod
- (void)scrollToCenter {
    _scrollV.contentOffset = CGPointMake(ViewW, 0);

    //可以在这边进行网络请求获取事件日期数组等,记得取消上个未完成的网络请求
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
//        NSString *dateStr = [NSString stringWithFormat:@"%@-%d",[[YXDateHelpObject manager] getStrFromDateFormat:@"MM" Date:_currentDate],1 + arc4random()%28];
//        NSString *dateStr = [NSString stringWithFormat:@"2020-07-0%d",i];
         NSString *dateStr = [NSString stringWithFormat:@"%@-%d",[[YXDateHelpObject manager] getStrFromDateFormat:@"MM" Date:_currentDate],12+i];

        [array addObject:dateStr];
    }

    _middleView.eventArray = array;
    
    

}


-(NSString *)curYearMD{
    
    
    //获取当前时间日期
          NSDate *date=[NSDate date];
          NSDateFormatter *format1=[[NSDateFormatter alloc] init];
          [format1 setDateFormat:@"yyyy-MM-dd"];
          NSString *dateStr;
          dateStr=[format1 stringFromDate:date];
          return dateStr;
}


-(NSString *)timetampTostring:(NSInteger)timestamp{
    
    NSString *tempTime =[[NSNumber numberWithLong:timestamp] stringValue];
    NSMutableString *getTime = [NSMutableString stringWithFormat:@"%@",tempTime];

      //    NSMutableString *getTime = @"1461896616000";
     struct utsname systemInfo;
     uname(&systemInfo);

     [getTime deleteCharactersInRange:NSMakeRange(10,3)];
     NSDateFormatter *matter = [[NSDateFormatter alloc]init];
//    matter.dateFormat =@"YYYY-MM-dd HH:mm";
    matter.dateFormat =@"YYYY-MM-dd";
    //解决时区问题
    matter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[getTime intValue]];

      NSString *timeStr = [matter stringFromDate:date];
//    NSArray *array1 =[timeStr componentsSeparatedByString:@"-"];

    return timeStr;
}
@end
