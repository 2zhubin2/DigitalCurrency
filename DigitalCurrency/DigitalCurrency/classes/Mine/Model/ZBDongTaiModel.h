//
//  ZBDongTaiModel.h
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/7.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBCommunityTuiJianUserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZBDongTaiModel : NSObject

/**说说id*/
@property (strong, nonatomic) NSNumber *talkID;
/**浏览次数*/
@property (strong, nonatomic) NSNumber *browserCount;
/**评论次数*/
@property (strong, nonatomic) NSNumber *commentCount;
/**点赞次数*/
@property (strong, nonatomic) NSNumber *zanCount;
/**正文*/
@property (copy, nonatomic) NSString *content;
/**图片地址*/
@property (copy, nonatomic) NSString *picture;
/**是否已点赞*/
@property (strong, nonatomic) NSNumber *hasZan;

@property (nonatomic ,strong)NSString *publishTime;
/**用户信息模型*/
@property(nonatomic,strong)ZBCommunityTuiJianUserModel *user;

@end

NS_ASSUME_NONNULL_END
