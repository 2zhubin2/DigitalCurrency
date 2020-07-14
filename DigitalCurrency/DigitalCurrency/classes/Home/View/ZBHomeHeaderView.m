//
//  ZBHomeHeaderView.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/14.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBHomeHeaderView.h"

@implementation ZBHomeHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //加载Xib
        return [[NSBundle mainBundle] loadNibNamed:@"ZBHomeHeaderView" owner:nil options:nil].lastObject;
    }
    return self;
}

- (IBAction)clickbanner:(id)sender {
//    self.navigationController.tabBarController.selectedIndex = 1;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"clickbanner" object:nil];
}

- (IBAction)clickJianxun:(id)sender {
//    self.navigationController.tabBarController.selectedIndex = 3;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"clickJianxun" object:nil];
}

@end
