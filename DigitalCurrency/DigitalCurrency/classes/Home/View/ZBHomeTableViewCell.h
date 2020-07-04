//
//  ZBHomeTableViewCell.h
//  DigitalCurrency
//
//  Created by HFY on 2020/6/29.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBHomeTableViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZBHomeTableViewCell : UITableViewCell

@property(nonatomic,strong)ZBHomeTableViewModel *model;
@property(nonatomic,assign)NSInteger row_num;

@end

NS_ASSUME_NONNULL_END
