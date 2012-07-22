//
//  UIViewController+Extensions.m
//  igive
//
//  Created by Samuel Colak on 7/22/12.
//  Copyright (c) 2012 Im-At-Home BV. All rights reserved.
//

#import "UIViewController+Extensions.h"

@implementation UIViewController (Extensions)

    - (void) sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
    {
        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
        if([MFMessageComposeViewController canSendText])
        {
            controller.body = bodyOfMessage;
            controller.recipients = recipients;
            controller.messageComposeDelegate = self;
            [self presentModalViewController:controller animated:YES];
        }
    }

    - (void) smsMessageCancelled
    {
        NSLog(@"Message cancelled");        
    }

    - (void) smsMessageSent
    {
        NSLog(@"Message sent");        
    }

    - (void) smsMessageFailed
    {
        NSLog(@"Message failed");
    }

    - (void) messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
    {
        [self dismissModalViewControllerAnimated:YES];
        if (result == MessageComposeResultCancelled)
            [self smsMessageCancelled];
        else if (result == MessageComposeResultSent)
            [self smsMessageSent];
        else
            [self smsMessageFailed];
    }

@end
