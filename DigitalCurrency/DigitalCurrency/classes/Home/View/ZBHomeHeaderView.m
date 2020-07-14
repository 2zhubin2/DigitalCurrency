//
//  ZBHomeHeaderView.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/14.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBHomeHeaderView.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface ZBHomeHeaderView ()<SDCycleScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *BG_image_view;
@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;


@end


@implementation ZBHomeHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //加载Xib
        return [[NSBundle mainBundle] loadNibNamed:@"ZBHomeHeaderView" owner:nil options:nil].lastObject;
        
        
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self set_CycleScrollView:self.BG_image_view];
    
}
-(void)set_CycleScrollView:(UIView *)view{
    UIImageView *backgroundView = [[UIImageView alloc] init];
    backgroundView.frame = view.bounds;
    [view addSubview:backgroundView];
    
    UIScrollView *demoContainerView = [[UIScrollView alloc] initWithFrame:self.frame];
//    demoContainerView.contentSize = CGSizeMake(view.frame.size.width, 100);
    [view addSubview:demoContainerView];
    
    // 情景一：采用本地图片实现
    NSArray *imageNames = @[@"banner",
                            @"banner",
                            @"banner",
                            ];

     CGFloat w = zbStatuBarW -20 ;
    CGFloat h = view.bounds.size.height;
    
    if (@available(iOS 13.0, *)) {
        
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0, w, h) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
        
    } else {
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0, w, h) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    }
    
//    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(10,20, w, h) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    _cycleScrollView.backgroundColor = [UIColor whiteColor];
    _cycleScrollView.delegate = self;
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [demoContainerView addSubview:_cycleScrollView];
    _cycleScrollView.autoScrollTimeInterval = 3.0;
}

//- (IBAction)clickbanner:(id)sender {
////    self.navigationController.tabBarController.selectedIndex = 1;
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"clickbanner" object:nil];
//}

- (IBAction)clickJianxun:(id)sender {
//    self.navigationController.tabBarController.selectedIndex = 3;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"clickJianxun" object:nil];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"clickbanner" object:nil];
    

}

@end
