//
//  ZBForwardViewController.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/4.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBForwardViewController.h"

@interface ZBForwardViewController ()<UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *text_V;
@property (strong, nonatomic) IBOutlet UILabel *tishiLabel;

@end

@implementation ZBForwardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStyleDone target:self action:@selector(backMine)];
             self.navigationItem.leftBarButtonItem = leftItem;
             self.navigationItem.title = @"分享";
    self.navigationItem.rightBarButtonItem.title = @"更多";
    
    _text_V.delegate = self;
}

-(void)backMine{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}


- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"开始编辑");
    _tishiLabel.hidden = YES;
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
