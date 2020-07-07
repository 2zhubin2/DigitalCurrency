//
//  ZBMineUserInfoModel.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/6.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBMineUserInfoModel.h"

@implementation ZBMineUserInfoModel

+(NSDictionary*)mj_replacedKeyFromPropertyName{
    return @{@"userID":@"id"};
}

@end
