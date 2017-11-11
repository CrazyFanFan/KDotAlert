# KDotAlert

An easy way to use UIAlertController.

### Get Start


    #import <KDotAlert/KDotAlert.h>

    [KDotAlert alert].format(@"Alert", @"There is Alert")
    .action(@"OK", ^(UIAlertAction * _Nonnull action) {
        [self showMore:@"OK"];  // self is safe
    }).show(self, ^{
        [self showMore:@"Alert is show"]; 
    });

