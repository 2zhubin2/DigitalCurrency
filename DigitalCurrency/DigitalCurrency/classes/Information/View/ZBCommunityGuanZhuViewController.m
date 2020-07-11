//
//  ZBCommunityGuanZhuViewController.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/1.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBCommunityGuanZhuViewController.h"
#import "ZBCommunityGuanZhuHeaderCell.h"
#import "ZBCommunityGuanZhuCell.h"
#import "ZBCommunityGuanZhuModel.h"

@interface ZBCommunityGuanZhuViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation ZBCommunityGuanZhuViewController

//CommunityGuanZhuHeader
//CommunityGuanZhuCell
static NSString *ID_h = @"CommunityGuanZhuHeader";
static NSString *ID = @"CommunityGuanZhuCell";

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewWillAppear:(BOOL)animated{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.login == YES) {
        [self RefreshGuanZhu];
    }else{
        self.dataArray = nil;
        [self.tableView reloadData];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
    
    //设置tableview
    [self setupTableView];
    
}

#pragma mark - 设置tableview
-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, zbStatuBarW, ZBScreenH - zbStatuBarH - 44 - 49 -44) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
       
    [tableView registerNib:[UINib nibWithNibName:@"ZBCommunityGuanZhuHeaderCell" bundle:nil] forCellReuseIdentifier:ID_h];
    [tableView registerNib:[UINib nibWithNibName:@"ZBCommunityGuanZhuCell" bundle:nil] forCellReuseIdentifier:ID];
       
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

#pragma  mark - 上拉刷新
-(void)refresh
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.login == YES) {
        [self RefreshGuanZhu];
        [self.tableView.mj_footer resetNoMoreData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        });
    }else{
        self.dataArray = nil;
        [self.tableView reloadData];
    }
   
    
}

#pragma  mark - 下拉加载
-(void)loadMore
{


    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            });
  
    
}

#pragma mark - tableViewDataSource
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(15,5,70,16);
        label.numberOfLines = 0;
        [view addSubview:label];

        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"为你推荐" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
        label.attributedText = string;
        return view;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 30;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return _dataArray.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZBCommunityGuanZhuHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_h];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        return cell;
    }else{
        ZBCommunityGuanZhuCell *cell_new = [tableView dequeueReusableCellWithIdentifier:ID];
        cell_new.model = self.dataArray[indexPath.row];
        cell_new.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell_new;
        
    }
    return cell;
}


#pragma mark - 获取推荐用户信息
-(void)RefreshGuanZhu{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    [par setObject:appDelegate.mineUserInfoModel.userID forKey:@"userId"];
    

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://api.yysc.online/user/follow/getRecommandUserList" parameters:par headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = responseObject;
        NSString *success = [NSString stringWithFormat:@"%@",dict[@"success"]];
        NSDictionary *data = dict[@"data"];

               if ([success isEqualToString:@"1"]) {
                   
                
                   self.dataArray = [ZBCommunityGuanZhuModel mj_objectArrayWithKeyValuesArray:data];
            
                   [self.tableView reloadData];
                   
               }else{
                  [self.tableView reloadData];
               }
    } failure:nil];
     
    
}



@end
