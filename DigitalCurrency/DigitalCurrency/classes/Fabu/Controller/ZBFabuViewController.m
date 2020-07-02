//
//  ZBFabuViewController.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/6/29.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBFabuViewController.h"

@interface ZBFabuViewController ()<UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *TiShiLabel;
@property (strong, nonatomic) IBOutlet UITextView *text_FV;

@end

@implementation ZBFabuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStyleDone target:self action:@selector(backSetting)];
                self.navigationItem.leftBarButtonItem = leftItem;
                self.navigationItem.title = @"发布";
    
    self.text_FV.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
       self.tabBarController.tabBar.hidden = YES;
}

-(void)backSetting{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"开始编辑");
    _TiShiLabel.hidden = YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    //
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
