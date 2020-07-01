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

@interface ZBNewInformationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)UIView *headerView;
@property(nonatomic,weak)UITableView *tableView;


@end

@implementation ZBNewInformationViewController

//NewInformationCell
static NSString *ID = @"NewInformationCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        
   //设置头部View
    [self setupHeaderView];
    
    //设置tableView
    [self setupTableView];
    
    
    
   
}

-(void)setupHeaderView{
    
//    self.view.backgroundColor = [UIColor blueColor];
    ZBViewController *vc = [[ZBViewController alloc] init];
    [self addChildViewController:vc];
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

#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZBNewInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    return cell;
}



@end
