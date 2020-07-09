//
//  ZBCommunityViewController.m
//  DigitalCurrency
//
//  Created by HFY on 2020/6/30.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBCommunityViewController.h"
#import "ZBCommunityTuiJianViewController.h"
#import "ZBCommunityGuanZhuViewController.h"

@interface ZBCommunityViewController ()<UIScrollViewDelegate>

@property(nonatomic,weak)UIView *tuijian_view;

@property(nonatomic,strong)UIButton *selectBtn;
@property(nonatomic,weak)UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *title_view;
@property(nonatomic,strong)NSMutableArray *btns;

@end

@implementation ZBCommunityViewController

- (NSMutableArray *)btns{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
//        [self.view addSubview:view];
//        _title_view = view;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, zbStatuBarH + 44, zbStatuBarW, ZBScreenH - zbStatuBarH - 44 - 49 -44);
    _scrollView = scrollView;
    [self.view addSubview:scrollView];
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(zbStatuBarW * 2, ZBScreenH - zbStatuBarH - 44 - 49 -44);
    scrollView.bounces = NO;
    scrollView.delegate = self;
    
    
    ZBCommunityTuiJianViewController *tuijian_vc = [[ZBCommunityTuiJianViewController alloc] init];
    tuijian_vc.title = @"推荐";
    [self addChildViewController:tuijian_vc];
    [self.scrollView addSubview:tuijian_vc.view];
    tuijian_vc.view.frame = CGRectMake(0, 0 , scrollView.bounds.size.width, scrollView.bounds.size.height);
//    [tuijian_vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(scrollView);
//        make.left.equalTo(scrollView);
//        make.bottom.equalTo(scrollView);
//        make.right.equalTo(scrollView);
//    }];
    
    ZBCommunityGuanZhuViewController *guanzhu_vc = [[ZBCommunityGuanZhuViewController alloc] init];
    guanzhu_vc.title = @"关注";
    [self addChildViewController:guanzhu_vc];
    [self.scrollView addSubview:guanzhu_vc.view];
    guanzhu_vc.view.frame = CGRectMake(zbStatuBarW, 0 , scrollView.bounds.size.width, scrollView.bounds.size.height );
//    [guanzhu_vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(scrollView);
//        make.left.equalTo(scrollView.mas_right);
//        make.bottom.equalTo(scrollView);
//        make.right.equalTo(scrollView.mas_right).multipliedBy(2);
//    }];
    [self setupAllTitleButton:self.title_view];
    
    
}
//- (void)viewWillAppear:(BOOL)animated{
//    self.tabBarController.tabBar.hidden = YES;
//}



-(void)setupAllTitleButton:(UIView *)view{
    
    
    CGFloat btnX = 0;
    CGFloat btnW = ZBScreenW / 8;
    CGFloat btnH = 44;
    
    for (int i=0; i<2; i++) {
        btnX = (i+1) * btnW;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIViewController *vc = self.childViewControllers[i];
//        [btn setTitle:vc.title forState:UIControlStateNormal];
        btn.frame = CGRectMake(btnX, 0, btnW, btnH);
        [view addSubview:btn];
        btn.tag = 1000 + i;
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:vc.title attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:135/255.0 green:154/255.0 blue:250/255.0 alpha:1.0]}];
        [btn setAttributedTitle:string forState:UIControlStateNormal];
        
        NSMutableAttributedString *string_s = [[NSMutableAttributedString alloc] initWithString:vc.title attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:50/255.0 green:83/255.0 blue:250/255.0 alpha:1.0]}];
        [btn setAttributedTitle:string_s forState:UIControlStateSelected];
      
        
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *blankBarView = [[UIView alloc] init];
        blankBarView.backgroundColor = [UIColor colorWithRed:50/255.0 green:83/255.0 blue:250/255.0 alpha:1.0];
        
        [btn addSubview:blankBarView];
        blankBarView.bounds = CGRectMake(0, 0, 5, 5);
        blankBarView.layer.cornerRadius = 2.5;
        CGPoint temp = CGPointMake(btn.titleLabel.center.x, CGRectGetMaxY(btn.titleLabel.frame) + 3);
        blankBarView.center = temp;
        blankBarView.hidden = YES;
        
        [self.btns addObject:btn];
  
        
    }
    self.selectBtn = self.title_view.subviews[0];
    self.selectBtn.selected = YES;
    UIView *view_cur = self.selectBtn.subviews.firstObject;
    view_cur.hidden = NO;
    
}

-(void)clickBtn:(UIButton *)btn{
    
    [self selButton:btn];
    
    
}

#pragma mark - 选中标题
-(void)selButton:(UIButton *)btn{
    
    UIView *view_cur = btn.subviews.firstObject;
    view_cur.hidden = !(view_cur.hidden);
    
    UIView *view_pre = self.selectBtn.subviews.firstObject;
    view_pre.hidden = !(view_pre.hidden);
    
    self.selectBtn.selected = !self.selectBtn.isSelected;
    btn.selected = YES;
    self.selectBtn = btn;
    _scrollView.contentOffset = CGPointMake(zbStatuBarW * (btn.tag - 1000), 0);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    NSLog(@"123");
    NSInteger page = scrollView.contentOffset.x / zbStatuBarW;
       UIButton *btn = self.btns[page];
       [self selButton:btn];
}
 


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
