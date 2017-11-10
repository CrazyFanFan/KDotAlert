//
//  BaseViewController.h
//  KDotAlertDemo
//
//  Created by Crazy凡 on 09/11/2017.
//  Copyright © 2017 Crazy凡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KDotAlert/KDotAlert.h>

@interface BaseViewController : UIViewController
@property (nonatomic, strong) UITextView *textView;
- (void)showAlertView;
- (void)showMore:(NSString *)string;
@end
