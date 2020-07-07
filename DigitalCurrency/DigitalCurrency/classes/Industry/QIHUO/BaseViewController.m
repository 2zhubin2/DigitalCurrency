
//
//  ViewController.m
//  SCRBProject1
//
//  Created by zdh on 2019/6/25.
//  Copyright © 2019 zdh. All rights reserved.
//



#import "BaseViewController.h"


#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width

@interface BaseViewController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) UIButton *baseBackBtn;

@end

@implementation BaseViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//  [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"background_Nav"] forBarMetrics:UIBarMetricsDefault];
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = (UIColor *)TNColor.main_bg_color;// UIColorFromRGB(0xFFFFFF)
    [self setNavigation];
//    self.tabBarController.delegate = self;
    // Do any additional setup after loading the view.
}

-(void)setNavigation{
    _baseBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [_baseBackBtn addTarget:self action:@selector(leftButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_baseBackBtn setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
    
    _baseBackBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -20,0, 0);
    _baseBackBtn.imageEdgeInsets = UIEdgeInsetsMake(12, 0,12,0);
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -15;
    UIBarButtonItem *item =  [[UIBarButtonItem alloc] initWithCustomView:_baseBackBtn];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,item];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :UIColorFromRGB(0xffffff), NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:18]}];
}


//设置导航左边的button的图片名和背景图片名
- (void)setLeftButtonWithImageName:(NSString*)imageName bgImageName:(NSString*)bgImageName
{
    UIButton *tmpLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    tmpLeftButton.frame = CGRectMake(-10, 0, 44, 44);//CGRectMake(0, BUTTONMarginUP, NAVBUTTON_WIDTH, NAVBUTTON_HEIGHT);
    tmpLeftButton.showsTouchWhenHighlighted = NO;
    tmpLeftButton.exclusiveTouch = YES; //add by ljj 修改push界面问题
    tmpLeftButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20,0, 0);
    tmpLeftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -12,0, 0);
    if (bgImageName)//设置button的背景
    {
        [tmpLeftButton setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
    }
    
    [tmpLeftButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [tmpLeftButton addTarget:self action:@selector(leftButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tmpLeftButton];
    
//    if ([LCPSystemFactory isSystemVersionIs7])//左边button的偏移量，从左移动13个像素
//    {
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -10;
        [self.navigationItem setLeftBarButtonItems:@[negativeSeperator, leftButtonItem]];
//    }
//    else
//    {
//        [self.navigationItem setLeftBarButtonItem:leftButtonItem];
//    }
}

#pragma mark - 设置导航条样式
-(void)setTitle:(NSString *)titleName titleColor:(UIColor *)titleColor{
    
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    titleL.text = titleName;
    titleL.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    titleL.textColor = titleColor;
    titleL.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleL;
    
}//添加标题

-(void)setNavigationStyle:(UIColor *)NavColor{
    self.navigationController.navigationBar.barTintColor = NavColor;
}
-(void)leftButtonPressed:(UIButton*)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)backNavigationStyle:(UIColor *)navColor{
    
    int backH = (([[UIApplication sharedApplication] statusBarFrame].size.height == 44.0f) ? 88:64);
    
    
    UIView *backNav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    
    backNav.backgroundColor = navColor;
    
    [self.view addSubview:backNav];
    
}
#pragma mark - 控件边线设置
- (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width{
    
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, view.frame.size.height - width, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(view.frame.size.width - width, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    
}

//隐藏navigationbar上面的_UIVisualEffectSubview的superView
-(void)getBackView:(UIView*)superView

{
    
    if ([superView isKindOfClass:NSClassFromString(@"_UIBarBackground")])
        
    {
        
//        _navBackView = superView;
//
//        //在这里可设置背景色
//
//        _navBackView.backgroundColor = RGB(27, 27, 27);
        
    }else if ([superView isKindOfClass:NSClassFromString(@"_UIVisualEffectSubview")])
    {
        superView.hidden = YES;
    }
    for (UIView *view in superView.subviews)
        
    {
        
        [self getBackView:view];
        
    }
}
-(void)hideBackBtn{
    
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([viewController.tabBarItem.title isEqualToString: @"社区"]) {
        if (SavedUser) {
            return YES;
        }else{
//            PresentLoginViewController(self);
//            return NO;
        }
    }
    return YES;
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
