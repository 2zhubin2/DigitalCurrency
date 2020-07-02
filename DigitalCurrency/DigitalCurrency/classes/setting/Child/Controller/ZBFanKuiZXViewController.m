//
//  ZBFanKuiZXViewController.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/7/2.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBFanKuiZXViewController.h"

@interface ZBFanKuiZXViewController ()<UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *text_FV;
@property (strong, nonatomic) IBOutlet UILabel *TiShiLabel;
@property (strong, nonatomic) IBOutlet UILabel *CountLabel;

@end

@implementation ZBFanKuiZXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStyleDone target:self action:@selector(backSetting)];
          self.navigationItem.leftBarButtonItem = leftItem;
          self.navigationItem.title = @"反馈中心";
    _text_FV.delegate = self;
    
    
    [self setupShadowColor];
    
}

-(void)backSetting{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setupShadowColor{
    _text_FV.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.32].CGColor;
    _text_FV.layer.shadowOffset = CGSizeMake(2,2);
    _text_FV.layer.shadowOpacity = 1;
    _text_FV.layer.shadowRadius = 5;
    _text_FV.layer.cornerRadius = 5;
}

- (IBAction)tijiaoClick:(id)sender {
}




- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"开始编辑");
    _TiShiLabel.hidden = YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    _CountLabel.text = [NSString stringWithFormat:@"%ld",_text_FV.text.length];
    
    if (_text_FV.text.length <= 300) {
        _text_FV.editable = YES;
    }else{
        _text_FV.editable = NO;
    }
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
