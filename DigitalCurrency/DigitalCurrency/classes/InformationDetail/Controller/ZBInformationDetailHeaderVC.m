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

//InformationDetail_one,  NewInformationCell , CommentCell
static NSString *ID_one = @"InformationDetail_one";
static NSString *ID_two = @"NewInformationCell";
static NSString *ID_three = @"CommentCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _sousuobg_View.layer.cornerRadius = 20;
    
    [self setupTableView];
    
    [self add_notifacationObserver];
    
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden  = YES;
}
- (IBAction)ClickBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)add_notifacationObserver{
    // 注册键盘弹起收回通知，使输入框位置于键盘上
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // tableView不会响应touchesBegan，单独添加手势响应
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesturedDetected:)];
    tapGesture.delegate = self;
//    [_tableView addGestureRecognizer:tapGesture];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



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
    /*else{
        UIView *view = [[UIView alloc] init];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(15,10,200,12);
        label.numberOfLines = 0;
        [view addSubview:label];

        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"评论区（1280条）" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];

        label.attributedText = string;
        
         return view;
        
    }*/
    
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

- (IBAction)Comment_F:(UITextField *)sender {
    
    [sender resignFirstResponder];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];

}
- (IBAction)cilckFenXiang:(id)sender {
    
    ZBForwardViewController *vc = [[ZBForwardViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}
/*
 // 注册键盘弹起收回通知，使输入框位置于键盘上
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
   // tableView不会响应touchesBegan，单独添加手势响应
   UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesturedDetected:)]; // 手势类型随你喜欢。
 */



 #pragma mark - 键盘弹出
 - (void)keyboardWillShow:(NSNotification *)notification
 {
     NSDictionary *userInfo = [notification userInfo];
     //获取键盘弹出的时间
     double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
     //获取键盘上端Y坐标
     CGFloat keyboardY = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
     //获取输入框下端相对于window的Y坐标
     CGRect rect = [self.sousuobg_View convertRect:self.sousuobg_View.bounds toView:[[[UIApplication sharedApplication] delegate] window]];
     CGPoint tmp = rect.origin;
     CGFloat inputBoxY = tmp.y + self.sousuobg_View.frame.size.height;
     //计算二者差值
     CGFloat ty = keyboardY - inputBoxY;
//     NSLog(@"position keyboard: %f, inputbox: %f, ty: %f", keyboardY, inputBoxY, ty);
     //差值小于0，做平移变换
     [UIView animateWithDuration:duration animations:^{
         if (ty < 0) {
             self.view.transform = CGAffineTransformMakeTranslation(0, ty);
         }
     }];
     
 }

 #pragma mark - 键盘消失
 - (void)keyboardWillHide:(NSNotification *)notification
 {
     //获取键盘弹出的时间
     double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
     //还原
     [UIView animateWithDuration:duration animations:^{
         self.view.transform = CGAffineTransformMakeTranslation(0, 0);
     }];
 }

 #pragma mark - 点击屏幕其它地方关闭键盘
 - (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     [self.view endEditing:YES];
 }

 - (void)tapGesturedDetected:(UITapGestureRecognizer *)recognizer

 {
     [self.view endEditing:YES];
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
