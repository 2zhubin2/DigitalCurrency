//
//  ZBcommmentModel.h
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/6.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "userModel.h"
#import "ZBcommentTalkModel.h"


NS_ASSUME_NONNULL_BEGIN



@interface ZBcommmentModel : NSObject

@property (nonatomic, strong) NSString *content;
//@property (nonatomic, strong) NSString *gameVideo;
//@property (nonatomic, strong) NSString *talkId;
//@property (nonatomic, strong) NSNumber *matchId;
//@property (nonatomic, strong) NSString *matchInfo;
@property (nonatomic, strong) NSString *publishTime;
@property (nonatomic, strong) NSNumber *talkId;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic,strong) ZBcommentTalkModel *talk;
@property (nonatomic, strong) userModel *user;
//@property (nonatomic, strong) NSNumber *videoId;
@end

@interface talkModel : NSObject

@end



NS_ASSUME_NONNULL_END
