//
//  ZBMineViewController.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/6/29.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBMineViewController.h"
#import "ZBMineGuanZhuTableViewCell.h"
#import "ZBDongTaiTableViewCell.h"
#import "ZBSettingViewController.h"
#import "ZBSignInViewController.h"
#import "ZBloginViewController.h"
#import "ZBFreepwViewController.h"
#import "ZBFabuViewController.h"
#import "ZBBianJiZiLiaoViewController.h"
#import "ZBMineGuanZhuModel.h"
#import "ZBMineFenSiCell.h"
#import "ZBInformationDetailHeaderVC.h"
#import "ZBDongTaiDetailViewController.h"
#import "ZBCommunityTuiJianModel.h"
#import "ZBSetting_newVC.h"

@interface ZBMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIButton *guanzhu_btn;
@property (strong, nonatomic) IBOutlet UIButton *fensi_btn;
@property (strong, nonatomic) IBOutlet UIButton *dongtai_btn;
@property(nonatomic,strong)UIButton *selectBtn;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray_one;
@property(nonatomic,strong)NSMutableArray *dataArray_two;
@property(nonatomic,strong)NSMutableArray *dataArray_three;
@property(nonatomic,strong)NSMutableArray *dataArray_four;

@property (strong, nonatomic) IBOutlet UIButton *head_btn;
@property (strong, nonatomic) IBOutlet UILabel *NIckNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *signatureLabel;
@property(nonatomic,assign)int page;



@end

@implementation ZBMineViewController

static NSString *ID_guanzhu = @"MineGuanZhuCell";
static NSString *ID_dongtai = @"DongTaiCell";//MineFenSiCell
static NSString *ID_fensi = @"MineFenSiCell";

- (NSMutableArray *)dataArray_one{
    if (_dataArray_one == nil) {
        _dataArray_one = [NSMutableArray array];
    }
    return _dataArray_one;
}

- (NSMutableArray *)dataArray_two{
    if (_dataArray_two == nil) {
        _dataArray_two = [NSMutableArray array];
    }
    return _dataArray_two;
}

- (NSMutableArray *)dataArray_three{
    if (_dataArray_three == nil) {
        _dataArray_three = [NSMutableArray array];
    }
    return _dataArray_three;
}

- (void)viewWillAppear:(BOOL)animated{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"MineShow" object:nil];
    self.page = 0;
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.login == YES) {
        [self ZBLoadData_one:0];
        if (![appDelegate.mineUserInfoModel.head containsString:@"<html>"] && appDelegate.mineUserInfoModel.head.length != 0) {
            [_head_btn sd_setBackgroundImageWithURL:[NSURL URLWithString:appDelegate.mineUserInfoModel.head] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"morentouxiang"]];
        }
        
        _NIckNameLabel.text = appDelegate.mineUserInfoModel.nickName;
        _signatureLabel.text = appDelegate.mineUserInfoModel.signature;
    }else{
        [_head_btn setImage:nil forState:UIControlStateNormal];
        _NIckNameLabel.text = @"";
        _signatureLabel.text = @"";
        [_head_btn setBackgroundImage:[UIImage imageNamed:@"morentouxiang"] forState:UIControlStateNormal];
        _dataArray_one = nil;
        _dataArray_two = nil;
        _dataArray_three = nil;
        [self.tableView reloadData];
    }
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;

    
    //初始化页数
       _page = 0;
    
     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.login == YES) {
        [self ZBLoadData_one:0];
    }
    _head_btn.layer.cornerRadius = 33;
    _head_btn.clipsToBounds = YES;
 
    
    
    self.selectBtn = _guanzhu_btn;
    self.selectBtn.selected = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZBMineGuanZhuTableViewCell" bundle:nil] forCellReuseIdentifier:ID_guanzhu];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZBDongTaiTableViewCell" bundle:nil] forCellReuseIdentifier:ID_dongtai];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZBMineFenSiCell" bundle:nil] forCellReuseIdentifier:ID_fensi];
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    // 告诉tableView所有cell的真实高度是自动计算（根据设置的约束来计算）
    self.tableView.rowHeight = UITableViewAutomaticDimension;
   // 告诉tableView所有cell的估算高度
   self.tableView.estimatedRowHeight = 70;
    
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
    
   
    [self notificationCenterConfig];
    
}


-(void)refresh
{
    self.page = 0;
   switch (self.selectBtn.tag - 666) {
       case 0:
           [self ZBLoadData_one:self.page];
           break;
       case 1:
           [self ZBLoadData_two:self.page];
           break;
       case 2:
           [self ZBLoadData_three:@1];
           break;
       default:
           break;
   }
   
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
            });
        
    }else{
        switch (self.selectBtn.tag - 666) {
              case 0:
                  [self ZBLoadData_one:self.page];
                  break;
              case 1:
                  [self ZBLoadData_two:self.page];
                  break;
              case 2:
                  [self ZBLoadData_three:@1];
                  break;
              default:
                  break;
          }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshing];
           });
        _page+=1;
    }
    
}



- (IBAction)clickHead:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (appDelegate.login == YES) {
        ZBBianJiZiLiaoViewController *vc = [ZBBianJiZiLiaoViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        ZBloginViewController *vc = [[ZBloginViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}



- (IBAction)clickSetting:(id)sender {
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (appDelegate.login == YES) {
//        ZBSettingViewController *vc = [[ZBSettingViewController alloc] init];
        ZBSetting_newVC *vc = [[ZBSetting_newVC alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        ZBloginViewController *vc = [[ZBloginViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

- (IBAction)guanzhuClick:(UIButton *)sender {
    [self selButton:sender];
     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.login == YES) {
        [self ZBLoadData_one:0];
    }
   
    
}

- (IBAction)fensiClick:(UIButton *)sender {
    [self selButton:sender];
  
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
       if (appDelegate.login == YES) {
        [self ZBLoadData_two:0];
       }
}


- (IBAction)dongtaiClick:(UIButton *)sender {
     [self selButton:sender];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.login == YES) {
        [self ZBLoadData_three:@1];
    }
    
}

- (IBAction)ClickSignIn:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (appDelegate.login == YES) {
         ZBSignInViewController *vc = [[ZBSignInViewController alloc] init];
           
           [self.navigationController pushViewController:vc animated:YES];
    }else{
        ZBloginViewController *vc = [[ZBloginViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    

}


-(void)selButton:(UIButton *)btn{
    
   
    self.selectBtn.selected = !self.selectBtn.isSelected;
    btn.selected = YES;
    self.selectBtn = btn;
    [self.tableView reloadData];
}


#pragma mark - 加载数据
-(void)ZBLoadData_one:(int )page{
    
     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    [par setValue:appDelegate.mineUserInfoModel.userID forKey:@"userId"];
//    [par setObject:appDelegate.mineUserInfoModel.userID forKey:@"userId"];
//    NSLog(@"%@",appDelegate.mineUserInfoModel.userID);
    [par setObject:@1 forKey:@"type"];
    [par setObject:[NSString stringWithFormat:@"%d",1 + page] forKey:@"pageNumber"];
    [par setObject:@10 forKey:@"pageSize"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://api.yysc.online/user/follow/getUserFollowList" parameters:par headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            

       NSMutableArray *tempArray = [NSMutableArray new];
//
        tempArray = [ZBMineGuanZhuModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
//        self.dataArray = tempArray;
        if (page == 0) {
            self.dataArray_one = tempArray;
        }else{
            [self.dataArray_one addObjectsFromArray:tempArray];
        }
        
        [self.tableView reloadData];
   
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD showError:@"网络错误"];
        }];
        
    
}

-(void)ZBLoadData_two:(int )page{
    
     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    [par setObject:appDelegate.mineUserInfoModel.userID forKey:@"userId"];
    [par setObject:@2 forKey:@"type"];
    [par setObject:[NSString stringWithFormat:@"%d",1 + page] forKey:@"pageNumber"];
    [par setObject:@10 forKey:@"pageSize"];
  
    
  
    
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
   
    [manager GET:@"http://api.yysc.online/user/follow/getUserFollowList" parameters:par headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            

       NSMutableArray *tempArray = [NSMutableArray new];
        tempArray = [ZBMineGuanZhuModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        
        if (page == 0) {
            self.dataArray_two = tempArray;
               }else{
                   [self.dataArray_two addObjectsFromArray:tempArray];
               }
        self.dataArray_two = tempArray;
        [self.tableView reloadData];
            
       
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD showError:@"网络错误"];
        }];
        
    
}

#pragma mark - 获取发布的动态
-(void)ZBLoadData_three:(NSNumber *)page
{
    
     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    WEAKSELF
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    AFJSONResponseSerializer *response   = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    response.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/html",@"text/css",@"text/javascript", nil];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"Referer"];
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer = response;
    NSString *url = [NSString stringWithFormat:@"http://api.yysc.online/user/talk/getTalkList/%@",appDelegate.mineUserInfoModel.userID];
    [manager POST:url parameters:@{
        @"_orderByDesc" : @"publishTime",
        @"userId" : appDelegate.mineUserInfoModel.userID,
        @"_pageSize" : @10,
        @"_pageNumber" : page
    } headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(responseObject != nil){
//            weakSelf.dataArray_three = [MTLJSONAdapter modelsOfClass:[PopularNewsModel class] fromJSONArray:responseObject[@"data"][@"list"] error:&error];
            self.dataArray_three = [ZBDongTaiModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            self.dataArray_four = [ZBCommunityTuiJianModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网络错误"];
    }];
    /*
    [manager POST:@"http://api.yysc.online/user/talk/getTalkList/0" parameters:@{
        @"_orderByDesc" : @"publishTime",
        @"userId" : appDelegate.mineUserInfoModel.userID,
        @"_pageSize" : pageSize
    }
         progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(responseObject != nil){
            NSError *error;
            weakSelf.dataArray_three = [MTLJSONAdapter modelsOfClass:[PopularNewsModel class] fromJSONArray:responseObject[@"data"][@"list"] error:&error];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网络错误"];
    }];*/
}



#pragma mark - tableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (self.selectBtn.tag - 666) {
        case 0:
            return self.dataArray_one.count;
            break;
        case 1:
            return self.dataArray_two.count;
            break;
        case 2:
            return self.dataArray_three.count;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZBMineGuanZhuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_guanzhu];
    ZBDongTaiTableViewCell *cell_dt = [tableView dequeueReusableCellWithIdentifier:ID_dongtai];
    ZBMineFenSiCell *cell_fs = [tableView dequeueReusableCellWithIdentifier:ID_fensi];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell_dt.selectionStyle = UITableViewCellSelectionStyleNone;
    cell_fs.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (self.selectBtn.tag - 666) {
        case 0:
            cell.model = self.dataArray_one[indexPath.row];
        return cell;
            break;
        case 1:
            cell_fs.model = self.dataArray_two[indexPath.row];
            return cell_fs;
            break;
        case 2:
            cell_dt.model = self.dataArray_three[indexPath.row];
            return cell_dt;
            break;
        default:
            break;
    }
    
//    ZBMineGuanZhuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_guanzhu];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if ((self.selectBtn.tag - 666) == 2) {
       ZBDongTaiDetailViewController *vc = [[ZBDongTaiDetailViewController alloc] init];
        vc.model = self.dataArray_four[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 通知相关
- (void)notificationCenterConfig{
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(justPush:) name:kNotificationMessagePush object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(justPush:) name:@"jumpFabu3"object:nil];
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
