//
//  KDotAlert.h
//  KDotAlert
//
//  Created by Crazy凡 on 10/11/2017.
//  Copyright © 2017 Crazy凡. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for KDotAlert.
FOUNDATION_EXPORT double KDotAlertVersionNumber;

//! Project version string for KDotAlert.
FOUNDATION_EXPORT const unsigned char KDotAlertVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <KDotAlert/PublicHeader.h>

@class KDotAlert;

typedef KDotAlert * _Nonnull(^ _Nonnull KDotAlertFormat)(NSString * _Nullable title, NSString * _Nullable value);

typedef void(^ _Nullable KDotAlertActionHanlder)(UIAlertAction * _Nonnull action);
typedef KDotAlert * _Nonnull(^ _Nonnull KDotAlertAction)(NSString * _Nonnull title, KDotAlertActionHanlder hanlder);

typedef KDotAlert * _Nonnull(^ _Nonnull KDotAlertPreferred)(void);

typedef void(^ _Nullable KDotAlertTextFieldHanlder)(UITextField * _Nonnull textField);
typedef KDotAlert * _Nonnull(^ _Nonnull KDotAlertTextField)(KDotAlertTextFieldHanlder hanlder);

typedef void(^ _Nullable KDotAlertShowCompleted)(void);
typedef KDotAlert * _Nonnull(^ _Nonnull KDotAlertShowBlock)(UIViewController * _Nonnull viewController, KDotAlertShowCompleted completed);



NS_CLASS_AVAILABLE_IOS(8_0) @interface KDotAlert : NSObject
@property (nonatomic, strong, readonly, getter=format) KDotAlertFormat formatTitleAndMesage;    // set title

@property (nonatomic, strong, readonly, getter=action) KDotAlertAction defaultAction;           // add default Action
@property (nonatomic, strong, readonly, getter=cancel) KDotAlertAction cancelAction;            // add cancel Action
@property (nonatomic, strong, readonly, getter=destructive) KDotAlertAction  destructiveAction; // add destructive Action

// use follow addaction to  make preferredAction
@property (nonatomic, strong, readonly, getter=preferred) KDotAlertPreferred  makePreferredAction NS_AVAILABLE_IOS(9_0);
@property (nonatomic, strong, readonly) NSArray<UIAlertAction *> * _Nullable actions;       // get all action  makepreferredAction

@property (nonatomic, strong, readonly, getter=textField) KDotAlertTextField  addTextField; // add TextField can only use in alert;
@property (nonatomic, strong, readonly) NSArray<UITextField *> * _Nullable textFields;      // get all action

@property (nonatomic, strong, readonly) KDotAlertShowBlock show;    // show with viewController

+ (instancetype _Nonnull )alert;
+ (instancetype _Nonnull )actionSheet;

@end
