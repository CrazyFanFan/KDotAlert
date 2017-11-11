//
//  AlertMessageViewController.m
//  KDotAlertDemo
//
//  Created by Crazy凡 on 09/11/2017.
//  Copyright © 2017 Crazy凡. All rights reserved.
//

#import "AlertMessageViewController.h"

@interface AlertMessageViewController ()

@end

@implementation AlertMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAlertView {
    [KDotAlert alert].format(@"Title", @"There is message")
    .action(@"OK", ^(UIAlertAction * _Nonnull action) {
        [self showMore:@"OK\n"];
    }).show(self, ^{
        [self showMore:@"Alert is show\n"];
    });
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
