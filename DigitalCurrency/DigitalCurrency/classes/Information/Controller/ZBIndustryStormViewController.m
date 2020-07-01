//
//  ZBIndustryStormViewController.m
//  DigitalCurrency
//
//  Created by HFY on 2020/6/30.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBIndustryStormViewController.h"
#import "ZBIndustryStormTableViewCell.h"

@interface ZBIndustryStormViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)UITableView *tableView;

@end

@implementation ZBIndustryStormViewController

//IndustryStormCell
static NSString *ID = @"IndustryStormCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        self.view.backgroundColor = [UIColor lightGrayColor];
    //设置tableView
    [self setupTableView];
    
    //设置头部view
    [self setup_headerView];
}

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
}

-(void)setup_headerView{
     UIView *view = [[UIView alloc] init];
     UILabel *label = [[UILabel alloc] init];
     label.frame = CGRectMake(10,5,148,11);
     label.numberOfLines = 0;
     [view addSubview:label];

     NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"2020年6月16日  今天  星期二" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 11],NSForegroundColorAttributeName: [UIColor colorWithRed:50/255.0 green:83/255.0 blue:249/255.0 alpha:1.0]}];

     label.attributedText = string;
    
    _tableView.tableHeaderView = view;
    _tableView.tableHeaderView.frame = CGRectMake(0, 0, 0, 20);
     
}

#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZBIndustryStormTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    return cell;
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
