//
//  ZBSearchOneViewController.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/2.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBSearchOneViewController.h"
#import "ZBSearchOneCollectionViewCell.h"

@interface ZBSearchOneViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,weak)UICollectionView *collectionView;

@end

@implementation ZBSearchOneViewController

static NSString *ID = @"SearchOne";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupTopView];
    [self setupColloctionView];
//    self.view.backgroundColor = [UIColor grayColor];
}

#pragma mark - 初始化顶部View
-(void)setupTopView{
    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor redColor];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0,15,60,15);
    label.numberOfLines = 0;
    [view addSubview:label];

    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"热门推荐" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];

    label.attributedText = string;
    [self.view addSubview:view];
    view.frame = CGRectMake(20, 0,zbStatuBarW - 40, 44);
    
}

#pragma mark - 初始化ColloctionView
-(void)setupColloctionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(80, 25);
//    layout.estimatedItemSize = CGSizeMake(25, 80);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
//    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //UIcollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(20, 44,zbStatuBarW - 40, ZBScreenH - zbStatuBarH - 44 -44 ) collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView = collectionView;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.bounces = NO;
//    collectionView.pagingEnabled = YES;
    
//    [collectionView registerClass:[ZBSearchOneCollectionViewCell class] forCellWithReuseIdentifier:ID];
    [collectionView registerNib:[UINib nibWithNibName:@"ZBSearchOneCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
}

#pragma mark - CollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 9;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZBSearchOneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor blueColor];
    return cell;
}


@end
