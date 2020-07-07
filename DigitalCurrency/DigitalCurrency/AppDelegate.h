//
//  AppDelegate.h
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/6/29.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBMineUserInfoModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(nonatomic,strong)UIWindow *window;

/**用户信息*/
@property (strong, nonatomic) ZBMineUserInfoModel *mineUserInfoModel;
/**全局登录状态*/
@property (assign, nonatomic, getter=isLogin) BOOL login;

@property (strong, nonatomic) ZBMineUserInfoModel *mineUserInfoModel_baseInfo;

 // 获取全局登录状态
//   AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];


@end

