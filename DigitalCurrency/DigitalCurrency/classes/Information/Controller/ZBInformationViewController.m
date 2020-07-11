//
//  ZBInformationViewController.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/6/29.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBInformationViewController.h"
#import "ZBNewInformationViewController.h"
#import "ZBSelectedArticlesViewController.h"
#import "ZBIndustryStormViewController.h"
#import "ZBCommunityViewController.h"
#import "ZBFabuViewController.h"


@interface ZBInformationViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,weak)UICollectionView *collectionView;
@property(nonatomic,strong)UIButton *selectBtn;
@property(nonatomic,strong)NSMutableArray *btns;


@end

@implementation ZBInformationViewController

static NSString *ID = @"colCell";

- (NSMutableArray *)btns{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor = [UIColor blueColor];
    
    //添加顶部标题view
    [self setupTopTitleView];
    
    //添加底部内容View
    [self setupBottomContaninerView];
    
    
    
    //添加所有子控制器
    [self setupAllChildViewController];
    
    //添加所有标题按钮
    [self setupAllTitleButton];
    
    //添加通知
    [self notificationCenterConfig];
    

    
    
}


- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}

#pragma  mark - 添加所有标题按钮
-(void)setupAllTitleButton{
    
    NSInteger count = self.childViewControllers.count;
    
    CGFloat btnX = 0;
    CGFloat btnW = ZBScreenW / count;
    CGFloat btnH = _scrollView.bounds.size.height;
    
    for (int i=0; i<count; i++) {
        btnX = i * btnW;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIViewController *vc = self.childViewControllers[i];
//        [btn setTitle:vc.title forState:UIControlStateNormal];
        [_scrollView addSubview:btn];
        if (@available(iOS 13.0, *)) {
            
           btn.frame = CGRectMake(btnX, 0, btnW, btnH);
            
        } else {
          btn.frame = CGRectMake(btnX, -20, btnW, btnH);
        }
         
        btn.tag = 1000 + i;
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:vc.title attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
        [btn setAttributedTitle:string forState:UIControlStateNormal];
        
        NSMutableAttributedString *string_s = [[NSMutableAttributedString alloc] initWithString:vc.title attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:50/255.0 green:83/255.0 blue:250/255.0 alpha:1.0]}];
        [btn setAttributedTitle:string_s forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"zixun_bg"] forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.btns addObject:btn];
        
    }
    self.selectBtn = self.scrollView.subviews[0];
    self.selectBtn.selected = YES;
}

-(void)clickBtn:(UIButton *)btn{
    
    [self selButton:btn];
    _collectionView.contentOffset = CGPointMake(ZBScreenW * (btn.tag - 1000), 0);
}

#pragma mark - 选中标题
-(void)selButton:(UIButton *)btn{
    
    
    self.selectBtn.selected = !self.selectBtn.isSelected;
    btn.selected = YES;
    self.selectBtn = btn;
}

#pragma  mark - 添加所有子控制器
-(void)setupAllChildViewController{
    
    ZBNewInformationViewController *newInformation_vc = [[ZBNewInformationViewController alloc] init];
    newInformation_vc.title = @"最新资讯";
    [self addChildViewController:newInformation_vc];
    
    ZBSelectedArticlesViewController *selectedArticles_vc = [[ZBSelectedArticlesViewController alloc] init];
    selectedArticles_vc.title = @"精选好文";
    [self addChildViewController:selectedArticles_vc];
    
    ZBIndustryStormViewController *industryStorm_vc = [[ZBIndustryStormViewController alloc] init];
    industryStorm_vc.title = @"行业风暴";
    [self addChildViewController:industryStorm_vc];
    
    ZBCommunityViewController *community_vc = [[ZBCommunityViewController alloc] init];
    community_vc.title = @"社区";
    [self addChildViewController:community_vc];
    
    
}

#pragma  mark - 添加底部内容View
-(void)setupBottomContaninerView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    if (@available(iOS 13.0, *)) {
//
//       layout.itemSize = CGSizeMake(zbStatuBarW, ZBScreenH - zbStatuBarH - 44 );
//
//    } else {
//        layout.itemSize = CGSizeMake(zbStatuBarW, ZBScreenH - 44 );
//    }
    layout.itemSize = CGSizeMake(zbStatuBarW, ZBScreenH - zbStatuBarH - 44 );
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //UIcollectionView
    
    
        if (@available(iOS 13.0, *)) {
    
          UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, zbStatuBarH + 44,zbStatuBarW , ZBScreenH -zbStatuBarH - 44  - 49) collectionViewLayout:layout];
           collectionView.dataSource = self;
              collectionView.delegate = self;
              [self.view addSubview:collectionView];
              collectionView.backgroundColor = [UIColor redColor];
              _collectionView = collectionView;
              collectionView.showsVerticalScrollIndicator = NO;
              collectionView.showsHorizontalScrollIndicator = NO;
              collectionView.bounces = NO;
              collectionView.pagingEnabled = YES;
              
              [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    
        } else {
       UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _scrollView.frame.origin.y + _scrollView.bounds.size.height,zbStatuBarW , ZBScreenH - CGRectGetMaxY(_scrollView.frame) - 49) collectionViewLayout:layout];
            collectionView.dataSource = self;
               collectionView.delegate = self;
               [self.view addSubview:collectionView];
               _collectionView = collectionView;
               collectionView.showsVerticalScrollIndicator = NO;
               collectionView.showsHorizontalScrollIndicator = NO;
               collectionView.bounces = NO;
               collectionView.pagingEnabled = YES;
               [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
        }
   
}

#pragma  mark - 添加顶部标题view
-(void)setupTopTitleView{
    
   
    
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, [UIApplication sharedApplication].statusBarFrame.size.width, 44)];
            [self.view addSubview:scrollView];
            _scrollView = scrollView;

    scrollView.backgroundColor = [UIColor clearColor];
    
}

#pragma mark - CollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.childViewControllers.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    [cell.contentView.subviews.firstObject removeFromSuperview];
    [cell.contentView addSubview:self.childViewControllers[indexPath.row].view];
    return cell;
}

#pragma mark - CollectionViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger page = _collectionView.contentOffset.x / zbStatuBarW;
    UIButton *btn = self.btns[page];
    [self selButton:btn];
    
}


#pragma mark - 通知相关
- (void)notificationCenterConfig{
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(justPush:) name:kNotificationMessagePush object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(justPush:) name:@"jumpFabu2"object:nil];
}

- (void)justPush:(NSNotification *) notification {
    //处理消息
    
     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
      
      if (appDelegate.login == YES) {
          ZBFabuViewController *vc = [[ZBFabuViewController alloc] init];
          [self.navigationController pushViewController:vc animated:YES];
      }else{
          ZBloginViewController *vc = [[ZBloginViewController alloc] init];
          
          [self.navigationController pushViewController:vc animated:YES];
      }
    
}
- (void)dealloc {
    //单条移除观察者
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:[NSString stringWithFormat:@"%@2",kNotificationMessagePush] object:nil];
    //移除所有观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
