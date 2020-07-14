//
//  ZBNewInformationTableViewCell.h
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/1.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBNewInformationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZBNewInformationTableViewCell : UITableViewCell

@property(nonatomic,strong)ZBNewInformationModel *model;
@property(nonatomic,assign)Boolean typeFlag;
@property(nonatomic,assign)NSInteger row_num;

@end

NS_ASSUME_NONNULL_END
