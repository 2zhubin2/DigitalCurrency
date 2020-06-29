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
    /*
     UIView *view = [[UIView alloc] init];
     view.frame = CGRectMake(15,186,345,256);
     view.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
     view.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.32].CGColor;
     view.layer.shadowOffset = CGSizeMake(2,2);
     view.layer.shadowOpacity = 1;
     view.layer.shadowRadius = 5;
     UIView *viewShadow1 = [[UIView alloc] init];
     viewShadow1.frame = CGRectMake(15,186,345,256);
     viewShadow1.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
     viewShadow1.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
     viewShadow1.layer.shadowOffset = CGSizeMake(-2, -2);
     viewShadow1.layer.shadowOpacity = 1;
     viewShadow1.layer.shadowRadius = 5;

     [self.view bringSubviewToFront:view];
     view.layer.cornerRadius = 10;
     */
    _loginView.layer.shadowColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0].CGColor;
    _loginView.layer.shadowOffset = CGSizeMake(2, 2);
    _loginView.layer.shadowOpacity = 1;
    _loginView.layer.shadowRadius = 5;
    
    
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
