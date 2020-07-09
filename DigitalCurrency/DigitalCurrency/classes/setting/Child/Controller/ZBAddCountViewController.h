//
//  ZBAddCountViewController.h
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/9.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBMineUserInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@class ZBCommentHeaderCell;
@protocol ZBAddCountViewControllerDelegate <NSObject>

@optional
-(void)AddCountViewControllerAddSuccess:(ZBMineUserInfoModel *)model;

@end

@interface ZBAddCountViewController : UIViewController

@property(nonatomic,weak)id<ZBAddCountViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
