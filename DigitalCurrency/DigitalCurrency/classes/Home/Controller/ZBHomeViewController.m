//
//  ZBHomeViewController.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/6/29.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBHomeViewController.h"
#import "ZBHomeTableViewCell.h"
#import "ZBSearchViewController.h"
#import "ZBHomeTableViewModel.h"
#import "ZBFabuViewController.h"

@interface ZBHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIImageView *search_backImageView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *tab_back_view;


@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation ZBHomeViewController

static NSString *ID = @"HomeCell";


- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self dataLoad];

    

    _search_backImageView.image = [UIImage imageNamed:@"bg_search1"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"ZBHomeTableViewCell" bundle:nil] forCellReuseIdentifier:ID];
    
    _tab_back_view.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.32].CGColor;
    _tab_back_view.layer.shadowOffset = CGSizeMake(2,2);
    _tab_back_view.layer.shadowOpacity = 1;
    _tab_back_view.layer.shadowRadius = 5;
    _tab_back_view.layer.cornerRadius = 10;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    
    [self notificationCenterConfig];
    
     MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
       
        
        // 设置文字
        [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        [header setTitle:@"释放并刷新" forState:MJRefreshStatePulling];
        [header setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
        
         self.tableView.mj_header = header;

        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
         
        // 设置文字
        [footer setTitle:@"点击或上拉刷新" forState:MJRefreshStateIdle];
        [footer setTitle:@"加载更多 ..." forState:MJRefreshStateRefreshing];
        [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
        
        self.tableView.mj_footer = footer;
    
}


-(void)refresh
{
    [self dataLoad];
    [self.tableView.mj_footer resetNoMoreData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self.tableView.mj_header endRefreshing];
       });
    
}
-(void)loadMore
{


    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            });
  
    
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}


/**
 加载关注界面网络数据
 */
- (void)dataLoad{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://api.yysc.online/share/market" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable result) {
        
        
        NSMutableArray *tempArray = [NSMutableArray new];
        tempArray = [ZBHomeTableViewModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
        self.dataArray = tempArray;
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (IBAction)clickbanner:(id)sender {
    self.navigationController.tabBarController.selectedIndex = 1;
}

- (IBAction)clickJianxun:(id)sender {
    self.navigationController.tabBarController.selectedIndex = 3;
}

#pragma maek - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZBHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.row_num = indexPath.row;
    if (_dataArray.count != 0) {
            cell.model = self.dataArray[indexPath.row];
       
    }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 63;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];

    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10,10,70,14.5);
    label.numberOfLines = 0;
    [view addSubview:label];

    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"行情涨跌" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];

    label.attributedText = string;
    
    return view;
    
}

#pragma mark - 点击搜索按钮

- (IBAction)clickSearchBtn:(id)sender {
    ZBSearchViewController *vc = [[ZBSearchViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - 通知相关
- (void)notificationCenterConfig{
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(justPush:) name:kNotificationMessagePush object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(justPush:) name:@"jumpFabu0"object:nil];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end
