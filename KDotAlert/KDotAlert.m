//
//  KDotAlert.m
//  KDotAlert
//
//  Created by Crazy凡 on 09/11/2017.
//  Copyright © 2017 Crazy凡. All rights reserved.
//

#import "KDotAlert.h"

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

- (KDotAlertStringBlock)title {
    return ^(NSString *value) {
        _alertController.title = value;
        return self;
    };
}

- (KDotAlertStringBlock)message {
    return ^(NSString *value) {
        _alertController.message = value;
        return self;
    };
}

- (KDotAlertActionBlock)action {
    return [self defaultAction];
}

- (KDotAlertActionBlock)defaultAction {
    return ^(NSString * title, void (^ _Nullable hanlder)(UIAlertAction * _Nonnull action)) {
        NSAssert(title != nil, @"title cannot be nil.");
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:hanlder];
        [_alertController addAction:action];
        return self;
    };
}

- (KDotAlertActionBlock)cancel {
    return [self cancelAction];
}

- (KDotAlertActionBlock)cancelAction {
    return ^(NSString * title, void (^ _Nullable hanlder)(UIAlertAction * _Nonnull action)) {
        NSAssert(_isAddCancelAction == NO, @"You can only add cancelAction once!");
        NSAssert(title != nil, @"title cannot be nil.");
        _isAddCancelAction = YES;
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:hanlder];
        [_alertController addAction:action];
        return self;
    };
}

- (KDotAlertActionBlock)destructive {
    return [self destructiveAction];
}

- (KDotAlertActionBlock)destructiveAction {
    return ^(NSString * title, void (^ _Nullable hanlder)(UIAlertAction * _Nonnull action)) {
        NSAssert(title != nil, @"title cannot be nil.");
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDestructive handler:hanlder];
        [_alertController addAction:action];
        return self;
    };
}

- (KDotAlertSubviewsBlock)actions {
    return ^(void (^ _Nullable hanlder)(NSArray * _Nullable subViews)) {
        SAFE_BLOCK(hanlder)(_alertController.actions);
        return self;
    };
}

// equalto makePreferredAction
- (KDotAlertMakePreferredActionBlock _Nonnull )preferred {
    return [self makePreferredAction];
}

- (KDotAlertMakePreferredActionBlock)makePreferredAction {
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

- (KDotAlertTextFieldBlock)addTextField {
    return ^(void (^ _Nullable hanlder)(UITextField * _Nonnull textField)) {
        NSAssert(_alertController.preferredStyle == UIAlertControllerStyleAlert, @"addTextField only support UIAlertControllerStyleAlert");
        [_alertController addTextFieldWithConfigurationHandler:hanlder];
        return self;
    };
}

- (KDotAlertSubviewsBlock)textFields {
    return ^(void (^ _Nullable hanlder)(NSArray * _Nullable subViews)) {
        SAFE_BLOCK(hanlder)(_alertController.textFields);
        return self;
    };
}

- (KDotAlertShowBlock)show {
    return ^(UIViewController *viewController, id block) {
        NSAssert(viewController != nil, @"viewController connot be nil");
        [viewController presentViewController:_alertController animated:YES completion:block];
        return self;
    };
}

- (void)dealloc {
    NSLog(@"KDotAlert.dealloc");
}

@end
