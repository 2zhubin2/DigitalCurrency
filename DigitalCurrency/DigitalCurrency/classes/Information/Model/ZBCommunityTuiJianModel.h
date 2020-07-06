//
//  ZBCommunityTuiJianModel.h
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/6.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBCommunityTuiJianUserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZBCommunityTuiJianModel : NSObject

@property (nonatomic ,strong)NSString *content;
@property (nonatomic ,strong)NSString *picture;
@property (nonatomic ,strong)NSString *publishTime;
@property (nonatomic ,retain)NSString *zanCount;
@property (nonatomic ,strong)NSString *commentCount;
@property (nonatomic ,strong)NSString *browserCount;
@property (nonatomic ,strong)NSString *forwardCount;
@property (nonatomic ,strong)NSString *talkId;
@property (nonatomic ,strong)NSString *userId;
@property(nonatomic,strong)ZBCommunityTuiJianUserModel *user;


@end

NS_ASSUME_NONNULL_END
