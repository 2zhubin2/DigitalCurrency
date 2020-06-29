//
//  ZBHomeViewController.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/6/29.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBHomeViewController.h"
#import "ZBHomeTableViewCell.h"

@interface ZBHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIImageView *search_backImageView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *tab_back_view;

@end

@implementation ZBHomeViewController

static NSString *ID = @"HomeCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _search_backImageView.image = [UIImage imageNamed:@"bg_search1"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"ZBHomeTableViewCell" bundle:nil] forCellReuseIdentifier:ID];
    
    /*
     UIView *view = [[UIView alloc] init];
     view.frame = CGRectMake(15,324,345,446);
     view.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
     view.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.32].CGColor;
     view.layer.shadowOffset = CGSizeMake(2,2);
     view.layer.shadowOpacity = 1;
     view.layer.shadowRadius = 5;
     UIView *viewShadow1 = [[UIView alloc] init];
     viewShadow1.frame = CGRectMake(15,324,345,446);
     viewShadow1.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
     viewShadow1.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
     viewShadow1.layer.shadowOffset = CGSizeMake(-2, -2);
     viewShadow1.layer.shadowOpacity = 1;
     viewShadow1.layer.shadowRadius = 5;

     [self.view bringSubviewToFront:view];
     view.layer.cornerRadius = 10;
     */
    _tab_back_view.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.32].CGColor;
    _tab_back_view.layer.shadowOffset = CGSizeMake(2,2);
    _tab_back_view.layer.shadowOpacity = 1;
    _tab_back_view.layer.shadowRadius = 5;
    _tab_back_view.layer.cornerRadius = 10;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZBHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 63;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];

    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10,10,70,14.5);
    label.numberOfLines = 0;
    [view addSubview:label];

    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"行情涨跌" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];

    label.attributedText = string;
    
    return view;
    
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
