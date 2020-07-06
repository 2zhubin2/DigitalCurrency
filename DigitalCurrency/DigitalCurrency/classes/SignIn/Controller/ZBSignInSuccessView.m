//
//  ZBSignInSuccessView.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/6.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBSignInSuccessView.h"

@implementation ZBSignInSuccessView

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
        return [[NSBundle mainBundle] loadNibNamed:@"ZBSignInSuccessView" owner:nil options:nil].lastObject;
    }
    return self;
}
- (IBAction)tuichuClick:(UIButton *)sender {
    [self removeFromSuperview];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     [self removeFromSuperview];
}

@end
