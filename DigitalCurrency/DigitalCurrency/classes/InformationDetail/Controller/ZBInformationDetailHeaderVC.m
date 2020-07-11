//
//  ZBInformationDetailHeaderVC.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/3.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBInformationDetailHeaderVC.h"
#import "ZBInformationDetail_oneCell.h"
#import "ZBNewInformationTableViewCell.h"
#import "ZBCommentCell.h"
#import "ZBCommentDetailViewController.h"
#import "ZBForwardViewController.h"

@interface ZBInformationDetailHeaderVC ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *sousuoText_F;
@property (strong, nonatomic) IBOutlet UIView *sousuobg_View;

@end

@implementation ZBInformationDetailHeaderVC

static NSString *ID_one = @"InformationDetail_one";
static NSString *ID_two = @"NewInformationCell";
static NSString *ID_three = @"CommentCell";

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _sousuobg_View.layer.cornerRadius = 20;
    
    //初始化tableView
    [self setupTableView];
    
    //添加通知及手势
    [self add_notifacationObserver];
    
}

#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden  = YES;
}

#pragma mark - 点击返回
- (IBAction)ClickBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 添加通知及手势
- (void)add_notifacationObserver{
  
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBack)];
    [self.view addGestureRecognizer:swipe];
}

#pragma mark - 清扫返回
-(void)swipeBack{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 初始化tableView
-(void)setupTableView{
   
        
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"pic_dongtai1"];
    imageView.contentMode = UIViewContentModeScaleToFill;
    _tableView.tableHeaderView = imageView;
    _tableView.tableHeaderView.frame = CGRectMake(0, 0, 0, 150);
    
    
    [_tableView registerNib:[UINib nibWithNibName:@"ZBInformationDetail_oneCell" bundle:nil] forCellReuseIdentifier:ID_one];
    [_tableView registerNib:[UINib nibWithNibName:@"ZBNewInformationTableViewCell" bundle:nil] forCellReuseIdentifier:ID_two];
    [_tableView registerNib:[UINib nibWithNibName:@"ZBCommentCell" bundle:nil] forCellReuseIdentifier:ID_three];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
        
       // 告诉tableView所有cell的真实高度是自动计算（根据设置的约束来计算）
       _tableView.rowHeight = UITableViewAutomaticDimension;
       // 告诉tableView所有cell的估算高度
       _tableView.estimatedRowHeight = 70;
}



#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        UIView *view = [[UIView alloc] init];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(16.5,20,310,20);
        label.numberOfLines = 0;
        [view addSubview:label];
        NSString *title = [NSString string];
        if (self.typeFlag == YES) {
            title = @"热点资讯";
        }else{
            title = @"精选好文";
        }
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 18],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];

        label.attributedText = string;
        
        return view;
        
    }else{
        UIView *view = [[UIView alloc] init];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(15.5,10,200,12);
        label.numberOfLines = 0;
        [view addSubview:label];

        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"相关推荐" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];

        label.attributedText = string;
        
         return view;
    }

    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
//        case 2:
//            return 10;
//            break;
        default:
            break;
    }
    return 0;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        ZBInformationDetail_oneCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_one];
        cell.model = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        ZBNewInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_two];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}






@end
