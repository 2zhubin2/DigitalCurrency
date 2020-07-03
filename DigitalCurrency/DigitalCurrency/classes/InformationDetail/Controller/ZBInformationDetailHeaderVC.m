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

@interface ZBInformationDetailHeaderVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ZBInformationDetailHeaderVC

//InformationDetail_one,  NewInformationCell , CommentCell
static NSString *ID_one = @"InformationDetail_one";
static NSString *ID_two = @"NewInformationCell";
static NSString *ID_three = @"CommentCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupTableView];
}
- (IBAction)ClickBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden  = YES;
}

-(void)setupTableView{
   
        
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"pic_zhidingzx"];
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
    return 3;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        UIView *view = [[UIView alloc] init];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(16.5,10,310,20);
        label.numberOfLines = 0;
        [view addSubview:label];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"区块链知识普及：虚拟货币≠数字货币" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 18],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];

        label.attributedText = string;
        
        return view;
        
    }else if (section == 1){
        UIView *view = [[UIView alloc] init];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(15.5,10,200,12);
        label.numberOfLines = 0;
        [view addSubview:label];

        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"相关推荐" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];

        label.attributedText = string;
        
         return view;
        
        
    }else{
        UIView *view = [[UIView alloc] init];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(15,10,200,12);
        label.numberOfLines = 0;
        [view addSubview:label];

        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"评论区（1280条）" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];

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
        case 2:
            return 10;
            break;
        default:
            break;
    }
    return 0;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        ZBInformationDetail_oneCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_one];
            
        return cell;
    }else if (indexPath.section == 1){
        ZBNewInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_two];
        
        return cell;
    }else{
        ZBCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_three];
        
        return cell;
    }
    return nil;
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
