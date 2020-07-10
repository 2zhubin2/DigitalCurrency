//
//  ZBCommunityTuiJianViewController.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/1.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBCommunityTuiJianViewController.h"
#import "ZBCommunityTuiJianTableViewCell.h"
#import "ZBDongTaiDetailViewController.h"
#import "ZBCommunityTuiJianModel.h"
#import "ZBCommunityTuiJianUserModel.h"



@interface ZBCommunityTuiJianViewController ()<UITableViewDelegate,UITableViewDataSource,ZBDongTaiDetailViewControllerDelegate>

@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)int page;

@end

@implementation ZBCommunityTuiJianViewController

//CommunityTuiJianCell
static NSString *ID = @"CommunityTuiJianCell";

- (NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    _page = 0;
    [self ZBLoadData:0];
    // Do any additional setup after loading the view from its nib.
    [self setupTableView];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    self.page = 0;
    [self.tableView.mj_footer resetNoMoreData];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
       if (appDelegate.login == YES) {
//           [self ZBLoadData:0];
       }else{
           self.dataArray = nil;
           [self.tableView reloadData];
       }
    
    
}

-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    tableView.frame = CGRectMake(0, 0, zbStatuBarW, ZBScreenH - zbStatuBarH - 44 - 49 -44);
       
    [tableView registerNib:[UINib nibWithNibName:@"ZBCommunityTuiJianTableViewCell" bundle:nil] forCellReuseIdentifier:ID];
       
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
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.login == YES) {
        [self ZBLoadData:0];
        self.page = 0;
        [self.tableView.mj_footer resetNoMoreData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
           });
    }else{
        self.dataArray = nil;
        [self.tableView reloadData];
        [MBProgressHUD showError:@"请登录"];
        [self.tableView.mj_header endRefreshing];
      
    }
    
    
}

#pragma  mark - 下拉加载
-(void)loadMore
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.login == YES) {
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
    }else{
        self.dataArray = nil;
        [self.tableView reloadData];
        [MBProgressHUD showError:@"请登录"];
        [self.tableView.mj_footer endRefreshing];
    }
    
    
}




#pragma mark -加载网络数据
-(void)ZBLoadData:(int )page{
    
    
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
 
    [par setObject:[NSString stringWithFormat:@"%d",1 + page] forKey:@"pageNumber"];
    [par setObject:@10 forKey:@"pageSize"];
    [par setObject:@"futures" forKey:@"project"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
   
    [manager GET:@"http://api.yysc.online/user/talk/getTalkListByProject" parameters:par headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
        NSDictionary *data = responseObject;
        NSMutableArray *tempArray = [NSMutableArray new];
        tempArray = [ZBCommunityTuiJianModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"list"]];
        
        if (page == 0) {
            self.dataArray = tempArray;
        }else{
            [self.dataArray addObjectsFromArray:tempArray];
        }
//        self.dataArray = tempArray;
        
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
    
    ZBCommunityTuiJianTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    NSLog(@"%ld",_dataArray.count);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZBDongTaiDetailViewController *vc = [[ZBDongTaiDetailViewController alloc] init];
    vc.delegate = self;
    vc.model = self.dataArray[indexPath.row];
    vc.indexPath = indexPath;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - ZBDongTaiDetailViewControllerDelegate

- (void)DongTaiDetailViewControllerPingBi:(NSIndexPath *)indexPath{
    [self.dataArray removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
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
