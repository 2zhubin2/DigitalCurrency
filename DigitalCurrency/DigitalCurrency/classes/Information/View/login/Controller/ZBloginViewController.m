//
//  ZBloginViewController.m
//  DigitalCurrency
//
//  Created by 朱彬 on 2020/6/29.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBloginViewController.h"

@interface ZBloginViewController ()
@property (strong, nonatomic) IBOutlet UIView *loginView;

@end

@implementation ZBloginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _loginView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0].CGColor;
    _loginView.layer.shadowOffset = CGSizeMake(2, 2);
    _loginView.layer.shadowOpacity = 1;
    _loginView.layer.shadowRadius = 5;
    _loginView.layer.cornerRadius = 10;
    
    
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
