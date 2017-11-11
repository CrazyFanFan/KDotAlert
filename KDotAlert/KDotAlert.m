//
//  KDotAlert.m
//  KDotAlert
//
//  Created by Crazy凡 on 09/11/2017.
//  Copyright © 2017 Crazy凡. All rights reserved.
//

#import "KDotAlert.h"

double KDotAlertVersionNumber = 0.1;
const unsigned char KDotAlertVersionString[] = "0.1";

#define SAFE_BLOCK(KDotBlock) if(KDotBlock) KDotBlock

@interface KDotAlert ()
@property (nonatomic, strong) UIAlertController *alertController;
@property (nonatomic, assign) BOOL isAddCancelAction;
@end

@implementation KDotAlert

+ (instancetype)alert {
    return [[KDotAlert alloc] initWithStyle:UIAlertControllerStyleAlert];
}

+ (instancetype)actionSheet {
    return [[KDotAlert alloc] initWithStyle:UIAlertControllerStyleActionSheet];
}

- (instancetype)initWithStyle:(UIAlertControllerStyle)style;
{
    if (self) {
        _alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:style];
    }
    return self;
}

- (KDotAlertFormat)format {
    return ^(NSString *title, NSString *message) {
        _alertController.title = title;
        _alertController.message = message;
        return self;
    };
}

- (KDotAlertAction)action {
    return ^(NSString * title, void (^ _Nullable hanlder)(UIAlertAction * _Nonnull action)) {
        NSAssert(title != nil, @"title cannot be nil.");
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:hanlder];
        [_alertController addAction:action];
        return self;
    };
}

- (KDotAlertAction)cancel {
    return ^(NSString * title, void (^ _Nullable hanlder)(UIAlertAction * _Nonnull action)) {
        NSAssert(_isAddCancelAction == NO, @"You can only add cancelAction once!");
        NSAssert(title != nil, @"title cannot be nil.");
        _isAddCancelAction = YES;
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:hanlder];
        [_alertController addAction:action];
        return self;
    };
}

- (KDotAlertAction)destructive {
    return ^(NSString * title, void (^ _Nullable hanlder)(UIAlertAction * _Nonnull action)) {
        NSAssert(title != nil, @"title cannot be nil.");
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDestructive handler:hanlder];
        [_alertController addAction:action];
        return self;
    };
}

- (NSArray<UIAlertAction *> *)actions {
    return _alertController.actions;
}

// equalto makePreferredAction
- (KDotAlertPreferred _Nonnull )preferred {
    return ^(void) {
        if (@available(iOS 9.0, *)) {
            _alertController.preferredAction = _alertController.actions.lastObject;
        } else {
            // Fallback on earlier versions
            NSAssert(NO, @"makePreferredAction only support iOS9 or later");
        }
        return self;
    };
}

- (KDotAlertTextField)textField {
    return ^(void (^ _Nullable hanlder)(UITextField * _Nonnull textField)) {
        NSAssert(_alertController.preferredStyle == UIAlertControllerStyleAlert, @"addTextField only support UIAlertControllerStyleAlert");
        [_alertController addTextFieldWithConfigurationHandler:hanlder];
        return self;
    };
}

- (NSArray<UITextField *> *)textFields {
    return _alertController.textFields;
}

- (KDotAlertShow)show {
    return ^(UIViewController *viewController, id block) {
        NSAssert(viewController != nil, @"viewController connot be nil");
        [viewController presentViewController:_alertController animated:YES completion:block];
        return self;
    };
}

- (void)dealloc {
    NSLog(@"KDotAlert.dealloc:%@", _alertController.title);
}

@end
