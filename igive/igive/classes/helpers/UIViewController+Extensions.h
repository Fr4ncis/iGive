//
//  UIViewController+Extensions.h
//  igive
//
//  Created by Samuel Colak on 7/22/12.
//  Copyright (c) 2012 Im-At-Home BV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface UIViewController (Extensions) <MFMessageComposeViewControllerDelegate>

    - (void) sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients;

    - (void) smsMessageSent;
    - (void) smsMessageCancelled;
    - (void) smsMessageFailed;

@end
