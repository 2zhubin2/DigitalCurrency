//
//  ZBDongTaiDetailViewController.h
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/3.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBCommunityTuiJianModel.h"
#import "ZBCommunityTuiJianUserModel.h"

@protocol ZBDongTaiDetailViewControllerDelegate <NSObject>

@optional
-(void)DongTaiDetailViewControllerPingBi:(NSIndexPath * _Nullable) indexPath;

@end



NS_ASSUME_NONNULL_BEGIN

@interface ZBDongTaiDetailViewController : UIViewController

@property(nonatomic,strong)ZBCommunityTuiJianModel *model;
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,weak)id<ZBDongTaiDetailViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
