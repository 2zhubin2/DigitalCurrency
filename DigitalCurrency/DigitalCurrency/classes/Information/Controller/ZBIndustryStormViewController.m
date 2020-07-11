//
//  ZBIndustryStormViewController.m
//  DigitalCurrency
//
//  Created by HFY on 2020/6/30.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBIndustryStormViewController.h"
#import "ZBIndustryStormTableViewCell.h"
#import "ZBIndustryStormModel.h"

@interface ZBIndustryStormViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)int page;


@end

@implementation ZBIndustryStormViewController

//IndustryStormCell
static NSString *ID = @"IndustryStormCell";

- (NSMutableArray *)dataArray{
    if (_dataArray  == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _page = 6;
    [self ZBLoadData:6];
 
    //设置tableView
    [self setupTableView];
    
    //设置头部view
    [self setup_headerView];
}
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
       self.page = 6;
       [self.tableView.mj_footer resetNoMoreData];
       [self ZBLoadData:6];
}

#pragma mark - 设置tableView
-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    tableView.frame = CGRectMake(0, zbStatuBarH, zbStatuBarW, ZBScreenH - zbStatuBarH - 44 - 49);
       
    [tableView registerNib:[UINib nibWithNibName:@"ZBIndustryStormTableViewCell" bundle:nil] forCellReuseIdentifier:ID];
       
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;

    tableView.delegate = self;
    tableView.dataSource = self;
    
        
    // 告诉tableView所有cell的真实高度是自动计算（根据设置的约束来计算）
    tableView.rowHeight = UITableViewAutomaticDimension;
    // 告诉tableView所有cell的估算高度
    tableView.estimatedRowHeight = 70;
    _tableView = tableView;
    
    //上拉刷新初始化
     MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
     // 设置文字
     [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
     [header setTitle:@"释放并刷新" forState:MJRefreshStatePulling];
     [header setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
     
      self.tableView.mj_header = header;
    
    //下拉加载初始化
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
     // 设置文字
     [footer setTitle:@"点击或上拉刷新" forState:MJRefreshStateIdle];
     [footer setTitle:@"加载更多 ..." forState:MJRefreshStateRefreshing];
     [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
     
     self.tableView.mj_footer = footer;
}

#pragma  mark - 上拉刷新
-(void)refresh
{
    [self ZBLoadData:6];
    self.page = 6;
    [self.tableView.mj_footer resetNoMoreData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self.tableView.mj_header endRefreshing];
       });
    
}

#pragma  mark - 下拉加载
-(void)loadMore
{
    if (_page == 8) {

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
//        self.tableView.mj_footer.hidden = YES;
            });
        
    }else{
        [self ZBLoadData:_page];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshing];
           });
        _page+=1;
    }
    
}

#pragma  mark - 设置headerView
-(void)setup_headerView{
     UIView *view = [[UIView alloc] init];
     UILabel *label = [[UILabel alloc] init];
     label.frame = CGRectMake(10,5,148,11);
     label.numberOfLines = 0;
     [view addSubview:label];

     NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@  今天",[self curYearMD]] attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 11],NSForegroundColorAttributeName: [UIColor colorWithRed:50/255.0 green:83/255.0 blue:249/255.0 alpha:1.0]}];

     label.attributedText = string;
    
    _tableView.tableHeaderView = view;
    _tableView.tableHeaderView.frame = CGRectMake(0, 0, 0, 20);
     
}

#pragma  mark - 加载网络数据
-(void)ZBLoadData:(int )page{
    
    
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
 
    [par setObject:[NSString stringWithFormat:@"%d",1 + page] forKey:@"pageNum"];
    [par setObject:@10 forKey:@"pageSize"];
    [par setObject:[NSDate date] forKey:@"date"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
   
    [manager GET:@"http://api.yysc.online/admin/getFinanceTalk" parameters:par headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            

       NSMutableArray *tempArray = [NSMutableArray new];

        tempArray = [ZBIndustryStormModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        if (page == 6) {
            self.dataArray = tempArray;
               }else{
            [self.dataArray addObjectsFromArray:tempArray];
            }
        
        [self.tableView reloadData];

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD showError:@"网络错误"];
        }];
        
    
}

#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZBIndustryStormTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



-(NSString *)curYearMD{
    
    
    //获取当前时间日期
          NSDate *date=[NSDate date];
          NSDateFormatter *format1=[[NSDateFormatter alloc] init];
          [format1 setDateFormat:@"yyyy-MM-dd"];
          NSString *dateStr;
          dateStr=[format1 stringFromDate:date];
          return dateStr;
}


@end
