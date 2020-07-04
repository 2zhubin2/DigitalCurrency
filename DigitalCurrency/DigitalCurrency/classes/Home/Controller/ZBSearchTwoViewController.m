//
//  ZBSearchTwoViewController.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/2.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBSearchTwoViewController.h"
#import "ZBCommunityGuanZhuCell.h"
#import "ZBCommunityTuiJianTableViewCell.h"
#import "ZBNewInformationTableViewCell.h"

@interface ZBSearchTwoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)UITableView *tableView;

@end

@implementation ZBSearchTwoViewController

static NSString *ID_one = @"CommunityGuanZhuCell";
static NSString *ID_two = @"CommunityTuiJianCell";
static NSString *ID_three = @"NewInformationCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupTableView];
}

-(void)setupTableView{
    
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
    
    [tableView registerNib:[UINib nibWithNibName:@"ZBCommunityGuanZhuCell" bundle:nil] forCellReuseIdentifier:ID_one];
    [tableView registerNib:[UINib nibWithNibName:@"ZBCommunityTuiJianTableViewCell" bundle:nil] forCellReuseIdentifier:ID_two];
    [tableView registerNib:[UINib nibWithNibName:@"ZBNewInformationTableViewCell" bundle:nil] forCellReuseIdentifier:ID_three];
    
       
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

#pragma mark - UItableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
    
        return 1;
    }else if (section == 1){
        return 1;
    }else{
        return 1;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
         UIView *view = [[UIView alloc] init];
           
           UILabel *label = [[UILabel alloc] init];
           label.frame = CGRectMake(15.5,15,24,13);
           label.numberOfLines = 0;
           [view addSubview:label];

           NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"用户" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];

           label.attributedText = string;
        return view;
    }else if (section == 1){
        UIView *view = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(15.5,15,25,13);
        label.numberOfLines = 0;
        [view addSubview:label];

        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"资讯" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];

        label.attributedText = string;
        return view;
    }else{
        return nil;
    }
   return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 || section ==1) {
        return 44;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ZBCommunityGuanZhuCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_one];
        return cell;
    }else if (indexPath.section == 1){
        ZBCommunityTuiJianTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_two];
        return cell;
    }else{
        ZBNewInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_three];
        return cell;
    }
    return nil;
}



@end
