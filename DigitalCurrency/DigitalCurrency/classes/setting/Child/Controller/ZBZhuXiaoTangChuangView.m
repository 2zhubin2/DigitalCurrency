//
//  ZBZhuXiaoTangChuangView.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/6.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBZhuXiaoTangChuangView.h"

@implementation ZBZhuXiaoTangChuangView

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
        return [[NSBundle mainBundle] loadNibNamed:@"ZBZhuXiaoTangChuangView" owner:nil options:nil].lastObject;
    }
    return self;
}
- (IBAction)clickBack:(UIButton *)sender {
    
    [self removeFromSuperview];
}
- (IBAction)clickQueRen:(UIButton *)sender {
    
    [self removeFromSuperview];
}

@end
