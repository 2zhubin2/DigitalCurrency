//
//  ZBcommentTalkModel.h
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/6.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBcommentTalkModel : NSObject

@property (nonatomic, strong) NSString *browserCount;
@property (nonatomic, strong) NSString *commentCount;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *displayBig;
@property (nonatomic, strong) NSString *enable;
@property (nonatomic, strong) NSNumber *forwardCount;
@property (nonatomic, strong) NSNumber *hasZan;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSString *publishTime;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSNumber *videoId;
@property (nonatomic, strong) NSNumber *zanCount;

@end

NS_ASSUME_NONNULL_END
