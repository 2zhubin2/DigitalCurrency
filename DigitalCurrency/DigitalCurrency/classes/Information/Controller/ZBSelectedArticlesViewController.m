//
//  ZBSelectedArticlesViewController.m
//  DigitalCurrency
//
//  Created by HFY on 2020/6/30.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBSelectedArticlesViewController.h"
#import "ZBNewInformationTableViewCell.h"
#import "ZBInformationDetailHeaderVC.h"

@interface ZBSelectedArticlesViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,assign)int page;

@end

@implementation ZBSelectedArticlesViewController

static NSString *ID = @"NewInformationCell";

- (NSMutableArray *)dataArray{
    if (_dataArray  == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.darkGrayColor;
    
    //初始化页数
    _page = 3;
    
    // 加载网络数据
    [self ZBLoadData:3];

    //设置tableview
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    self.page = 3;
    [self.tableView.mj_footer resetNoMoreData];
    [self ZBLoadData:3];
}

#pragma mark - 设置tableview
-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    tableView.frame = CGRectMake(0, 0, zbStatuBarW, ZBScreenH - zbStatuBarH - 44 - 49);
       
    [tableView registerNib:[UINib nibWithNibName:@"ZBNewInformationTableViewCell" bundle:nil] forCellReuseIdentifier:ID];
       
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
    [self ZBLoadData:3];
    self.page = 0;
    [self.tableView.mj_footer resetNoMoreData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self.tableView.mj_header endRefreshing];
       });
    
}

#pragma  mark - 下拉加载
-(void)loadMore
{
    if (_page == 6) {

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
        
        if (page == 3) {
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
    cell.typeFlag = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZBInformationDetailHeaderVC *vc = [[ZBInformationDetailHeaderVC alloc] init];
    vc.model = self.dataArray[indexPath.row];
    vc.typeFlag = NO;
    [self.navigationController pushViewController:vc animated:YES];
}



@end
