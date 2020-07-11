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
#import "ZBFanKuiZXViewController.h"

@interface ZBDongTaiDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,ZBCommentHeaderCellDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *sousuobg_View;

@property(nonatomic,strong)NSMutableArray *comment_dataArray;

@property (strong, nonatomic) IBOutlet UIButton *CommentBtn;
@property (strong, nonatomic) IBOutlet UITextField *text_F;

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

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //初始化NavigationItem
    [self setupNavigationItem];
    
    
    //加载评论
    [self PLJson];
    
    //初始化tableView
    [self setupTableView];
    
    //添加通知及手势
    [self add_notifacationObserver];
    
    _sousuobg_View.layer.cornerRadius = 14;
}

#pragma mark - 初始化NavigationItem
-(void)setupNavigationItem{
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStyleDone target:self action:@selector(backMine)];
       self.navigationItem.leftBarButtonItem = leftItem;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([appDelegate.mineUserInfoModel.userID.stringValue isEqualToString:self.model.userId]){
        //
    }else{
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStyleDone target:self action:@selector(gengduo)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    self.navigationItem.title = @"动态详情";
}

#pragma mark - 点击更多
-(void)gengduo{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                  
        UIAlertAction *jubaoAction = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 
                ZBFanKuiZXViewController *vc = [ZBFanKuiZXViewController new];
                vc.model = self.model;
                [self.navigationController pushViewController:vc animated:YES];
                      
            }];
              
        UIAlertAction *pingbiAction = [UIAlertAction actionWithTitle:@"屏蔽" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if ([self.delegate respondsToSelector:@selector(DongTaiDetailViewControllerPingBi:)]) {
                        [self.delegate DongTaiDetailViewControllerPingBi:self.indexPath];
                    }
                    [self.navigationController popViewControllerAnimated:YES];
            }];
                  
              
        UIAlertAction *quexiaoAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

            }];

               [actionSheet addAction:jubaoAction];
               [actionSheet addAction:pingbiAction];
               [actionSheet addAction:quexiaoAction];
               [self presentViewController:actionSheet animated:YES completion:nil];
}

#pragma mark - 点击评论
- (IBAction)clickComment:(UIButton *)sender {
    
    if (self.text_F.text.length != 0) {
        [self ZBbeginFabuPL];
       
    }else{
        [MBProgressHUD showError:@"请输入评论内容"];
    }
    
}

#pragma mark - 发布评论功能
-(void)ZBbeginFabuPL{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
//    [par setObject:self.userID forKey:@"userId"];
 
    [par setObject:appDelegate.mineUserInfoModel.userID forKey:@"userId"];
    [par setObject:self.model.talkId forKey:@"talkId"];
    [par setObject:self.text_F.text forKey:@"content"];
    [par setObject:@"" forKey:@"video"];
    [par setObject:@"" forKey:@"matchId"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
   
    [manager POST:@"http://api.yysc.online/user/talk/commentTalk" parameters:par headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
        NSDictionary *data = responseObject;
//        NSLog(@"%@",data);
        NSString *success = [NSString stringWithFormat:@"%@",data[@"success"]];
        if ([success isEqualToString:@"1"]) {
            [MBProgressHUD showMessage:@"评论成功..."];
            
            //延时执行代码
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [MBProgressHUD hideHUD];
                self.text_F.text = @"";
                [self.view endEditing:YES];
                [self.navigationController popViewControllerAnimated:YES];
            
                });
        }else{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"评论失败，重新输入"];
        }
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [MBProgressHUD showError:@"网络错误"];
        }];
        
    
}

#pragma mark - 添加通知及手势
- (void)add_notifacationObserver{
    // 注册键盘弹起收回通知，使输入框位置于键盘上
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];//UIKeyboardDidShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];//UIKeyboardDidHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    // tableView不会响应touchesBegan，单独添加手势响应
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesturedDetected:)];
    tapGesture.delegate = self;
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeBack)];
    [self.view addGestureRecognizer:swipe];
//    [_tableView addGestureRecognizer:tapGesture];
}
-(void)swipeBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

-(void)backMine{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 初始化tableView
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        ZBCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_twe];
        cell.model = self.comment_dataArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
 
    [self.CommentBtn setTitleColor:[UIColor colorWithRed:50/255.0 green:83/255.0 blue:250/255.0 alpha:1.0] forState:UIControlStateNormal];
    self.CommentBtn.enabled = YES;
}

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


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

#pragma mark - ZBCommentHeaderCellDelegate

- (void)CommentHeaderCellClickFenXiang:(ZBCommentHeaderCell *)cell{
    
    ZBForwardViewController *vc = [[ZBForwardViewController alloc] init];
    vc.model = cell.model;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
