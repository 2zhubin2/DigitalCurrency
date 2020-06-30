//
//  ViewController.h
//  SCRBProject1
//
//  Created by zdh on 2019/6/25.
//  Copyright © 2019 zdh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
-(void)setTitle:(NSString *)titleName titleColor:(UIColor *)titleColor;
- (void)setLeftButtonWithImageName:(NSString*)imageName bgImageName:(NSString*)bgImageName;
-(void)setNavigationStyle:(UIColor *)NavColor;
-(void)backNavigationStyle:(UIColor *)navColor;
#pragma mark - 控件边线设置
- (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width;
-(void)getBackView:(UIView*)superView;
@end

NS_ASSUME_NONNULL_END
