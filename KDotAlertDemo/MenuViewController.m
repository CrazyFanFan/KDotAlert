//
//  MenuViewController.m
//  KDotAlertDemo
//
//  Created by Crazy凡 on 09/11/2017.
//  Copyright © 2017 Crazy凡. All rights reserved.
//

#import "MenuViewController.h"
#import <KDotAlert/KDotAlert.h>

#define TITLEKEY @"A"
#define SELECTOR @"B"

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
    Stuff; \
    _Pragma("clang diagnostic pop") \
} while (0)

static NSString *CELL_REUSE_UDENTIDIER = @"cell";

@interface MenuViewController ()
@property (nonatomic, strong) NSArray<NSDictionary *> *viewControllers;
@property (nonatomic, strong) UITextView *textView;
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CELL_REUSE_UDENTIDIER];

    _viewControllers = @[
                         @{ TITLEKEY : @"Alert",
                            SELECTOR : @"alert",
                            },
                         @{ TITLEKEY : @"Cancel",
                            SELECTOR : @"cancel",
                            },
                         @{ TITLEKEY : @"Destructive",
                            SELECTOR : @"destructive",
                            },
                         @{ TITLEKEY : @"TexFeiled",
                            SELECTOR : @"texFeiled",
                            },

                         ];
    CGRect frame = self.view.bounds;
    frame.size.height = 100;
    _textView = [[UITextView alloc] initWithFrame:frame];
    _textView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.tableHeaderView = _textView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    return _viewControllers.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_REUSE_UDENTIDIER forIndexPath:indexPath];

    if (indexPath.row < _viewControllers.count) {
        cell.textLabel.text = _viewControllers[indexPath.row][TITLEKEY];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row < _viewControllers.count) {
        NSString *selectorName = _viewControllers[indexPath.row][SELECTOR];
        SuppressPerformSelectorLeakWarning( [self performSelector:NSSelectorFromString(selectorName)];);
    }
}

- (void)showMore:(NSString *)string {
    if (string) {
        _textView.text = [_textView.text stringByAppendingFormat:@"%@ : %@",[self currentTimeString], string];
        [_textView scrollRangeToVisible:NSMakeRange(_textView.text.length, 1)];
    }
}

- (NSString *)currentTimeString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

- (void)alert{
    [KDotAlert alert].format(@"Alert", @"There is Alert")
    .defaultAction(@"OK", ^(UIAlertAction * _Nonnull action) {
        [self showMore:@"OK\n"];
    }).show(self, ^{
        [self showMore:@"Alert is show\n"];
    });
}

- (void)cancel {
    [KDotAlert alert].format(@"Cancel", @"There is Cancel")
    .action(@"OK", ^(UIAlertAction * _Nonnull action) {
        [self showMore:@"OK\n"];
    }).cancel(@"Cancel", ^(UIAlertAction * _Nonnull action) {
        [self showMore:@"Cancel\n"];
    }).show(self, ^{
        [self showMore:@"Alert is show\n"];
    });
}

- (void)destructive {
    [KDotAlert alert].format(@"Destructive", @"There is Destructive")
    .action(@"OK", ^(UIAlertAction * _Nonnull action) {
        [self showMore:@"OK\n"];
    }).cancel(@"Cancel", ^(UIAlertAction * _Nonnull action) {
        [self showMore:@"Cancel\n"];
    }).destructive(@"Destructive", ^(UIAlertAction * _Nonnull action) {
        [self showMore:@"Destructive\n"];
    }).show(self, ^{
        [self showMore:@"Alert is show\n"];
    });
}

- (void)texFeiled {
    __block KDotAlert *alert = [KDotAlert alert];

    alert.format(@"TextField", @"There is TextField")
    .addTextField(^(UITextField * _Nonnull textField) {
        textField.placeholder = @"textField";
    }).action(@"OK", ^(UIAlertAction * _Nonnull action) {
        [self showMore:alert.textFields.firstObject.text];
        [self showMore:@"OK\n"];
        alert = nil;
    }).cancel(@"Cancel", ^(UIAlertAction * _Nonnull action) {
        [self showMore:@"Cancel\n"];
    }).destructive(@"Destructive", ^(UIAlertAction * _Nonnull action) {
        [self showMore:@"Destructive\n"];
    }).show(self, ^{
        [self showMore:@"Alert is show\n"];
    });
}


@end
