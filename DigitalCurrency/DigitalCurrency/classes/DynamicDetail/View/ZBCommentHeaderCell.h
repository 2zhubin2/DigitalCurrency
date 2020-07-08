//
//  ZBCommentHeaderCell.h
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/3.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBCommunityTuiJianModel.h"
#import "ZBCommunityTuiJianUserModel.h"

NS_ASSUME_NONNULL_BEGIN
@class ZBCommentHeaderCell;
@protocol ZBCommentHeaderCellDelegate <NSObject>

@optional
-(void)CommentHeaderCellClickFenXiang:(ZBCommentHeaderCell *)cell;

@end

@interface ZBCommentHeaderCell : UITableViewCell

@property(nonatomic,strong)ZBCommunityTuiJianModel *model;
@property(nonatomic,weak)id<ZBCommentHeaderCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
