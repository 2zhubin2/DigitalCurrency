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

@interface ZBMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIButton *guanzhu_btn;
@property (strong, nonatomic) IBOutlet UIButton *fensi_btn;
@property (strong, nonatomic) IBOutlet UIButton *dongtai_btn;
@property(nonatomic,strong)UIButton *selectBtn;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ZBMineViewController

static NSString *ID_guanzhu = @"MineGuanZhuCell";
static NSString *ID_dongtai = @"DongTaiCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor = [UIColor grayColor];
    self.selectBtn = _guanzhu_btn;
    self.selectBtn.selected = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZBMineGuanZhuTableViewCell" bundle:nil] forCellReuseIdentifier:ID_guanzhu];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZBDongTaiTableViewCell" bundle:nil] forCellReuseIdentifier:ID_dongtai];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    // 告诉tableView所有cell的真实高度是自动计算（根据设置的约束来计算）
    self.tableView.rowHeight = UITableViewAutomaticDimension;
   // 告诉tableView所有cell的估算高度
   self.tableView.estimatedRowHeight = 70;
}

- (IBAction)guanzhuClick:(UIButton *)sender {
    [self selButton:sender];
    
}

- (IBAction)fensiClick:(UIButton *)sender {
    [self selButton:sender];
    
}


- (IBAction)dongtaiClick:(UIButton *)sender {
     [self selButton:sender];
    
}



-(void)selButton:(UIButton *)btn{
    
   
    self.selectBtn.selected = !self.selectBtn.isSelected;
    btn.selected = YES;
    self.selectBtn = btn;
    [self.tableView reloadData];
}


#pragma mark - tableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (self.selectBtn.tag - 666) {
        case 0:
            return 6;
            break;
        case 1:
            return 5;
            break;
        case 2:
            return 4;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZBMineGuanZhuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_guanzhu];
    ZBDongTaiTableViewCell *cell_dt = [tableView dequeueReusableCellWithIdentifier:ID_dongtai];
    switch (self.selectBtn.tag - 666) {
        case 0:
        return cell;
            break;
        case 1:
            return cell;
            break;
        case 2:
            return cell_dt;
            break;
        default:
            break;
    }
    
//    ZBMineGuanZhuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_guanzhu];
    
    return cell;
}


@end
