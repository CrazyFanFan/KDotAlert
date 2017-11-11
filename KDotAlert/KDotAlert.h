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
typedef KDotAlert * _Nonnull(^ _Nonnull KDotAlertShow)(UIViewController * _Nonnull withViewController, KDotAlertShowCompleted completed);

NS_CLASS_AVAILABLE_IOS(8_0) @interface KDotAlert : NSObject

@property (nonatomic, strong, readonly) KDotAlertFormat format;         // format title & message
@property (nonatomic, strong, readonly) NSString * _Nullable title;     // title
@property (nonatomic, strong, readonly) NSString * _Nullable message;   // message
@property (nonatomic, assign, readonly) UIAlertControllerStyle preferredStyle;  // The style of the alert controller.

@property (nonatomic, strong, readonly) KDotAlertAction action;     // Attaches an action object to the alert or action sheet. default style;
@property (nonatomic, strong, readonly) KDotAlertAction cancel;     // ... cancel style;
@property (nonatomic, strong, readonly) KDotAlertAction destructive;// ... destructive style;

// The actions that the user can take in response to the alert or action sheet.
@property (nonatomic, strong, readonly) NSArray<UIAlertAction *> * _Nullable actions;

// Make the preferred action for the user to take from an alert.
@property (nonatomic, strong, readonly) KDotAlertPreferred preferred NS_AVAILABLE_IOS(9_0);


@property (nonatomic, strong, readonly) KDotAlertTextField  textField;                  // Adds a text field to an alert;
@property (nonatomic, strong, readonly) NSArray<UITextField *> * _Nullable textFields;  // The array of text fields displayed by the alert.

@property (nonatomic, strong, readonly) KDotAlertShow show; // show with viewController

+ (instancetype _Nonnull )alert;
+ (instancetype _Nonnull )actionSheet;

@end
