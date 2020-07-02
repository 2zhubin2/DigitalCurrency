//
//  ZBBianJiZiLiaoViewController.m
//  DigitalCurrency
//
//  Created by HFY on 2020/7/2.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBBianJiZiLiaoViewController.h"

@interface ZBBianJiZiLiaoViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *topImageV;
@property (strong, nonatomic) IBOutlet UIImageView *bgImageV;
@property (strong, nonatomic) IBOutlet UITextField *sex_FV;

@end

@implementation ZBBianJiZiLiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStyleDone target:self action:@selector(backSetting)];
             self.navigationItem.leftBarButtonItem = leftItem;
             self.navigationItem.title = @"编辑资料";
    
    _topImageV.image = [UIImage imageNamed:@"morentouxiang2"];
    _bgImageV.image = [UIImage imageNamed:@"bg_bianjiziliao"];
    _topImageV.layer.cornerRadius = 50;
    }

-(void)backSetting{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)BeginEditingSex:(id)sender {
    
    [self selectSex];
    
}
- (IBAction)changeEdit:(id)sender {
    [self selectSex];
}


-(void)selectSex{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    actionSheet.title = @"选择性别";
    
    //修改标题的内容，字号，颜色。使用的key值是“attributedTitle”
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:@"选择性别"];
    [hogan addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, [[hogan string] length])];
    [hogan addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] range:NSMakeRange(0, [[hogan string] length])];
    [actionSheet setValue:hogan forKey:@"attributedTitle"];

    
    
     UIAlertAction *zeroAction = [UIAlertAction actionWithTitle:@"保密" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //        NSLog(@"点击了取消");
         self.sex_FV.text = @"保密";
     }];
    //修改按钮的颜色，同上可以使用同样的方法修改内容，样式
    [zeroAction setValue:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forKey:@"_titleTextColor"];
   
    
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"保密" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
//    [actionSheet setValue:string forKey:@"_attributedTitle"];

    
    
    
    
    UIAlertAction *OneAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"点击了取消");
        self.sex_FV.text = @"男";

    }];
    [OneAction setValue:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forKey:@"_titleTextColor"];
    
    UIAlertAction *twoAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    //        NSLog(@"点击了取消");
        self.sex_FV.text = @"女";

        }];
    [twoAction setValue:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forKey:@"_titleTextColor"];
    
    UIAlertAction *quexiaoAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        self.sex_FV.text = @"";
    }];
    [quexiaoAction setValue:[UIColor colorWithRed:50/255.0 green:83/255.0 blue:250/255.0 alpha:1.0] forKey:@"_titleTextColor"];
    
    /*
     UILabel *label = [[UILabel alloc] init];
     label.frame = CGRectMake(174,628.5,26.5,13);
     label.numberOfLines = 0;
     [self.view addSubview:label];

     NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"取消" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:50/255.0 green:83/255.0 blue:250/255.0 alpha:1.0]}];

     label.attributedText = string;
     */

//    [actionSheet addAction:cancel_action];
    [actionSheet addAction:zeroAction];
    [actionSheet addAction:OneAction];
    [actionSheet addAction:twoAction];
    [actionSheet addAction:quexiaoAction];
    [self presentViewController:actionSheet animated:YES completion:nil];
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
