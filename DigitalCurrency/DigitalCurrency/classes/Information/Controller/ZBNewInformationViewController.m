//
//  ZBNewInformationViewController.m
//  DigitalCurrency
//
//  Created by HFY on 2020/6/30.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBNewInformationViewController.h"
#import "ZBViewController.h"
#import "ZBNewInformationTableViewCell.h"
#import "ZBInformationDetailHeaderVC.h"

@interface ZBNewInformationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)UIView *headerView;
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)int page;


@end

@implementation ZBNewInformationViewController

//NewInformationCell
static NSString *ID = @"NewInformationCell";

- (NSMutableArray *)dataArray{
    if (_dataArray  == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.blueColor;
    
    //初始化页数
    _page = 0;
    
    //设置头部View
     [self setupHeaderView];
    
    //设置tableView
    [self setupTableView];
    
   
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    self.page = 0;
    [self.tableView.mj_footer resetNoMoreData];
    [self ZBLoadData:0];
    
}

#pragma mark - 设置头部View
-(void)setupHeaderView{
    

    ZBViewController *vc = [[ZBViewController alloc] init];
    _headerView = vc.view;
    
   
}

#pragma mark - 设置tableView
-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    tableView.frame = CGRectMake(0, 0, zbStatuBarW, ZBScreenH - zbStatuBarH - 44 - 49);
//    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(0);
//        make.left.equalTo(self.view).offset(0);
//        make.bottom.equalTo(self.view).offset(0);
//        make.right.equalTo(self.view).offset(0);
//    }];


    [tableView registerNib:[UINib nibWithNibName:@"ZBNewInformationTableViewCell" bundle:nil] forCellReuseIdentifier:ID];
       
      tableView.separatorStyle = UITableViewCellSelectionStyleNone;
      tableView.showsVerticalScrollIndicator = NO;
       tableView.showsHorizontalScrollIndicator = NO;
    tableView.tableHeaderView = _headerView;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ClickHeaderView)];
    [_headerView addGestureRecognizer:tap];
    tableView.tableHeaderView.frame = CGRectMake(0, 0, 0, 200);
//    [tableView.tableHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(tableView);
//        make.left.equalTo(self.view);
//        make.right.equalTo(self.view);
//        make.height.equalTo(tableView).multipliedBy(0).offset(200);
//    }];
    tableView.delegate = self;
    tableView.dataSource = self;
        
       // 告诉tableView所有cell的真实高度是自动计算（根据设置的约束来计算）
       tableView.rowHeight = UITableViewAutomaticDimension;
       // 告诉tableView所有cell的估算高度
       tableView.estimatedRowHeight = 70;
       _tableView = tableView;
    
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
   
    
    // 设置文字
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"释放并刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
    
     self.tableView.mj_header = header;
    /*
     
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;

    // 隐藏状态
    header.stateLabel.hidden = YES;
     
    // 设置字体
    
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];

    // 设置颜色
    header.stateLabel.textColor = [UIColor blackColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];*/
    
    
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
     
    // 设置文字
    [footer setTitle:@"点击或上拉刷新" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载更多 ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
    
    self.tableView.mj_footer = footer;
    
    
}

-(void)ClickHeaderView{
    self.navigationController.tabBarController.selectedIndex = 1;
}

-(void)refresh
{
    [self ZBLoadData:0];
    self.page = 0;
    [self.tableView.mj_footer resetNoMoreData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self.tableView.mj_header endRefreshing];
       });
    
}
-(void)loadMore
{
    if (_page == 3) {

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

#pragma mark - 加载网络数据
-(void)ZBLoadData:(int )page{
    
    
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
 
    [par setObject:[NSString stringWithFormat:@"%d",1 + page] forKey:@"pageNum"];
    [par setObject:@10 forKey:@"pageSize"];
    [par setObject:[NSDate date] forKey:@"date"];
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
   
    [manager GET:@"http://api.yysc.online/admin/getFinanceTalk" parameters:par headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            

       NSMutableArray *tempArray = [NSMutableArray new];

        tempArray = [ZBNewInformationModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//        self.dataArray = tempArray;
        if (page == 0) {
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
    
    ZBNewInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

        cell.model = self.dataArray[indexPath.row];
    cell.typeFlag = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZBInformationDetailHeaderVC *vc = [[ZBInformationDetailHeaderVC alloc] init];
    vc.model = self.dataArray[indexPath.row];
    vc.typeFlag = YES;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
