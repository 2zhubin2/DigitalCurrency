//
//  ZBDongTaiTableViewCell.h
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/1.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBDongTaiModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZBDongTaiTableViewCell : UITableViewCell

@property(nonatomic,assign)double *cellH;

@property(nonatomic,strong)ZBDongTaiModel *model;

@end

NS_ASSUME_NONNULL_END
