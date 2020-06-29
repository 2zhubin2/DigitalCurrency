//
//  ZBFreepwViewController.m
//  DigitalCurrency
//
//  Created by HFY on 2020/6/29.
//  Copyright © 2020 朱彬. All rights reserved.
//

#import "ZBFreepwViewController.h"
#import "ZBimageCodeViewController.h"

@interface ZBFreepwViewController ()

@end

@implementation ZBFreepwViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)ClickGetCode:(id)sender {
    
    ZBimageCodeViewController *vc = [[ZBimageCodeViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    
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
