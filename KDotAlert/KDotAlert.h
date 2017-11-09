//
//  KDotAlert.h
//  KDotAlert
//
//  Created by Crazy凡 on 09/11/2017.
//  Copyright © 2017 Crazy凡. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KDotAlert;

typedef KDotAlert * _Nonnull(^KDotAlertStringBlock)(NSString * _Nullable value);
typedef KDotAlert * _Nonnull(^KDotAlertActionBlock)(NSString * _Nonnull title, void (^ _Nullable hanlder)(UIAlertAction * _Nonnull action));
typedef KDotAlert * _Nonnull(^KDotAlertMakePreferredActionBlock)(void);
typedef KDotAlert * _Nonnull(^KDotAlertTextFieldBlock)(void (^ _Nullable hanlder)(UITextField * _Nonnull textField));
typedef KDotAlert * _Nonnull(^KDotAlertSubviewsBlock)(void (^ _Nullable hanlder)(NSArray<id> * _Nullable subViews));
typedef KDotAlert * _Nonnull(^KDotAlertShowBlock)(UIViewController * _Nonnull viewController, void (^ _Nullable completed)(void));

NS_CLASS_AVAILABLE_IOS(8_0) @interface KDotAlert : NSObject
@property (nonatomic, strong) KDotAlertStringBlock _Nullable title;             // set title
@property (nonatomic, strong) KDotAlertStringBlock _Nullable message;           // set message

@property (nonatomic, strong) KDotAlertActionBlock _Nullable defaultAction;     // add default Action
@property (nonatomic, strong) KDotAlertActionBlock _Nullable cancelAction;      // add cancel Action
@property (nonatomic, strong) KDotAlertActionBlock _Nullable destructiveAction; // add destructive Action
@property (nonatomic, strong) KDotAlertSubviewsBlock _Nullable actions;         // get all action
@property (nonatomic, strong) KDotAlertMakePreferredActionBlock _Nullable makePreferredAction NS_AVAILABLE_IOS(9_0);     // use follow addaction to  make preferredAction

@property (nonatomic, strong) KDotAlertTextFieldBlock _Nullable addTextField;   // add TextField can only use in alert;
@property (nonatomic, strong) KDotAlertSubviewsBlock _Nullable textFields;      // get all action

@property (nonatomic, strong) KDotAlertShowBlock _Nullable show;                // show with viewController


+ (instancetype _Nonnull )alert;
+ (instancetype _Nonnull )actionSheet;


- (KDotAlertStringBlock _Nullable )title;
- (KDotAlertStringBlock _Nullable )message;
- (KDotAlertActionBlock _Nullable )defaultAction;
- (KDotAlertActionBlock _Nullable )cancelAction;
- (KDotAlertActionBlock _Nullable )destructiveAction;
- (KDotAlertSubviewsBlock _Nullable )actions;
- (KDotAlertMakePreferredActionBlock _Nonnull )makePreferredAction NS_AVAILABLE_IOS(9_0);
- (KDotAlertTextFieldBlock _Nullable )addTextField;
- (KDotAlertSubviewsBlock _Nullable )textFields;
- (KDotAlertShowBlock _Nullable )show;

@end
