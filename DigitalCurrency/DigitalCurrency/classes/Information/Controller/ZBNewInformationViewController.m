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
    // Do any additional setup after loading the view from its nib.
    
    
    //设置头部View
     [self setupHeaderView];
    

    
    //设置tableView
    [self setupTableView];
    
    
    
    
   
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    [self ZBLoadData:0];
    
}
-(void)setupHeaderView{
    

    ZBViewController *vc = [[ZBViewController alloc] init];
//    [self addChildViewController:vc];
    _headerView = vc.view;
    
   
}
-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    tableView.frame = CGRectMake(0, zbStatuBarH, zbStatuBarW, ZBScreenH - zbStatuBarH - 44 - 49);
       
    [tableView registerNib:[UINib nibWithNibName:@"ZBNewInformationTableViewCell" bundle:nil] forCellReuseIdentifier:ID];
       
      tableView.separatorStyle = UITableViewCellSelectionStyleNone;
      tableView.showsVerticalScrollIndicator = NO;
       tableView.showsHorizontalScrollIndicator = NO;
    tableView.tableHeaderView = _headerView;
    tableView.tableHeaderView.frame = CGRectMake(0, 0, 0, 200);
    tableView.delegate = self;
    tableView.dataSource = self;
        
       // 告诉tableView所有cell的真实高度是自动计算（根据设置的约束来计算）
       tableView.rowHeight = UITableViewAutomaticDimension;
       // 告诉tableView所有cell的估算高度
       tableView.estimatedRowHeight = 70;
       _tableView = tableView;
}

-(void)ZBLoadData:(int )page{
    
    
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
 
    [par setObject:[NSString stringWithFormat:@"%d",1 + page] forKey:@"pageNum"];
    [par setObject:@20 forKey:@"pageSize"];
    [par setObject:[NSDate date] forKey:@"date"];
    
  
    
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
   
    [manager GET:@"http://api.yysc.online/admin/getFinanceTalk" parameters:par headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            

       NSMutableArray *tempArray = [NSMutableArray new];

        tempArray = [ZBNewInformationModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.dataArray = tempArray;
        
        [self.tableView reloadData];
            
       
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //
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
 

    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZBInformationDetailHeaderVC *vc = [[ZBInformationDetailHeaderVC alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
