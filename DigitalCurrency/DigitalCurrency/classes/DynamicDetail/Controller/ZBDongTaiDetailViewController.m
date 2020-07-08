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
#import "ZBcommmentModel.h"
#import "ZBcommentTalkModel.h"
#import "ZBForwardViewController.h"

@interface ZBDongTaiDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,ZBCommentHeaderCellDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *sousuobg_View;

@property(nonatomic,strong)NSMutableArray *comment_dataArray;

@property (strong, nonatomic) IBOutlet UIButton *CommentBtn;

@end

@implementation ZBDongTaiDetailViewController

//CommentCell  ,CommentHeader,Comment_one
static NSString *ID_one = @"CommentHeader";
static NSString *ID_twe = @"CommentCell";

- (NSMutableArray *)comment_dataArray{
    if (_comment_dataArray == nil) {
        _comment_dataArray = [NSMutableArray array];
    }
    return _comment_dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStyleDone target:self action:@selector(backMine)];
       self.navigationItem.leftBarButtonItem = leftItem;
       self.navigationItem.title = @"动态详情";
    
    [self PLJson];
    
    [self setupTableView];
//    [self PLJson];
    [self add_notifacationObserver];
    
    _sousuobg_View.layer.cornerRadius = 14;
}



- (void)add_notifacationObserver{
    // 注册键盘弹起收回通知，使输入框位置于键盘上
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];//UIKeyboardDidShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];//UIKeyboardDidHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    // tableView不会响应touchesBegan，单独添加手势响应
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesturedDetected:)];
    tapGesture.delegate = self;
//    [_tableView addGestureRecognizer:tapGesture];
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

#pragma mark - 加载评论
-(void)PLJson{
     NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://api.yysc.online"] sessionConfiguration:configuration];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    AFJSONResponseSerializer *response   = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    response.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/html",@"text/css",@"text/javascript", nil];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"Referer"];
    // 设置超时时间
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
 
    //根据用户的talkId加载详情界面的评论
    [manager POST:@"/user/talk/getCommentList" parameters:@{@"_orderByDesc":@"publishTime",@"talkId": _model.talkId} headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable result) {


        self.comment_dataArray = [ZBcommmentModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"list"]];

        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
    }];
    
    
}


#pragma mark - tableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else{
        return self.comment_dataArray.count;
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
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"评论区（%ld条）",self.comment_dataArray.count] attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];

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
        cell.delegate = self;
        cell.model = self.model;
        return cell;
    }else{
        ZBCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_twe];
        cell.model = self.comment_dataArray[indexPath.row];
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}


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

-(void)keyboardDidShow:(NSNotification *)notifition{
    /*
     UILabel *label = [[UILabel alloc] init];
     label.frame = CGRectMake(311.5,1204.5,29,14.5);
     label.numberOfLines = 0;
     [self.view addSubview:label];

     NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"发送" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:50/255.0 green:83/255.0 blue:250/255.0 alpha:1.0]}];

     label.attributedText = string;
     */
    [self.CommentBtn setTitleColor:[UIColor colorWithRed:50/255.0 green:83/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateNormal];
    self.CommentBtn.enabled = YES;
}//keyboardDidHide:

-(void)keyboardDidHide:(NSNotification *)notifition{
   
//    [self.CommentBtn setTitleColor:[UIColor colorWithRed:50/255.0 green:83/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateNormal];
    self.CommentBtn.enabled = NO;
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


#pragma mark - ZBCommentHeaderCellDelegate

- (void)CommentHeaderCellClickFenXiang:(ZBCommentHeaderCell *)cell{
    
    ZBForwardViewController *vc = [[ZBForwardViewController alloc] init];
    vc.model = cell.model;
    [self.navigationController pushViewController:vc animated:YES];
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
