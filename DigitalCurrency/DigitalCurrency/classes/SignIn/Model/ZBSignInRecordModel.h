//
//  ZBSignInRecordModel.h
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/7.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBSignInRecordModel : NSObject


@property(nonatomic,copy)NSString *continueTimes;
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *time;

@end

NS_ASSUME_NONNULL_END
