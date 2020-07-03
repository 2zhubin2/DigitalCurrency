//
//  ZBDongTaiDetailViewController.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/3.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBDongTaiDetailViewController.h"
#import "ZBCommentCell.h"
#import "ZBCommentHeaderCell.h"

@interface ZBDongTaiDetailViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ZBDongTaiDetailViewController

//CommentCell  ,CommentHeader,Comment_one
static NSString *ID_one = @"CommentHeader";
static NSString *ID_twe = @"CommentCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStyleDone target:self action:@selector(backMine)];
       self.navigationItem.leftBarButtonItem = leftItem;
       self.navigationItem.title = @"动态详情";
    
    [self setupTableView];
}


- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

-(void)backMine{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setupTableView{
   
        
       
    [_tableView registerNib:[UINib nibWithNibName:@"ZBCommentHeaderCell" bundle:nil] forCellReuseIdentifier:ID_one];
    [_tableView registerNib:[UINib nibWithNibName:@"ZBCommentCell" bundle:nil] forCellReuseIdentifier:ID_twe];
//    [_tableView registerNib:[UINib nibWithNibName:@"ZBComment_oneCell" bundle:nil] forCellReuseIdentifier:ID_twe];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else{
        return 10;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
         UIView *view = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(15,10,200,14);
        label.numberOfLines = 0;
        [view addSubview:label];

        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"评论区（30条）" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];

        label.attributedText = string;
        
        return view;
        
    }
   
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 44;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        ZBCommentHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_one];
        
        return cell;
    }else{
        ZBCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_twe];
        
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
