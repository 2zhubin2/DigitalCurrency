//
//  ZBSetting_newVC.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/10.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBSetting_newVC.h"
#import "ZBsettingCell.h"
#import "ZBZhuXiaoViewController.h"
#import "ZBGuanYuWMViewController.h"
#import "ZBFanKuiZXViewController.h"
#import "ZBQieHuanZhangHaoViewController.h"
#import "ZBBianJiZiLiaoViewController.h"
#import "ZBResetPassWordViewController.h"
#import <SDImageCache.h>

@interface ZBSetting_newVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *bg_View;

@end

@implementation ZBSetting_newVC

static NSString *IDTwo = @"cellID";
static NSString *ID = @"settingCell";

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化NavigationItem
    [self setupNavigationItem];
    
    //设置阴影
    [self setupshadowColor];
    
    //初始化tablrView
    [self setupTableView];
}

#pragma mark - 初始化NavigationItem
-(void)setupNavigationItem{
    
     UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStyleDone target:self action:@selector(backMine)];
       self.navigationItem.leftBarButtonItem = leftItem;
       self.navigationItem.title = @"设置";
}

#pragma mark - 初始化tablrView
-(void)setupTableView{
    
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZBsettingCell class]) bundle:nil] forCellReuseIdentifier:ID];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.bounces = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    if (@available(iOS 13.0, *)) {
        
        //
        
    } else {
        _tableView.contentInset = UIEdgeInsetsMake(-60, 0, 0, 0);
    }
    
    
}


#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

-(void)backMine{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 退出登陆
- (IBAction)ClickTuichu:(UIButton *)sender {
    //清空用户数据
          NSError *error;
          NSFileManager *fileMger = [NSFileManager defaultManager];
          NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user.plist"];
          if ([fileMger removeItemAtPath:path error:&error]) {
              [[NSNotificationCenter defaultCenter] postNotificationName:@"tuichuLogin" object:self];
          }else{
              [[NSNotificationCenter defaultCenter] postNotificationName:@"tuichuLogin" object:self];
          }
       NSString *path_temp = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/user_temp.plist"];
       if ([fileMger removeItemAtPath:path_temp error:&error]) {
           //
       }
       [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 设置阴影
-(void)setupshadowColor{
    _bg_View.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.32].CGColor;
    _bg_View.layer.shadowOffset = CGSizeMake(2,2);
    _bg_View.layer.shadowOpacity = 1;
    _bg_View.layer.shadowRadius = 5;
     _bg_View.layer.cornerRadius = 5;
    
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
        return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
        ZBsettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        cell.num = indexPath.row;
         return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        ZBBianJiZiLiaoViewController *vc = [ZBBianJiZiLiaoViewController new];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 1){
        ZBResetPassWordViewController *vc = [ZBResetPassWordViewController new];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 2){
        ZBQieHuanZhangHaoViewController *vc= [[ZBQieHuanZhangHaoViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 3){
        ZBZhuXiaoViewController *vc = [[ZBZhuXiaoViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.row == 4){
        ZBGuanYuWMViewController *vc = [ZBGuanYuWMViewController new];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        //
    }
   
}


@end
