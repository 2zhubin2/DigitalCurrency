//
//  ViewController.m
//  日历自写2020.07.03
//
//  Created by 朱彬 on 2020/7/3.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ViewController.h"
#import "YXCalendarView.h"

@interface ViewController ()

@property(nonatomic,strong)YXCalendarView *calendar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor greenColor];
    
    _calendar = [[YXCalendarView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [YXCalendarView getMonthTotalHeight:[NSDate date] type:CalendarType_Month]) Date:[NSDate date] Type:CalendarType_Month];
       __weak typeof(_calendar) weakCalendar = _calendar;
       _calendar.refreshH = ^(CGFloat viewH) {
           [UIView animateWithDuration:0.3 animations:^{
               weakCalendar.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, viewH);
           }];
           
       };
       _calendar.sendSelectDate = ^(NSDate *selDate) {
           NSLog(@"%@",[[YXDateHelpObject manager] getStrFromDateFormat:@"yyyy-MM-dd" Date:selDate]);
       };
       [self.view addSubview:_calendar];
}


@end
