//
//  talkListModel.h
//  firstProject
//
//  Created by apple on 2020/6/5.
//  Copyright © 2020 ap. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface talkListModel : NSObject
@property (nonatomic, strong) NSNumber *currentPage;
@property (nonatomic, strong) NSNumber *hasMore;
@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic, strong) NSNumber *pageSize;
@property (nonatomic, strong) NSNumber *totalPage;
@property (nonatomic, strong) NSNumber *totalSize;
@end
@class userModel;
@class talkModel;
@interface ListModel : NSObject
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *gameVideo;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSNumber *matchId;
@property (nonatomic, strong) NSString *matchInfo;
@property (nonatomic, strong) NSString *publishTime;
@property (nonatomic, strong) NSString *talk;
@property (nonatomic, strong) talkModel *talkId;
@property (nonatomic, strong) userModel *user;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSNumber *videoId;
@end

@interface talkModel : NSObject
@property (nonatomic, strong) NSString *browserCount;
@property (nonatomic, strong) NSString *commentCount;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *displayBig;
@property (nonatomic, strong) NSString *enable;
@property (nonatomic, strong) NSNumber *forwardCount;
@property (nonatomic, strong) NSNumber *hasZan;
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSString *publishTime;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSNumber *videoId;
@property (nonatomic, strong) NSNumber *zanCount;
@end

NS_ASSUME_NONNULL_END
