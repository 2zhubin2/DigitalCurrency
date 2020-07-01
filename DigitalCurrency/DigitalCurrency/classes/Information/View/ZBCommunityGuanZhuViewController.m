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

@interface ZBCommunityGuanZhuViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)UITableView *tableView;

@end

@implementation ZBCommunityGuanZhuViewController

//CommunityGuanZhuHeader
//CommunityGuanZhuCell
static NSString *ID_h = @"CommunityGuanZhuHeader";
static NSString *ID = @"CommunityGuanZhuCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
    
    [self setupTableView];
    
}


-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    tableView.frame = CGRectMake(0, 0, zbStatuBarW, ZBScreenH - zbStatuBarH - 44 - 49);
       
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
        return 10;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZBCommunityGuanZhuHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_h];
    if (indexPath.section == 0) {
        return cell;
    }else{
        ZBCommunityGuanZhuCell *cell_new = [tableView dequeueReusableCellWithIdentifier:ID];
        return cell_new;
        
    }
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
