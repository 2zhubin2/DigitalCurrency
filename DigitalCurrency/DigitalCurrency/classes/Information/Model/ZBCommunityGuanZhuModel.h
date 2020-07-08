//
//  ZBCommunityGuanZhuModel.h
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/8.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBCommunityGuanZhuModel : NSObject


@property (strong, nonatomic) NSNumber *fansCount;
@property (strong, nonatomic) NSNumber *followCount;
@property (strong, nonatomic) NSNumber *talkCount;
@property (strong, nonatomic) NSNumber *userID;
@property (copy, nonatomic) NSString *head;
@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *phone;
@property (copy, nonatomic) NSString *password;
@property (copy, nonatomic) NSString *signature;
@property (copy, nonatomic) NSString *uuid;
@property (strong, nonatomic) NSNumber *type;

@end

NS_ASSUME_NONNULL_END
