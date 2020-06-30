//
//  ZBMineViewController.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/6/29.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBMineViewController.h"
#import "ZBMineGuanZhuTableViewCell.h"

@interface ZBMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIButton *guanzhu_btn;
@property (strong, nonatomic) IBOutlet UIButton *fensi_btn;
@property (strong, nonatomic) IBOutlet UIButton *dongtai_btn;
@property(nonatomic,strong)UIButton *selectBtn;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ZBMineViewController

static NSString *ID_guanzhu = @"MineGuanZhuCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor = [UIColor grayColor];
    self.selectBtn = _guanzhu_btn;
    self.selectBtn.selected = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZBMineGuanZhuTableViewCell" bundle:nil] forCellReuseIdentifier:ID_guanzhu];
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
}


#pragma mark - tableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZBMineGuanZhuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_guanzhu];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

@end
