//
//  ZBHomeTableViewModel.h
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/4.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBHomeTableViewModel : NSObject

@property(nonatomic,copy)NSString  *name;
@property(nonatomic,copy)NSString  *upPercent;
@property(nonatomic,copy)NSString  *price;
@property(nonatomic,copy)NSString  *upOrDownPercent;

@end

NS_ASSUME_NONNULL_END
