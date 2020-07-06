//
//  userModel.h
//  firstProject
//
//  Created by apple on 2020/5/25.
//  Copyright © 2020 ap. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class projectModel;
@interface userModel : NSObject
@property (nonatomic, strong) NSString *album;
@property (nonatomic, strong) NSNumber *fansCount;
@property (nonatomic, strong) NSNumber *followCount;
@property (nonatomic, strong) NSString *head;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, assign) BOOL isFollow;
@property (nonatomic, strong) NSString *projectKey;
@property (nonatomic, strong) NSString *signature;
@property (nonatomic, strong) NSNumber *talkCount;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSString *uuid;

@end


NS_ASSUME_NONNULL_END
