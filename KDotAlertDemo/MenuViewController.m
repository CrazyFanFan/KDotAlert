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
                         @{ TITLEKEY : @"ActionSheet",
                            SELECTOR : @"actionSheet",
                            },
                         @{ TITLEKEY : @"MakePreferredAction",
                            SELECTOR : @"makePreferredAction",
                            },
                         @{ TITLEKEY : @"UseAlertInBlock",
                            SELECTOR : @"useAlertInBlock",
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
        _textView.text = [_textView.text stringByAppendingFormat:@"%@ : %@ \n",[self currentTimeString], string];
        [_textView scrollRangeToVisible:NSMakeRange(_textView.text.length, 1)];
    }
}

- (NSString *)currentTimeString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

- (void)alert{
    [KDotAlert alert].format(@"Alert", @"This is Alert")
    .action(@"OK", ^(UIAlertAction * _Nonnull action) {
        [self showMore:@"OK"];
    }).show(self, ^{
        [self showMore:@"Alert is show"];
    });
}

- (void)cancel {
    [KDotAlert alert].format(@"Cancel", @"This is Cancel")
    .action(@"OK", ^(UIAlertAction * _Nonnull action) {
        [self showMore:@"OK"];
    }).cancel(@"Cancel", ^(UIAlertAction * _Nonnull action) {
        [self showMore:@"Cancel"];
    }).show(self, ^{
        [self showMore:@"Alert is show"];
    });
}

- (void)destructive {
    [KDotAlert alert].format(@"Destructive", @"This is Destructive")
    .action(@"OK", ^(UIAlertAction * _Nonnull action) {
        [self showMore:@"OK"];
    }).cancel(@"Cancel", ^(UIAlertAction * _Nonnull action) {
        [self showMore:@"Cancel"];
    }).destructive(@"Destructive", ^(UIAlertAction * _Nonnull action) {
        [self showMore:@"Destructive"];
    }).show(self, ^{
        [self showMore:@"Alert is show"];
    });
}

- (void)texFeiled {
    __block KDotAlert *alert = [KDotAlert alert];

    alert.format(@"TextField", @"This is TextField")
    .textField(^(UITextField * _Nonnull textField) {
        textField.placeholder = @"textField";
    }).action(@"OK", ^(UIAlertAction * _Nonnull action) {
        [self showMore:alert.textFields.firstObject.text];
        [self showMore:@"OK"];
    }).cancel(@"Cancel", ^(UIAlertAction * _Nonnull action) {
        [self showMore:@"Cancel"];
    }).destructive(@"Destructive", ^(UIAlertAction * _Nonnull action) {
        [self showMore:@"Destructive"];
    }).show(self, ^{
        [self showMore:@"Alert is show"];
    });
}

- (void)actionSheet {
    [KDotAlert actionSheet].format(@"Sheet", @"This is actionSheet")
    .action(@"OK", ^(UIAlertAction * _Nonnull action) {
        [self showMore:@"OK"];
    }).cancel(@"Cancel", ^(UIAlertAction * _Nonnull action) {

    }).destructive(@"destructiveAction", ^(UIAlertAction * _Nonnull action) {

    }).show(self, nil);
}

- (void)makePreferredAction {
    if (@available(iOS 9.0, *)) {
        [KDotAlert alert].format(@"MakePreferredAction", @"This is action").action(@"OK", nil).cancel(@"Cancel", nil).destructive(@"destructive", nil).preferred().show(self, nil);
    } else {
        // Fallback on earlier versions
    }
}

- (void)useAlertInBlock {
    __block KDotAlert *alert = [KDotAlert alert];
    alert.format(@"UseAlertInBlock", @"This is useAlertInBlock")
    .action(@"OK", ^(UIAlertAction * _Nonnull action) {
        [self showMore:[NSString stringWithFormat:@"Alert have %lu Actions", alert.actions.count]];
    })
    .cancel(@"cancel", nil)
    .show(self, nil);
}

@end
