//
//  ZBInformationDetailHeaderVC.h
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/3.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBNewInformationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZBInformationDetailHeaderVC : UIViewController

@property(nonatomic,strong)ZBNewInformationModel *model;
@property(nonatomic,assign)Boolean typeFlag;


@end

NS_ASSUME_NONNULL_END
